local function awake(receiver)
    if receiver.get_recipe() == nil then
        receiver.set_recipe("rabbasca-remote-warmup")
        receiver.recipe_locked = true
    end
end

local function get_warp_cache(entity)
    if entity.name == "entity-ghost" then
        local proto = entity.ghost_prototype
        local to_place = proto.items_to_place_this and proto.items_to_place_this[1]
        if not to_place then return nil end
        local name, count, quality = to_place.name, to_place.count, entity.quality.name
        return { entity = entity, name = name, count = count, quality = quality, queue = "ghosts" }
    elseif entity.name == "tile-ghost" then
        local proto = entity.ghost_prototype
        local to_place = proto.items_to_place_this and proto.items_to_place_this[1]
        if not to_place then return nil end
        local name, count, quality = to_place.name, to_place.count, entity.quality.name
        return { entity = entity, name = name, count = count, quality = quality, queue = "tiles" }
    elseif entity.name == "item-request-proxy" then 
        return { entity = entity, queue = "modules" }
    else 
        local proto = entity.prototype
        local to_place = proto.items_to_place_this and proto.items_to_place_this[1]
        if not to_place then return nil end
        return { entity = entity, name = to_place.name, count = to_place.count, queue = "decon", is_tile = entity.name == "deconstructible-tile-proxy" }
    end
end

local function register(data, pylon_id)
    local s = storage.warp_storage[pylon_id]
    if not s then return end
    table.insert(s.queue[data.queue].targets, data)
    awake(s.entity)
    -- rendering.draw_sprite {
    --     sprite = "item.rabbasca-warp-sequence",
    --     target = { entity = entity, offset = { 0, -0.5 } },
    --     surface = entity.surface,
    --     x_scale = 0.75,
    --     y_scale = 0.75,
    --     time_to_live = 10 * 60 -- just to indicate that this was registered
    -- }
end

local M = require("__planet-rabbasca__.scripts.warp.warp_chunks")
local N = require("__planet-rabbasca__.scripts.warp.pylon")
M.attempt_build_ghost = N.attempt_build_ghost

function M.try_register_for_warp(entity)
    local data = nil
    for r, _ in pairs(M.get_warp_range(entity)) do
        data = data or get_warp_cache(entity)
        if data and data.queue and data.entity then
            register(data, r)
        end
    end
end

function M.register_pylon(entity)
    local id = M.register_chunks(entity)
    local range = Rabbasca.get_warp_radius(entity.quality)
    local area = {{entity.position.x - range, entity.position.y - range}, {entity.position.x + range, entity.position.y + range}}
    for _, e in pairs(entity.surface.find_entities_filtered {
        name = { "entity-ghost", "tile-ghost", "item-request-proxy" },
        area = area,
        force = entity.force
    }) do
        register(get_warp_cache(e), id)
    end
    for _, e in pairs(entity.surface.find_entities_filtered {
        to_be_deconstructed = true,
        area = area,
        force = entity.force
    }) do
        register(get_warp_cache(e), id)
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

script.on_event(build_events, function(event)
  if not event.entity.valid then return end
  if event.entity.name == "entity-ghost" 
  or event.entity.name == "tile-ghost"
  or event.entity.name == "item-request-proxy" then
    M.try_register_for_warp(event.entity)
  elseif event.entity.name == "rabbasca-warp-pylon" then
    M.register_pylon(event.entity)
  elseif event.entity.name == "rabbasca-warp-cargo-pad" then
    storage.rabbasca_remote_builder = event.entity -- Only one allowed for simplicity
  end
end)

script.on_event(defines.events.on_marked_for_deconstruction, function(event)
    M.try_register_for_warp(event.entity)
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