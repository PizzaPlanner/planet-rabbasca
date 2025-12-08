local function awake(receiver)
    if not (receiver.valid and receiver.surface.planet) then return end

    local radius = Rabbasca.get_warp_radius(receiver.quality)
    for _, ghost in pairs(receiver.surface.find_entities_filtered{
        name = { "entity-ghost", "tile-ghost" },
        position = receiver.position,
        radius = radius
    }) do 
        local e = receiver.surface.create_entity{
            name = ghost.name.."-warpin",
            position = ghost.position,
            quality = ghost.quality,
            fast_replace = true,
            player = #receiver.force.players > 0 and receiver.force.players[1],
            cause = receiver,
            inner_name = ghost.ghost_name,
            tags = ghost.tags
        }
        if e then 
            game.print(e.gps_tag)
            ghost.destroy{}
        end
    end

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

    local to_place = proto.items_to_place_this[1]
    local name, count, quality = to_place.name, to_place.count, (is_tile and "normal") or entity.quality
    local item_with_quality = { name = name, quality = quality }
    
    local inserted = builder.get_inventory(defines.inventory.chest).insert({name = name, count = count, quality = quality})
    if inserted == count then
        if is_tile then
            local hidden = entity.hidden_tile
            local hidden_2 = entity.double_hidden_tile
            local surface = entity.surface
            local pos = entity.position
            surface.set_tiles({{position = pos, name = hidden or "out-of-map"}})
            surface.set_hidden_tile(pos, hidden_2)
            surface.set_double_hidden_tile(pos, nil)
        else
            entity.destroy{}
        end
        return true
    end
    builder.get_inventory(defines.inventory.chest).remove({name = name, quality = quality, count = inserted})
    return false
end

local function try_warp_request(ghost)
    -- game.print(ghost.name .. " -> " .. ghost.proxy_target.name)
    return false
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
        local pod = nil
        for _, hatch in pairs(builder.cargo_hatches) do
            if hatch.owner == builder then
                pod = hatch.create_cargo_pod()
                break
            end
        end
        if not pod then return true end -- all hatches busy, try again later
        local chest = builder.get_inventory(defines.inventory.chest)
        local removed = chest.remove({name = name, count = count, quality = quality})
        local inserted = pod.get_inventory(defines.inventory.cargo_unit).insert({name = name, quality = quality, count = removed })
        if inserted ~= removed then
            chest.insert({name = name, count = removed - inserted, quality = quality})
        end
        pod.cargo_pod_destination = {
            type = defines.cargo_destination.surface,
            surface = entity.surface,
            position = entity.position,
            land_at_exact_position = true
        }
        entity.custom_status = {
            diode = defines.entity_status_diode.yellow,
            label = { "entity-status.rabbasca-warp" }
        }
        rendering.draw_sprite{
            sprite = "item.rabbasca-warp-sequence",
            target = { entity = entity, offset = { 0, -0.5 } },
            surface = entity.surface,
            x_scale = 0.75,
            y_scale = 0.75,
            time_to_live = 30 * 60
        }
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
        local result, status = try_warp_request(ghost)
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

function M.finalize_build_ghost(pod)
    local item = pod.get_inventory(defines.inventory.cargo_unit)[1]
    if not (item.valid and item.valid_for_read) then return end
    local is_tile = item.prototype.place_as_tile_result ~= nil
    local ghost = pod.surface.find_entity({name = is_tile and "tile-ghost" or "entity-ghost", quality = item.quality }, pod.position)
    if ghost and ghost.valid and ghost.ghost_prototype then
        ghost.custom_status = nil
        local required = ghost.ghost_prototype.items_to_place_this
        if required and #required > 0 and required[1].name == item.name and required[1].count <= item.count then
            ghost.revive{ raise_revive = true }
            if not ghost.valid then -- if revive failed, ghost should still exist
                item.count = item.count - required[1].count
            end
        end
    end
    if item.count > 0 then
        pod.surface.spill_item_stack{
            position = pod.position,
            stack = item,
            enable_looted = true
        }
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
  or event.entity.name == "tile-ghost" then
    update_wake_area(event.entity, event.tick)
elseif event.entity.name == "item-request-proxy" and event.entity.proxy_target then
    update_wake_area(event.entity.proxy_target, event.tick)
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