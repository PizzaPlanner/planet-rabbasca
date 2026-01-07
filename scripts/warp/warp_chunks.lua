local M = { }

function M.init_storage()
    storage.warp_chunks = { }
    storage.warp_storage = { }
    storage.warp_queue = { }
end

function M.mark_chunk_dirty(surface_id, chunk_id, min_ticks_passed)
    if not (storage.warp_chunks[surface_id] and storage.warp_chunks[surface_id][chunk_id]) then return end
    local c = storage.warp_chunks[surface_id][chunk_id]
    if game.tick - c.last_update > (min_ticks_passed or 0) then
        c.last_update = math.huge
        table.insert(storage.warp_chunks[surface_id].dirty, chunk_id)
        -- game.print("Chunk recalc [gps="..c.area[1][1]..","..c.area[1][2]..",rabbasca]")
    end
end

function M.mark_all_chunks_dirty(min_ticks_passed)
    for surface_id, chunks in pairs(storage.warp_chunks) do
        for _, chunk_id in pairs(chunks) do
            M.mark_chunk_dirty(surface_id, chunk_id, min_ticks_passed)
        end
    end
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
    local chunk_xy = { }
    for cx = min_x, max_x do
        for cy = min_y, max_y do
            table.insert(chunks, M.chunk_id({ x = cx * 32, y = cy * 32 }))
            table.insert(chunk_xy, {{math.floor(cx * 32), math.floor(cy * 32)}, {math.floor(cx * 32) + 32, math.floor(cy * 32) + 32}})
        end
    end
    return chunks, chunk_xy
end

function M.deregister_chunks(id)
    local data = storage.warp_storage[id]
    if not data then return end
    for _, chunk in pairs(data.chunks) do
        storage.warp_chunks[data.surface][chunk].covered_by[id] = nil
        local is_chunk_empty = true
        for _, _ in pairs(storage.warp_chunks[data.surface][chunk].covered_by) do
            is_chunk_empty = false
            break
        end
        if is_chunk_empty then
            storage.warp_chunks[data.surface][chunk] = nil
            local is_surface_empty = false
            for _, _ in pairs(storage.warp_chunks[data.surface]) do
                is_surface_empty = true
                break
            end
            if is_surface_empty then
                storage.warp_chunks[data.surface] = nil
            end
        end
    end
    storage.warp_storage[id] = nil
end

function M.register_chunks(entity)
    script.register_on_object_destroyed(entity)
    local id = entity.unit_number
    local chunks, chunk_xy = M.get_covered_chunks(entity)
    storage.warp_storage[id] = {
        surface = entity.surface_index,
        chunks = chunks,
        entity = entity,
        position = entity.position,
        range = Rabbasca.get_warp_radius(entity.quality),
    }
    storage.warp_chunks[entity.surface_index] = storage.warp_chunks[entity.surface_index] or { dirty = { } }
    for i, chunk in pairs(storage.warp_storage[id].chunks) do
        storage.warp_chunks[entity.surface_index][chunk] = storage.warp_chunks[entity.surface_index][chunk] or { 
            last_update = 0, 
            covered_by = { }, 
            area = chunk_xy[i],
            queue = {
                decon = { },
                ghosts = { },
                tiles = { },
                modules = { }
            }
        }
        storage.warp_chunks[entity.surface_index][chunk].covered_by[id] = true
    end
    return id
end

function M.get_warp_cache(entity)
    if entity.name == "entity-ghost" then
        local proto = entity.ghost_prototype
        local to_place = proto.items_to_place_this and proto.items_to_place_this[1]
        if not to_place then return nil end
        local name, count, quality = to_place.name, to_place.count, entity.quality.name
        return { entity = entity, name = name, count = count, quality = quality, queue = "ghosts", position = entity.position }
    elseif entity.name == "tile-ghost" then
        local proto = entity.ghost_prototype
        local to_place = proto.items_to_place_this and proto.items_to_place_this[1]
        if not to_place then return nil end
        local name, count, quality = to_place.name, to_place.count, entity.quality.name
        return { entity = entity, name = name, count = count, quality = quality, queue = "tiles", position = entity.position }
    elseif entity.name == "item-request-proxy" then 
        return { entity = entity, name = "test", count = 1, quality = "normal", queue = "modules", position = entity.position }
    else
        local is_tile = entity.name == "deconstructible-tile-proxy"
        if is_tile then
            entity = entity.surface.get_tile(entity.position.x, entity.position.y)
        end
        local proto = entity.prototype
        local to_place = proto.items_to_place_this and proto.items_to_place_this[1]
        if not to_place then return nil end
        return { entity = entity, name = to_place.name, count = to_place.count, quality = (is_tile and "normal") or entity.quality.name, queue = "decon", is_tile = is_tile, position = entity.position }
    end
end

function M.register(data, pstorage)
    if not data then return end
    local q = pstorage.queue[data.queue]
    q[data.name] = q[data.name] or { }
    q[data.name][data.quality] = q[data.name][data.quality] or { }
    table.insert(q[data.name][data.quality], data)
end

function M.register_pylon(pylon)
    local id = M.register_chunks(pylon)
    for _, chunk in pairs(storage.warp_storage[id].chunks) do
        M.mark_chunk_dirty(pylon.surface_index, chunk, 0)
    end
end

return M