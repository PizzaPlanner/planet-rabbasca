local M = require("__planet-rabbasca__.scripts.warp.pylon")

local function awake(pylon)
    if pylon.get_recipe() == nil then
        pylon.set_recipe("rabbasca-remote-warmup")
        pylon.recipe_locked = true
    end
end
--- Last TEST: ././7.5 VS ././5 VS ././4

script.on_nth_tick(20, function(event)
  for surface, chunks in pairs(storage.warp_chunks) do
    for i, chunk in pairs(chunks.dirty) do
      if chunks[chunk] then
        chunks[chunk].last_update = event.tick
        chunks.dirty[i] = nil
        table.remove(chunks.dirty, i)
        local area = chunks[chunk].area
        for qid, _ in pairs(chunks[chunk].queue) do chunks[chunk].queue[qid] = { } end
        local is_empty = true
        for _, e in pairs(game.surfaces[surface].find_entities_filtered {
          name = { "entity-ghost", "tile-ghost", "item-request-proxy" },
          area = area,
        }) do M.register(M.get_warp_cache(e), chunks[chunk]) is_empty = false end
        for _, e in pairs(game.surfaces[surface].find_entities_filtered {
          to_be_deconstructed = true,
          area = area,
        }) do M.register(M.get_warp_cache(e), chunks[chunk]) is_empty = false end
        if not is_empty then
          for pid, _ in pairs(chunks[chunk].covered_by) do
            awake(storage.warp_storage[pid].entity)
          end
        end
      end
      if i > 5 then break end
    end
  end
end)

-- TODO: Does not trigger for item-request-proxy
local build_events = {
    defines.events.on_built_entity,
    defines.events.on_robot_built_entity,
    defines.events.on_space_platform_built_entity,
    defines.events.script_raised_built,
    defines.events.script_raised_revive
}

script.on_event(build_events, function(event)
  local e = event.entity
  if e.name == "entity-ghost"
  or e.name == "tile-ghost" then
    M.mark_chunk_dirty(e.surface_index, M.chunk_id(e.position))
  elseif e.name == "rabbasca-warp-pylon" then
    M.register_pylon(e)
  elseif e.name == "rabbasca-warp-cargo-pad" then
    storage.rabbasca_remote_builder = e -- Only one allowed for simplicity
    M.mark_all_chunks_dirty(0)
  end
end)

script.on_event(defines.events.on_marked_for_deconstruction, function(event)
  M.mark_chunk_dirty(event.entity.surface_index, M.chunk_id(event.entity.position))
end)

return M