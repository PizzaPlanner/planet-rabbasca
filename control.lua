local remote_builder = require("__planet-rabbasca__/scripts/remote-builder")
local rutil = require("__planet-rabbasca__.util")
local bunnyhop = require("__planet-rabbasca__/bunnyhop")
local alert_ui = require("__planet-rabbasca__.scripts.alertness-ui")

local function handle_script_events(event)
  local effect_id = event.effect_id
  if effect_id == "rabbasca_on_warp_attempt" then
    local from = event.source_entity or event.target_entity
    if not from then return end
    remote_builder.attempt_build_ghost(from)
  elseif effect_id == "rabbasca_on_warp_complete" then
    local from = event.source_entity or event.target_entity
    if not from then return end
    remote_builder.finalize_build_ghost(from)
  elseif effect_id == "rabbasca_on_recalc_evolution" then
    local from = event.source_entity or event.target_entity
    local position = (from and from.position) or event.target_position or event.source_position
    rutil.update_alertness(game.surfaces[event.surface_index], position)
    for _, player in pairs(game.players) do 
      alert_ui.update_bar(player) 
    end
    if from and from.name == "rabbasca-vault-spawner" then
      local vault = from.surface.find_entity("rabbasca-vault-crafter", position)
      rutil.rabbasca_set_vault_active(vault, false)
    end
    if from and from.name == "rabbasca-vault-console" then
      local vault = from.surface.find_entity("rabbasca-vault-crafter", position)
      rutil.rabbasca_set_vault_active(vault, true)
    end
  elseif effect_id == "rabbasca_init_spawner" then
    local from = event.source_entity or event.target_entity
    if not from then return end
    from.force = game.forces.rabbascans
  elseif effect_id == "rabbasca_init_receiver" then
    local from = event.source_entity or event.target_entity
    if from then 
      from.set_recipe("rabbasca-remote-warmup")
      from.recipe_locked = true
    end
  elseif effect_id == "rabbasca_summon_pylon_grid_aligned" then
    local pos = event.target_position or event.source_position
    if not pos then return end
    pos = {pos.x + math.random(-8, 8), pos.y + math.random(-8, 8)}
    local surface = game.surfaces[event.surface_index]
    pos = surface.find_non_colliding_position("rabbasca-vault-warp-spawner", pos, 12, 1, true)
    if not pos then return end
    local tiles = {
      { position = {pos.x, pos.y}, name = "rabbasca-energetic-concrete" },
      { position = {pos.x+ 1, pos.y}, name = "rabbasca-energetic-concrete" },
      { position = {pos.x, pos.y+ 1}, name = "rabbasca-energetic-concrete" },
      { position = {pos.x+ 1, pos.y+ 1}, name = "rabbasca-energetic-concrete" },
    }
    
    if surface.create_entity {
      name = "rabbasca-vault-warp-spawner",
      position = pos,
      force = game.forces.rabbascans or game.forces.enemy,
      snap_to_grid = true,
    } then surface.set_tiles(tiles) end
  elseif effect_id == "rabbasca_teleport" then
    local engine = event.source_entity or event.target_entity
    local player = engine.player or engine.owner_location.player
    if not player then return end
    local armor = player.get_inventory(defines.inventory.character_armor)[1]
    if armor and armor.valid_for_read and armor.grid then 
      for _, eq in pairs(armor.grid.equipment) do
        if eq.name == "bunnyhop-engine-equipment" then
          player.create_local_flying_text { text = "Initiating bunnyhop...", create_at_cursor = true }
          bunnyhop.show_bunnyhop_ui(player, eq)
          return
        end
      end
    -- TODO: This still consumes the cooldown. Can it be reset?
    player.create_local_flying_text { text = "No bunnyhop engine equipped", create_at_cursor = true }
    end
  end
end

script.on_event(defines.events.on_script_trigger_effect, handle_script_events)

script.on_event(defines.events.on_player_controller_changed, function(event)
    local player = game.get_player(event.player_index)
    if not player then return end

    if player.gui.screen.bunnyhop_ui then
       bunnyhop.clear_bunnyhop_ui(player)
    end
    alert_ui.update_bar(player)
end)

script.on_event(defines.events.on_player_changed_surface, function(event)
    local player = game.players[event.player_index]
    alert_ui.update_bar(player)
end)

script.on_event(defines.events.on_surface_created, function(event)
  if not game.planets["rabbasca"] or not game.planets["rabbasca"].surface then return end
  if event.surface_index ~= game.planets["rabbasca"].surface.index then return end
  game.planets["rabbasca"].surface.create_global_electric_network()
end)

local function give_starter_items()
  if not rutil.rabbasca.is_aps_planet then return end
  if not remote.interfaces["freeplay"] then return end
  remote.call("freeplay", "set_ship_items", 
  {
      ["iron-plate"] = 100,
  })
  remote.call("freeplay", "set_created_items", {
      ["pistol"] = 1,
      ["firearm-magazine"] = 40,
      ["transport-belt"] = 200,
      ["small-electric-pole"] = 1,
      ["burner-mining-drill"] = 2
  })
  remote.call("freeplay", "set_debris_items", {
      ["iron-plate"] = 15,
  })
end

-- Workaround for robots expanding into biter nests. Also compatibility for castra research
local function create_rabbasca_force()
  local force = game.create_force("rabbascans")
  force.ai_controllable = false
  force.share_chart = true
  force.set_cease_fire(game.forces.player, false)
  game.forces.player.set_cease_fire(force, false)
end

script.on_init(function()
  create_rabbasca_force()
  give_starter_items()
end)