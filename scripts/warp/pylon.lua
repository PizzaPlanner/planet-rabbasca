local M = require("__planet-rabbasca__.scripts.warp.warp_chunks")

local status_invalid_target = {
    diode = defines.entity_status_diode.yellow,
    label = { "entity-status.rabbasca-warp-no-target" }
}
local status_no_builder = {
    diode = defines.entity_status_diode.red,
    label = { "entity-status.rabbasca-warp-no-builder" }
}
local status_no_items = {
    diode = defines.entity_status_diode.yellow,
    label = { "entity-status.rabbasca-warp-no-items" }
}
local status_ok = {
    diode = defines.entity_status_diode.green,
    label = { "entity-status.rabbasca-warp-ok" }
}

local function play_smoke(surface, position, size)
    rendering.draw_animation{
        animation = "rabbasca-warp-smoke",
        x_scale = size,
        y_scale = size,
        render_layer = "smoke",
        time_to_live = 32,
        target = position,
        surface = surface
    }
end

local function try_deconstruct(data, name, quality, inventory)
    if not data.entity.to_be_deconstructed() then return false, status_invalid_target end
    local entity = data.entity
    if not data.is_tile then
        for k = 1, entity.get_max_inventory_index() do 
            local spill_inventory = entity.get_inventory(k)
            if spill_inventory then entity.surface.spill_inventory { position = entity.position, inventory = spill_inventory } end
        end
        local surface, position, size = entity.surface, entity.position, 1
        local result = entity.mine{ inventory = inventory }
        if result then 
            play_smoke(surface, position, size)
            return true
        else
            return false, status_invalid_target
        end
    else
        local name, count  = data.name, data.count
        local inserted = inventory.insert({name = name, count = count})
        if inserted == count then
            local hidden = entity.hidden_tile
            local hidden_2 = entity.double_hidden_tile
            local surface = entity.surface
            local pos = entity.position
            surface.set_tiles({{position = pos, name = hidden or "out-of-map"}})
            surface.set_hidden_tile(pos, hidden_2)
            surface.set_double_hidden_tile(pos, nil)
            play_smoke(surface, pos, 1)
            return true
        end
        inventory.remove({name = name, count = inserted})
        return false, status_invalid_target
    end

end

local function clear_plans(request, inventory, index)
    local old_plans = request.insert_plan
    for i, plan in pairs(old_plans) do
        for j, ii in pairs(plan.items.in_inventory) do
            if ii.inventory == inventory and ii.stack == index then
                plan.items.in_inventory[j] = nil
                table.remove(plan.items.in_inventory, j)
            end
        end
        if #plan.items.in_inventory == 0 then
            old_plans[i] = nil
            table.remove(old_plans, i)
        end
    end
    request.insert_plan = old_plans

    local old_plans = request.removal_plan
    for i, plan in pairs(old_plans) do
        for j, ii in pairs(plan.items.in_inventory) do
            if ii.inventory == inventory and ii.stack == index then
                plan.items.in_inventory[j] = nil
                table.remove(plan.items.in_inventory, j)
            end
        end
        if #plan.items.in_inventory == 0 then
            old_plans[i] = nil
            table.remove(old_plans, i)
        end
    end
    request.removal_plan = old_plans
end

local function try_warp_module(data, name, quality, inventory)
    local request = data.entity
    local target = request.proxy_target
    if not target then return false, status_invalid_target end
    for _, plan in pairs(request.insert_plan) do
        if plan.items.in_inventory then
            local name, quality = plan.id.name, plan.id.quality or "normal"
            for i, stack in pairs(plan.items.in_inventory) do
                local item_with_quality = { name = name, quality = quality }
                local inventory_id, where, count = stack.inventory, stack.stack, stack.count or 1
                -- TODO: Restrict to modules? Note: inventory defines overlap between type, need to check type as well
                local target_inventory = target.get_inventory(inventory_id)
                if target_inventory and inventory.get_item_count(item_with_quality) >= count then
                    local removed = inventory.remove({name = name, count = count, quality = quality})
                    local temp = game.create_inventory(1)
                    temp.insert({name = name, count = removed, quality = quality})
                    if target_inventory[where + 1].swap_stack(temp[1]) then
                        target.surface.spill_inventory { position = target.position, inventory = temp }
                        temp.destroy()
                        clear_plans(request, inventory_id, where)
                        play_smoke(target.surface, target.position, 1)
                        return true, status_ok
                    end
                end
            end
        end
    end
    for _, player in pairs(target.force.players) do
        player.add_alert(target, defines.alert_type.no_material_for_construction)
    end
    return false, status_no_items
end

local function try_upgrade(data, name, quality, inventory)
    local entity, count = data.entity, data.count
    local new_proto, new_quality = entity.get_upgrade_target()
    if not new_proto then return false end
    if new_proto.name ~= data.name or new_quality.name ~= data.quality then return end -- upgrade changed since indexing?
    local proto_old = entity.prototype
    local to_place_old = proto_old.items_to_place_this and proto_old.items_to_place_this[1]
    if not to_place_old then return false end
    local old_name, old_count, old_quality = to_place_old.name, to_place_old.count, entity.quality.name
    local old_item = { name = old_name, count = old_count, quality = old_quality }
    if not inventory.can_insert(old_item) then return end
    local upgraded, _ = entity.apply_upgrade()
    if upgraded == nil then return false end
    inventory.remove({ name = data.name, count = count, quality = data.quality })
    inventory.insert(old_item)
    return true, status_ok
end

local function try_build_ghost(data, name, quality, inventory)
    local entity, count = data.entity, data.count

    local removed = inventory.remove({name = name, count = count, quality = quality})
    local temp = game.create_inventory(255)
    local surface, position = entity.surface, entity.position
    local result = entity.revive{ raise_revive = true, overflow = temp }
    surface.spill_inventory { position = position, inventory = temp }
    temp.destroy()
    if not result then
        inventory.insert({name = name, count = removed, quality = quality})
        return false -- maybe missing tiles below etc. NOT invalid target
    end
    play_smoke(surface, position, 1)
    return true, status_ok
end

local function remove_entity(queue, name, quality, i)
    table.remove(queue[name][quality], i)
    if next(queue[name][quality]) == nil then
        queue[name][quality] = nil
    end
    if next(queue[name]) == nil then
        queue[name] = nil
    end
end

local function attempt_warp(pylon, q, inventory, f)
    local id = pylon.unit_number
    local pdata = storage.warp_storage[id]
    for _, chunkid in pairs(pdata.chunks) do
        local queue = storage.warp_chunks[pylon.surface_index][chunkid].queue[q]
        for name, qq in pairs(queue) do
            for quality, entries in pairs(qq) do
                local has = q == "modules" and 1 or q == "decon" and 1 or inventory.get_item_count({ name = name, quality = quality })
                if has > 0 then
                    for i, data in pairs(entries) do
                        local pos_a = data.position
                        local pos_b = pdata.position
                        local range = pdata.range
                        local in_range = math.abs(pos_a.x - pos_b.x) <= range and math.abs(pos_a.y - pos_b.y) <= range
                        if has >= data.count and data.entity.valid and in_range then
                            local result, status = f(data, name, quality, inventory)
                            pylon.custom_status = status
                            if q ~= "modules" then remove_entity(queue, name, quality, i) end
                            if result then return true end
                            M.mark_chunk_dirty(pylon.surface_index, chunkid, 30 * 60) -- If failed, try again in 30 seconds
                        end
                    end
                end
            end
        end
    end
    return false
end

function M.attempt_build_ghost(pylon)
    if not (storage.rabbasca_remote_builder and storage.rabbasca_remote_builder.valid and not storage.rabbasca_remote_builder.to_be_deconstructed()) then
        local builders = (game.surfaces.rabbasca and game.surfaces.rabbasca.find_entities_filtered{name = "rabbasca-warp-cargo-pad", to_be_deconstructed = false}) or { }
        if #builders > 0 then
            storage.rabbasca_remote_builder = builders[1]
        else
            pylon.set_recipe(nil)
            pylon.recipe_locked = true
            pylon.custom_status = status_no_builder
            return
        end
    end

    local inventory = storage.rabbasca_remote_builder.get_inventory(defines.inventory.chest)
    if  (pylon.force.recipes["rabbasca-warp-sequence-reverse"].enabled and attempt_warp(pylon, "decon", inventory, try_deconstruct)) or
        (pylon.force.recipes["rabbasca-warp-sequence-tile"].enabled and attempt_warp(pylon, "tiles", inventory, try_build_ghost)) or
        (pylon.force.recipes["rabbasca-warp-sequence-building"].enabled and attempt_warp(pylon, "ghosts", inventory, try_build_ghost)) or
        (pylon.force.recipes["rabbasca-warp-sequence-upgrade"].enabled and attempt_warp(pylon, "upgrades", inventory, try_upgrade)) or
        (pylon.force.recipes["rabbasca-warp-sequence-module"].enabled and attempt_warp(pylon, "modules", inventory, try_warp_module))
    then
        pylon.set_recipe("rabbasca-warp-sequence-building")
    else 
        local id = pylon.unit_number
        for _, chunkid in pairs(storage.warp_storage[id].chunks) do
            for _, queue in pairs(storage.warp_chunks[pylon.surface_index][chunkid].queue) do
                if next(queue) ~= nil then
                    pylon.set_recipe("rabbasca-remote-warmup")
                    return
                end
            end
            -- confirm actually empty
            M.mark_chunk_dirty(pylon.surface_index, chunkid)
        end
        pylon.set_recipe(nil)
        pylon.recipe_locked = true
    end
end

return M