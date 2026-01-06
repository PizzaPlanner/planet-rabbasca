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

function M.is_warp_supported(entity)
    return true
end

function M.get_warp_range(entity)
    if not storage.warp_chunks then return { } end
    if not storage.warp_chunks[entity.surface_index] then return { } end
    return storage.warp_chunks[entity.surface_index][M.chunk_id(entity.position)] or { }
end

return M