local RECEIVER_RADIUS = 21
-- TODO: Use items_to_place_this?

local function awake(receiver)
    if receiver.valid and receiver.get_recipe() == nil and receiver.surface.planet then
        receiver.set_recipe("rabbasca-remote-warmup")
        receiver.recipe_locked = true
    end
end

local function awake_receivers(entity)
    if not entity.valid then return end
    local proto = entity.ghost_prototype
    if not proto then return end
    local radius = RECEIVER_RADIUS
    local receivers = entity.surface.find_entities_filtered{
        area = {
            {entity.position.x - radius, entity.position.y - radius},
            {entity.position.x + radius, entity.position.y + radius}
        },
        name = "rabbasca-warp-pylon",
    }
    for _, receiver in pairs(receivers) do
        awake(receiver)
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

local function try_build_ghost(entity)
    if not entity.valid then return false, status_invalid_target end
    if not entity.is_registered_for_construction() then return false, status_invalid_target end
    if entity.custom_status and entity.custom_status.label[1] == "entity-status.rabbasca-warp" then 
        return false, status_invalid_target
    end
    local proto = entity.ghost_prototype
    if not (proto.items_to_place_this and #proto.items_to_place_this > 0) then return end
    if not (storage.rabbasca_remote_builder and storage.rabbasca_remote_builder.valid) then
        local builders = game.surfaces.rabbasca and game.surfaces.rabbasca.find_entities_filtered{name = "rabbasca-warp-cargo-pad"}
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

function M.attempt_build_ghost(pylon)
    local is_calling = pylon.get_recipe() and pylon.get_recipe().name == "rabbasca-warp-sequence"
    local position = pylon.position
    local radius = RECEIVER_RADIUS
    local ghosts = pylon.surface.find_entities_filtered{
        area = {
            {position.x - radius, position.y - radius},
            {position.x + radius, position.y + radius}
        },
        -- TODO: Support "item-request-proxy" for module slots?
        name = { "entity-ghost", "tile-ghost" }
    }
    -- on successful build, next attempt is faster
    -- when no ghosts left, go to sleep
    if is_calling then
        for _, ghost in pairs(ghosts) do
            local result, status = try_build_ghost(ghost)
            pylon.custom_status = status
            if result then return end
        end
        pylon.set_recipe("rabbasca-remote-warmup")
        pylon.recipe_locked = true
    else
        if #ghosts == 0 or not storage.rabbasca_remote_builder or not pylon.surface.planet then 
            pylon.set_recipe(nil) 
            pylon.recipe_locked = true
            pylon.custom_status = status_invalid_target
            return 
        end
        for _, ghost in pairs(ghosts) do
            local result, status = try_build_ghost(ghost)
            pylon.custom_status = status
            if result then
                pylon.set_recipe("rabbasca-warp-sequence")
                pylon.recipe_locked = true
                return 
            end
        end
    end
end

function M.finalize_build_ghost(pod)
    local item = pod.get_inventory(defines.inventory.cargo_unit)[1]
    if not item.valid then return end
    local is_tile = item.prototype.place_as_tile_result ~= nil
    local ghost = pod.surface.find_entity({name = is_tile and "tile-ghost" or "entity-ghost", quality = item.quality }, pod.position)
    if ghost and ghost.valid and ghost.ghost_prototype and ghost.custom_status then
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
    defines.events.script_raised_built
}

script.on_event(build_events, function(event)
  if not event.entity.valid then return end
  if event.entity.name == "rabbasca-warp-cargo-pad" then
    storage.rabbasca_remote_builder = event.entity -- Only one allowed for simplicity
    for _, surface in pairs(game.surfaces) do
        for _, receiver in pairs(surface.find_entities_filtered{name = "rabbasca-warp-pylon"}) do
            awake(receiver)
        end
    end
  elseif event.entity.name == "entity-ghost" and event.entity.ghost_prototype then
    awake_receivers(event.entity)
  end
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