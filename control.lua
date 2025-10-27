require("__planet-rabbasca__/scripts/remote-builder")
local rutil = require("__planet-rabbasca__.util")
local bunnyhop = require("__planet-rabbasca__/bunnyhop")

local function handle_script_events(event)
  local effect_id = event.effect_id
  if effect_id == "rabbasca_terminal_died" then
    local console = event.target_entity or event.source_entity
    local surface = console.surface
    local position = console.position
    local vault = surface.find_entity("rabbasca-vault", position)
    if not vault then return end
    vault.active = false
    vault.force = game.forces.neutral
  elseif effect_id == "rabbasca_init_vault" then
    local vault = event.target_entity or event.source_entity
    if not vault then return end
    rutil.rabbasca_init_vault_or_console(vault)
  elseif effect_id == "rabbasca_on_hack_console" then
    local from = event.source_entity or event.target_entity
    local position = (from and from.position) or event.target_position or event.source_position
    rutil.hack_vault(game.surfaces[event.surface_index], position)
  elseif effect_id == "rabbasca_teleport" then
    local engine = event.source_entity or event.target_entity
    local player = engine.player or engine.owner_location.player
    if not player then return end
    local armor = player.get_inventory(defines.inventory.character_armor)[1]
    if armor and armor.valid_for_read and armor.grid then 
      for _, eq in pairs(armor.grid.equipment) do
        if eq.name == "bunnyhop-engine-equipment" then
          player.create_local_flying_text { text = "Initiating bunnyhop...", create_at_cursor = true }
          bunnyhop.show_bunnyhop_ui(player, eq, 1000)
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
end)

script.on_nth_tick(1800, function(_)
  if not game.planets["rabbasca"] or not game.planets["rabbasca"].surface then return end
  rutil.hack_vault(game.planets["rabbasca"].surface)
end)

script.on_event(defines.events.on_surface_created, function(event)
  if not game.planets["rabbasca"] or not game.planets["rabbasca"].surface then return end
  if event.surface_index ~= game.planets["rabbasca"].surface.index then return end
  game.planets["rabbasca"].surface.create_global_electric_network()
end)

local function give_starter_items()
  if settings.startup["aps-planet"].value ~= "rabbasca" then return end
  if not remote.interfaces["freeplay"] then return end
  remote.call("freeplay", "set_ship_items", 
  {
      ["copper-plate"] = 250,
      ["battery"] = 75,
  })
  remote.call("freeplay", "set_created_items", {
      ["pistol"] = 1,
      ["firearm-magazine"] = 5,
      ["transport-belt"] = 100,
      ["inserter"] = 50,
      ["stone-furnace"] = 1,
      ["burner-mining-drill"] = 2
  })
  remote.call("freeplay", "set_debris_items", {
      ["iron-plate"] = 15,
  })
end

script.on_init(give_starter_items)