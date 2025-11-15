local RECEIVER_RADIUS = 21
local WARPING_TAG = "rabbasca-warping"
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
        name = "rabbasca-remote-receiver",
    }
    for _, receiver in pairs(receivers) do
        awake(receiver)
    end
end

local function try_build_ghost(entity)
    if not entity.valid then return false end
    if entity.tags and entity.tags[WARPING_TAG] then return false end
    local proto = entity.ghost_prototype
    if not proto then return false end
    local builder = storage.rabbasca_remote_builder
    if not builder then 
        return false 
    end

    local name, quality = entity.ghost_prototype.name, entity.quality.name
    local item_with_quality = { name = name, quality = quality }

    if builder.valid
    and not builder.to_be_deconstructed()
    and builder.get_inventory(defines.inventory.chest).get_item_count(item_with_quality) > 0 then
        local pod = nil
        for _, hatch in pairs(builder.cargo_hatches) do
            if hatch.owner == builder then
                pod = hatch.create_cargo_pod()
                break
            end
        end
        if not pod then return true end -- all hatches busy, try again later
        local chest = builder.get_inventory(defines.inventory.chest)
        if pod.get_inventory(defines.inventory.cargo_unit).insert({name = item_with_quality.name, quality = item_with_quality.quality, count = chest.remove(item_with_quality)}) == 0 then
            chest.insert(item_with_quality)
        end
        pod.cargo_pod_destination = {
            type = defines.cargo_destination.surface,
            surface = entity.surface,
            position = entity.position,
            land_at_exact_position = true
        }
        local tags = entity.tags or { }
        tags[WARPING_TAG] = true
        entity.tags = tags
        rendering.draw_sprite{
            sprite = "item.rabbasca-remote-call",
            target = {entity = entity, offset = { 0, -0.5 } },          -- attach to ghost
            surface = entity.surface,
            x_scale = 0.75,
            y_scale = 0.75,
        }
        return true
    end
    return false
end

local M = {}

function M.attempt_build_ghost(pylon)
    local is_calling = pylon.get_recipe() and pylon.get_recipe().name == "rabbasca-remote-call"
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
            if try_build_ghost(ghost) then return end
        end
        pylon.set_recipe("rabbasca-remote-warmup")
        pylon.recipe_locked = true
    else
        if #ghosts == 0 or not storage.rabbasca_remote_builder or not surface.planet then 
            pylon.set_recipe(nil) 
            receiver.recipe_locked = true
            return 
        end
        for _, ghost in pairs(ghosts) do
            if try_build_ghost(ghost) then 
                pylon.set_recipe("rabbasca-remote-call")
                pylon.recipe_locked = true
                return 
            end
        end
    end
end

function M.finalize_build_ghost(pod)
    local item = pod.get_inventory(defines.inventory.cargo_unit)[1]
    local is_tile = item.prototype.place_as_tile_result ~= nil
    local ghost = pod.surface.find_entity({ name = is_tile and "tile-ghost" or "entity-ghost", quality = item.quality }, pod.position)
    if ghost and ghost.tags and ghost.tags[WARPING_TAG] then
        if not item.valid then -- spoiled etc
            ghost.tags = { } -- TODO: just remove WARPING_TAG
            return
        end
        if ghost.ghost_name == item.name then
            local _, revived, _ = ghost.revive{ raise_revive = true } 
            if revived then return end
        end
    end
    pod.surface.spill_item_stack{
        position = pod.position,
        stack = item,
        enable_looted = true
    }
end

local build_events = {
    defines.events.on_built_entity,
    defines.events.on_robot_built_entity,
    defines.events.on_space_platform_built_entity,
    defines.events.script_raised_built
}

script.on_event(build_events, function(event)
  if not event.entity.valid then return end
  if event.entity.name == "rabbasca-remote-builder" then
    storage.rabbasca_remote_builder = event.entity -- Only one allowed for simplicity
    for _, surface in pairs(game.surfaces) do
        for _, receiver in pairs(surface.find_entities_filtered{name = "rabbasca-remote-receiver"}) do
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