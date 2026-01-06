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

local function try_deconstruct(data, inventory)
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

local function try_warp_module(data, inventory)
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

local function try_build_ghost(data, inventory)
    local entity, name, count, quality = data.entity, data.name, data.count, data.entity.quality.name
    local item_with_quality = { name = name, quality = quality }

    if inventory.get_item_count(item_with_quality) >= count then
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
    for _, player in pairs(entity.force.players) do
        player.add_alert(entity, defines.alert_type.no_material_for_construction)
    end
    return false, status_no_items
end

function M.attempt_warmup(pylon)
    local id = pylon.unit_number
    local queue = storage.warp_storage[id] and storage.warp_storage[id].queue
    if not queue then
        pylon.set_recipe(nil)
        pylon.recipe_locked = true
        return
    end
    local is_any_success = false
    for _, data in pairs({
        { queue = queue.decon, recipe = "rabbasca-warp-sequence-reverse" },
        { queue = queue.tiles, recipe = "rabbasca-warp-sequence-tile" },
        { queue = queue.ghosts, recipe = "rabbasca-warp-sequence-building" },
        { queue = queue.modules, recipe = "rabbasca-warp-sequence-module" },
    }) do
        if #data.queue.targets > 0 and data.queue.success and pylon.force.recipes[data.recipe] then
            pylon.set_recipe(data.recipe)
            pylon.recipe_locked = true
            return true
        elseif data.queue.success and #data.queue.targets > 0 then
            is_any_success = true
        end
    end

    if not is_any_success then
        queue.decon.success   = true
        queue.tiles.success   = true
        queue.ghosts.success  = true
        queue.modules.success = true
        M.reset_module_queue(pylon, queue)
        pylon.set_recipe("rabbasca-remote-warmup")
        pylon.recipe_locked = true
        return true
    else
        pylon.set_recipe(nil)
        pylon.recipe_locked = true
        pylon.custom_status = status_invalid_target
        return false
    end
end

local function attempt_warp(pylon, q, inventory, f)
    local id = pylon.unit_number
    local queue = storage.warp_storage[id] and storage.warp_storage[id].queue[q]
    for i, data in pairs(queue.targets) do
        if data.entity.valid then
            local result, status = f(data, inventory)
            pylon.custom_status = status
            queue.success = result
            if status and status.label[1] == status_invalid_target.label[1] then
                queue.targets[i] = nil
                table.remove(queue.targets, i)
            end
            if result then return true end
        else
            queue.targets[i] = nil
            table.remove(queue.targets, i)
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
    local recipe = pylon.get_recipe() and pylon.get_recipe().name
    if recipe == "rabbasca-warp-sequence-building" and attempt_warp(pylon, "ghosts", inventory, try_build_ghost) then
    elseif recipe == "rabbasca-warp-sequence-tile" and attempt_warp(pylon, "tiles", inventory, try_build_ghost) then
    elseif recipe == "rabbasca-warp-sequence-module" and attempt_warp(pylon, "modules", inventory, try_warp_module) then
    elseif recipe == "rabbasca-warp-sequence-reverse" and attempt_warp(pylon, "decon", inventory, try_deconstruct) then
    else M.attempt_warmup(pylon) end
end

return M