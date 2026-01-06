local M = { }

function M.init_storage()
    storage.warp_chunks = storage.warp_chunks or { }
    storage.warp_storage = storage.warp_storage or { }
    storage.warp_queue = storage.warp_queue or { }
end

function M.chunk_id(position)
    return string.format("%i-%i", math.floor(position.x / 32), math.floor(position.y / 32))
end

function M.get_covered_chunks(entity)
    local range = Rabbasca.get_warp_radius(entity.quality)
    local min_x = math.floor((entity.position.x - range) / 32)
    local max_x = math.floor((entity.position.x + range) / 32)
    local min_y = math.floor((entity.position.y - range) / 32)
    local max_y = math.floor((entity.position.y + range) / 32)
    local chunks = { }
    for cx = min_x, max_x do
        for cy = min_y, max_y do
            table.insert(chunks, M.chunk_id({ x = cx * 32, y = cy * 32 }))
        end
    end
    return chunks
end

function M.deregister_chunks(id)
    local data = storage.warp_storage[id]
    if not data then return end
    for _, chunk in pairs(data.chunks) do
        storage.warp_chunks[data.surface][chunk][id] = nil
        local is_chunk_empty = true
        for _, _ in pairs(storage.warp_chunks[data.surface][chunk]) do
            is_chunk_empty = false
            break
        end
        if is_chunk_empty then
            storage.warp_chunks[data.surface][chunk] = nil
        end
    end
    storage.warp_storage[id] = nil
end

function M.register_chunks(entity)
    script.register_on_object_destroyed(entity)
    local id = entity.unit_number
    storage.warp_storage[id] = {
        surface = entity.surface_index,
        chunks = M.get_covered_chunks(entity),
        entity = entity,
        queue = {
            decon = { targets = { }, success = true },
            ghosts = { targets = { }, success = true },
            tiles = { targets = { }, success = true },
            modules = { targets = { }, success = true },
        }
    }
    storage.warp_chunks[entity.surface_index] = storage.warp_chunks[entity.surface_index] or { }
    for _, chunk in pairs(storage.warp_storage[id].chunks) do
        storage.warp_chunks[entity.surface_index][chunk] = storage.warp_chunks[entity.surface_index][chunk] or { }
        storage.warp_chunks[entity.surface_index][chunk][id] = true
    end
    return id
end

function M.get_warp_range(entity)
    if not storage.warp_chunks then return { } end
    local surface = entity.surface_index
    if not storage.warp_chunks[surface] then return { } end
    return storage.warp_chunks[surface][M.chunk_id(entity.position)] or { }
end

local function awake(pylon)
    if pylon.get_recipe() == nil then
        pylon.set_recipe("rabbasca-remote-warmup")
        pylon.recipe_locked = true
    end
end

function M.get_warp_cache(entity)
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
        local is_tile = entity.name == "deconstructible-tile-proxy"
        if is_tile then
            entity = entity.surface.get_tile(entity.position.x, entity.position.y)
        end
        local proto = entity.prototype
        local to_place = proto.items_to_place_this and proto.items_to_place_this[1]
        if not to_place then return nil end
        return { entity = entity, name = to_place.name, count = to_place.count, queue = "decon", is_tile = is_tile }
    end
end

function M.register(data, pylon_id, do_range_check)
    if not (data and data.queue and data.entity) then return end
    local s = storage.warp_storage[pylon_id]
    if not s then return end
    if do_range_check then
        local pos_a = s.entity.position
        local pos_b = data.entity.position
        local range = Rabbasca.get_warp_radius(s.entity.quality)
        if math.abs(pos_a.x - pos_b.x) > range or math.abs(pos_a.y - pos_b.y) > range then return end
    end 
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

function M.try_register_for_warp(entity)
    local data = nil
    for r, _ in pairs(M.get_warp_range(entity)) do
        data = data or M.get_warp_cache(entity)
        M.register(data, r, true)
    end
end

function M.register_pylon(pylon)
    local id = M.register_chunks(pylon)
    local range = Rabbasca.get_warp_radius(pylon.quality)
    local area = {{pylon.position.x - range, pylon.position.y - range}, {pylon.position.x + range, pylon.position.y + range}}
    for _, e in pairs(pylon.surface.find_entities_filtered {
        name = { "entity-ghost", "tile-ghost" },
        area = area,
        force = pylon.force
    }) do
        M.register(M.get_warp_cache(e), id)
    end
    for _, e in pairs(pylon.surface.find_entities_filtered {
        to_be_deconstructed = true,
        area = area,
        force = pylon.force
    }) do
        M.register(M.get_warp_cache(e), id)
    end
end

--- Workaround to ensure modules get registered, since their creation can not be caught via event
--- TODO: Get rid of this. not great for performance
--- Last TEST: ././7.5 VS ././5
function reset_module_queue(pylon, queue)
    local id = pylon.unit_number
    local range = Rabbasca.get_warp_radius(pylon.quality)
    local area = {{pylon.position.x - range, pylon.position.y - range}, {pylon.position.x + range, pylon.position.y + range}}
    queue.modules.targets = { }
    for _, e in pairs(pylon.surface.find_entities_filtered {
        name = { "item-request-proxy" },
        area = area,
        force = pylon.force
    }) do
        M.register(M.get_warp_cache(e), id)
    end
end

return M