local M = require("__planet-rabbasca__.scripts.warp.pylon")

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
  or e.name == "tile-ghost"
  or e.name == "item-request-proxy" then
    M.try_register_for_warp(e)
  elseif e.name == "rabbasca-warp-pylon" then
    M.register_pylon(e)
  elseif e.name == "rabbasca-warp-cargo-pad" then
    storage.rabbasca_remote_builder = e -- Only one allowed for simplicity
  end
end)

script.on_event(defines.events.on_marked_for_deconstruction, function(event)
    M.try_register_for_warp(event.entity)
end)

return M