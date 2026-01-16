local M = require("__planet-rabbasca__.scripts.warp.pylon")

local function awake(pylon)
    if pylon.valid and pylon.get_recipe() == nil then
        pylon.set_recipe("rabbasca-remote-warmup")
    end
end
--- Last TEST: ././7.5 VS ././5 VS ././4

script.on_nth_tick(20, function(event)
  for i, warper in pairs(storage.inventory_warpers) do
    if not warper.valid then table.remove(storage.inventory_warpers, i) 
    else
      local inv = warper.get_inventory(defines.inventory.chest)
      for s = 1,#inv do
        local stack = inv[s]
        if stack.valid_for_read and storage.warp_inventory.can_insert(stack) and M.is_proto_supported(stack.prototype) then
          storage.warp_inventory.insert(stack)
          stack.clear()
        end
      end
    end
  end
  M.update_logistic_section()
  for surface, chunks in pairs(storage.warp_chunks) do
    for i, chunk in pairs(chunks.dirty) do
      if chunks[chunk] then
        chunks[chunk].last_update = event.tick
        chunks.dirty[i] = nil
        table.remove(chunks.dirty, i)
        local area = chunks[chunk].area
        for qid, _ in pairs(chunks[chunk].queue) do chunks[chunk].queue[qid] = { } end
        local is_empty = true
        if game.surfaces[surface] then
          for _, e in pairs(game.surfaces[surface].find_entities_filtered {
            name = { "entity-ghost", "tile-ghost", "item-request-proxy" },
            area = area,
          }) do M.register(M.get_warp_cache(e), chunks[chunk]) is_empty = false end
          for _, e in pairs(game.surfaces[surface].find_entities_filtered {
            to_be_deconstructed = true,
            area = area,
          }) do M.register(M.get_warp_cache(e), chunks[chunk]) is_empty = false end
          for _, e in pairs(game.surfaces[surface].find_entities_filtered {
            to_be_upgraded = true,
            area = area,
          }) do M.register(M.get_warp_cache(e), chunks[chunk]) is_empty = false end
          if not is_empty then
            for pid, _ in pairs(chunks[chunk].covered_by) do
              awake(storage.warp_storage[pid].entity)
            end
          end
        end
      end
      if i > 5 then break end
    end
  end
end)

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
  elseif e.name == "rabbasca-warp-uplink" then
    table.insert(storage.inventory_warpers, e)
    local sections = e.get_logistic_sections()
    if not sections then return end
    for _, section in pairs(sections.sections) do
      if section.group == M.logistics_group_name() then return end
    end
    local new = sections.add_section(M.logistics_group_name())
    if new then new.multiplier = -1 end
  end
end)

script.on_event(defines.events.on_marked_for_upgrade, function(event)
  M.mark_chunk_dirty(event.entity.surface_index, M.chunk_id(event.entity.position))
end)

script.on_event(defines.events.on_marked_for_deconstruction, function(event)
  M.mark_chunk_dirty(event.entity.surface_index, M.chunk_id(event.entity.position))
end)

script.on_event(defines.events.on_gui_click, function(event)
  if event.element.name == "rabbasca_open_warp_inventory" then 
    game.players[event.player_index].opened = storage.warp_inventory
  end
end)

-- script.on_event(defines.events.on_player_cursor_stack_changed, function(event)
-- -- TODO: can use this to show correct pylon radius??
-- end)

return M