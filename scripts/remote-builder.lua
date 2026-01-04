local function awake(receiver)
    if not (receiver.valid and receiver.surface.planet) then return end
                                                                        
    local radius = Rabbasca.get_warp_radius(receiver.quality)
    if receiver.get_recipe() == nil then
        receiver.set_recipe("rabbasca-remote-warmup")
        receiver.recipe_locked = true
    end
end

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

local function try_deconstruct(entity)
    if not entity.to_be_deconstructed() then return false, status_invalid_target end
    local is_tile = false
    if entity.name == "deconstructible-tile-proxy" then
        entity = entity.surface.get_tile(entity.position.x, entity.position.y)
        is_tile = true
    end
    if not entity.valid then return false, status_invalid_target end
    local proto = entity.prototype
    if not (proto.items_to_place_this and #proto.items_to_place_this > 0) then return false, status_invalid_target end
    if not (storage.rabbasca_remote_builder and storage.rabbasca_remote_builder.valid) then
        local builders = (game.surfaces.rabbasca and game.surfaces.rabbasca.find_entities_filtered{name = "rabbasca-warp-cargo-pad"}) or { }
        if #builders > 0 then
            storage.rabbasca_remote_builder = builders[1]
        else
            return false, status_no_builder
        end
    end
    local builder = storage.rabbasca_remote_builder
    if not builder.valid or builder.to_be_deconstructed() then 
        return false, status_no_builder
    end
     
    if not is_tile then
        for k = 1, entity.get_max_inventory_index() do 
            local inventory = entity.get_inventory(k)
            if inventory then entity.surface.spill_inventory { position = entity.position, inventory = inventory } end
        end
        local surface, position, size = entity.surface, entity.position, 1
        local result = entity.mine{ inventory = builder.get_inventory(defines.inventory.chest) }
        if result then play_smoke(surface, position, size) end
        return result
    else
        local to_place = proto.items_to_place_this[1]
        local name, count  = to_place.name, to_place.count
        local item_with_quality = { name = name, quality = quality }
        
        local inserted = builder.get_inventory(defines.inventory.chest).insert({name = name, count = count})
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
        builder.get_inventory(defines.inventory.chest).remove({name = name, quality = quality, count = inserted})
        return false
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

local function try_warp_module(request)
    local target = request.proxy_target
    if not target then return false, status_invalid_target end
    if not (storage.rabbasca_remote_builder and storage.rabbasca_remote_builder.valid) then
        local builders = (game.surfaces.rabbasca and game.surfaces.rabbasca.find_entities_filtered{name = "rabbasca-warp-cargo-pad"}) or { }
        if #builders > 0 then
            storage.rabbasca_remote_builder = builders[1]
        else
            return false, status_no_builder
        end
    end
    local builder = storage.rabbasca_remote_builder
    if not builder.valid or builder.to_be_deconstructed() then
        return false, status_no_builder
    end

    for _, plan in pairs(request.insert_plan) do
        if plan.items.in_inventory then
            local name, quality = plan.id.name, plan.id.quality or "normal"
            for i, stack in pairs(plan.items.in_inventory) do
                local item_with_quality = { name = name, quality = quality }
                local inventory_id, where, count = stack.inventory, stack.stack, stack.count or 1
                -- TODO: Restrict to modules? Note: inventory defines overlap between type, need to check type as well
                local inventory = target.get_inventory(inventory_id)
                if inventory and builder.get_inventory(defines.inventory.chest).get_item_count(item_with_quality) >= count then
                    local removed  = builder.get_inventory(defines.inventory.chest).remove({name = name, count = count, quality = quality})
                    local temp = game.create_inventory(1)
                    temp.insert({name = name, count = removed, quality = quality})
                    if inventory[where + 1].swap_stack(temp[1]) then
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

local function try_build_ghost(entity)
    if not entity.valid then return false, status_invalid_target end
    if not entity.is_registered_for_construction() then return false, status_invalid_target end
    if entity.custom_status and entity.custom_status.label[1] == "entity-status.rabbasca-warp" then 
        return false, status_invalid_target
    end
    local proto = entity.ghost_prototype
    if not (proto.items_to_place_this and #proto.items_to_place_this > 0) then return false, status_invalid_target end
    if not (storage.rabbasca_remote_builder and storage.rabbasca_remote_builder.valid) then
        local builders = (game.surfaces.rabbasca and game.surfaces.rabbasca.find_entities_filtered{name = "rabbasca-warp-cargo-pad"}) or { }
        if #builders > 0 then
            storage.rabbasca_remote_builder = builders[1]
        else
            return false, status_no_builder
        end
    end
    local builder = storage.rabbasca_remote_builder

    local to_place = proto.items_to_place_this[1]
    local name, count, quality = to_place.name, to_place.count, entity.quality.name
    local item_with_quality = { name = name, quality = quality }

    if builder.valid
    and not builder.to_be_deconstructed()
    and builder.get_inventory(defines.inventory.chest).get_item_count(item_with_quality) >= count then
        local chest = builder.get_inventory(defines.inventory.chest)
        local removed = chest.remove({name = name, count = count, quality = quality})
        local temp = game.create_inventory(255)
        local surface, position = entity.surface, entity.position
        local result = entity.revive{ raise_revive = true, overflow = temp }
        surface.spill_inventory { position = position, inventory = temp }
        temp.destroy()
        if not result then
            chest.insert({name = name, count = removed, quality = quality})
            return false, status_invalid_target
        end
        play_smoke(surface, position, 1)
        return true, status_ok
    end
    for _, player in pairs(entity.force.players) do
        player.add_alert(entity, defines.alert_type.no_material_for_construction)
    end
    return false, status_no_items
end

local M = {}

function M.attempt_warmup(pylon, radius, i)
    local position = pylon.position
    if i ~= 1 and pylon.force.recipes["rabbasca-warp-sequence-tile"].enabled then
        local ghosts = pylon.surface.count_entities_filtered {
            area = {
                {position.x - radius, position.y - radius},
                {position.x + radius, position.y + radius}
            },
            name = { "tile-ghost" }
        }
        if ghosts > 0 then
            pylon.set_recipe("rabbasca-warp-sequence-tile")
            pylon.recipe_locked = true
            return true
        end
    end
    if i ~= 2 and pylon.force.recipes["rabbasca-warp-sequence-building"].enabled then
        local ghosts = pylon.surface.count_entities_filtered {
            area = {
                {position.x - radius, position.y - radius},
                {position.x + radius, position.y + radius}
            },
            name = { "entity-ghost" }
        }
        if ghosts > 0 then
            pylon.set_recipe("rabbasca-warp-sequence-building")
            pylon.recipe_locked = true
            return true
        end
    end
    if i ~= 3 and pylon.force.recipes["rabbasca-warp-sequence-module"].enabled then
        local ghosts = pylon.surface.count_entities_filtered {
            area = {
                {position.x - radius, position.y - radius},
                {position.x + radius, position.y + radius}
            },
            name = { "item-request-proxy" }
        }
        if ghosts > 0 then
            pylon.set_recipe("rabbasca-warp-sequence-module")
            pylon.recipe_locked = true
            return true
        end
    end
    if i ~= 4 and pylon.force.recipes["rabbasca-warp-sequence-reverse"].enabled then
        local ghosts = pylon.surface.count_entities_filtered {
            area = {
                {position.x - radius, position.y - radius},
                {position.x + radius, position.y + radius}
            },
            to_be_deconstructed = true,
        }
        if ghosts > 0 then
            pylon.set_recipe("rabbasca-warp-sequence-reverse")
            pylon.recipe_locked = true
            return true
        end
    end
    pylon.set_recipe("rabbasca-remote-warmup")
    pylon.recipe_locked = true
    return false
end

function M.attempt_deconstruct(pylon, radius)
    local position = pylon.position
    local ghosts = pylon.surface.find_entities_filtered{
        area = {
            {position.x - radius, position.y - radius},
            {position.x + radius, position.y + radius}
        },
        to_be_deconstructed = true,
    }
    for _, ghost in pairs(ghosts) do
        local result, status = try_deconstruct(ghost)
        pylon.custom_status = status
        if result then return end
    end
    M.attempt_warmup(pylon, radius, 4)
end

function M.attempt_module(pylon, radius)
    local position = pylon.position
    local ghosts = pylon.surface.find_entities_filtered{
        area = {
            {position.x - radius, position.y - radius},
            {position.x + radius, position.y + radius}
        },
        name = { "item-request-proxy" }
    }
    for _, ghost in pairs(ghosts) do
        local result, status = try_warp_module(ghost)
        pylon.custom_status = status
        if result then return end
    end
    M.attempt_warmup(pylon, radius, 3)
end

function M.attempt_building(pylon, radius)
    local position = pylon.position
    local ghosts = pylon.surface.find_entities_filtered{
        area = {
            {position.x - radius, position.y - radius},
            {position.x + radius, position.y + radius}
        },
        name = { "entity-ghost" }
    }
    for _, ghost in pairs(ghosts) do
        local result, status = try_build_ghost(ghost)
        pylon.custom_status = status
        if result then return end
    end
    M.attempt_warmup(pylon, radius, 2)
end

function M.attempt_tile(pylon, radius)
    local position = pylon.position
    local ghosts = pylon.surface.find_entities_filtered{
        area = {
            {position.x - radius, position.y - radius},
            {position.x + radius, position.y + radius}
        },
        name = { "tile-ghost" }
    }
    for _, ghost in pairs(ghosts) do
        local result, status = try_build_ghost(ghost)
        pylon.custom_status = status
        if result then return end
    end
    M.attempt_warmup(pylon, radius, 1)
end

function M.attempt_build_ghost(pylon)
    local recipe = pylon.get_recipe() and pylon.get_recipe().name
    local radius = Rabbasca.get_warp_radius(pylon.quality)
    if not recipe or (recipe and not M.attempt_warmup(pylon, radius)) then 
        pylon.set_recipe(nil) 
        pylon.recipe_locked = true
        pylon.custom_status = status_invalid_target
    elseif recipe == "rabbasca-warp-sequence-building" then
        M.attempt_building(pylon, radius)
    elseif recipe == "rabbasca-warp-sequence-tile" then
        M.attempt_tile(pylon, radius)
    elseif recipe == "rabbasca-warp-sequence-module" then
        M.attempt_module(pylon, radius)
    elseif recipe == "rabbasca-warp-sequence-reverse" then
        M.attempt_deconstruct(pylon, radius)
    end
end

local build_events = {
    defines.events.on_built_entity,
    defines.events.on_robot_built_entity,
    defines.events.on_space_platform_built_entity,
    defines.events.script_raised_built,
}

local hightest_quality = nil
for _, q in pairs(prototypes["quality"]) do
    if (not hightest_quality) or q.level > hightest_quality.level then
        hightest_quality = q
    end
end

local function remote_wake_handler(event)
    script.on_nth_tick(1, nil)
    if not (storage.remote_wake_surface and storage.remote_wake_surface.valid) then return end
    local radius = Rabbasca.get_warp_radius(hightest_quality)
    local area = storage.remote_wake_area
    area = {
        {area.left_top.x - radius, area.left_top.y - radius},
        {area.right_bottom.x + radius, area.right_bottom.y + radius}
    }
    local receivers = storage.remote_wake_surface.find_entities_filtered{
        area = area,
        name = "rabbasca-warp-pylon",
    }
    
    for _, receiver in pairs(receivers) do
        awake(receiver)
    end
    storage.remote_wake_tick = nil
    storage.remote_wake_surface = nil
end

local function update_wake_area(entity, tick)
    if storage.remote_wake_tick ~= tick then
        storage.remote_wake_tick = tick
        storage.remote_wake_area = {left_top = entity.position, right_bottom = entity.position}
        storage.remote_wake_surface = entity.surface
        script.on_nth_tick(1, remote_wake_handler)
    end
    storage.remote_wake_area = {
        left_top = {
            x = math.min(entity.bounding_box.left_top.x, storage.remote_wake_area.left_top.x),
            y = math.min(entity.bounding_box.left_top.y, storage.remote_wake_area.left_top.y),
        },
        right_bottom = {
            x = math.max(entity.bounding_box.right_bottom.x, storage.remote_wake_area.right_bottom.x),
            y = math.max(entity.bounding_box.right_bottom.y, storage.remote_wake_area.right_bottom.y),
        }
    }
end 

script.on_event(build_events, function(event)
  if not event.entity.valid then return end
  if event.entity.name == "entity-ghost" 
  or event.entity.name == "tile-ghost"
  or event.entity.name == "item-request-proxy" then
    update_wake_area(event.entity, event.tick)
  elseif event.entity.name == "rabbasca-warp-cargo-pad" then
    storage.rabbasca_remote_builder = event.entity -- Only one allowed for simplicity
    for _, surface in pairs(game.surfaces) do
        for _, receiver in pairs(surface.find_entities_filtered{name = "rabbasca-warp-pylon"}) do
            awake(receiver)
        end
    end
  end
end)

script.on_event(defines.events.on_marked_for_deconstruction, function(event)
    update_wake_area(event.entity, event.tick)
end)

local removal_events = {
    defines.events.on_entity_died,
    defines.events.on_player_mined_entity,
    defines.events.on_robot_mined_entity,
    defines.events.on_space_platform_mined_entity,
    defines.events.on_player_mined_tile,
    defines.events.on_robot_mined_tile,
    defines.events.on_space_platform_mined_tile,
}

script.on_event(removal_events, function(event)
    if event.entity == storage.rabbasca_remote_builder then
        storage.rabbasca_remote_builder = nil
    end
end)

return M