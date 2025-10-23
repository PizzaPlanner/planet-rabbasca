require("__planet-rabbasca__/scripts/remote-builder")
local rutil = require("__planet-rabbasca__.util")
local bunnyhop = require("__planet-rabbasca__/bunnyhop")

local function hack_vault(event)
  local console = event.target_entity or event.source_entity
  if not console or console.name ~= "rabbasca-vault-access-terminal" then 
    local position = event.target_position or event.source_position
    if not position then return end
    local consoles = game.surfaces[event.surface_index].find_entities_filtered{ position = position, radius = 8, name = "rabbasca-vault-access-terminal" }
    if #consoles == 0 then return end
    console = consoles[1]
  end
  local surface = console.surface
  local position = console.position
  local vault = surface.find_entity("rabbasca-vault", position)
  if not vault then 
    console.die()
    return 
  end
  local input = console.get_inventory(defines.inventory.crafter_input)
  local output = console.get_inventory(defines.inventory.crafter_output)
  -- if another item was in input, current_recipe will just have started crafting. stop and retrieve input
  local current_recipe = console.is_crafting() and console.get_recipe() 
  if current_recipe and #current_recipe.ingredients > 0 then
    -- resetting recipe/progress via script loses input items, so recreate them
    input.insert({name = current_recipe.ingredients[1].name })
  end
  rutil.spill_to_inventory_or_ground(input, output, surface, { position.x, position.y + 1.4 })
  console.crafting_progress = 0
  if vault.active then
    vault.active = false
    vault.force = game.forces.neutral
    console.force = game.forces.neutral
  else
    vault.active = true
    vault.force = game.forces.enemy
    console.force = game.forces.player
  end
end

local function handle_script_events(event)
  local effect_id = event.effect_id
  if effect_id == "rabbasca_init_terminal" then
    local console = event.target_entity or event.source_entity
    if not console then return end
    if console.name == "rabbasca-vault-access-terminal" then
      console.force = game.forces.neutral
    end
  elseif effect_id == "rabbasca_terminal_died" then
    local console = event.target_entity or event.source_entity
    local surface = console.surface
    local position = console.position
    local vault = surface.find_entity("rabbasca-vault", position)
    if not vault then return end
    vault.active = false
    vault.force = game.forces.neutral
  elseif effect_id == "make_invulnerable" then
    local vault = event.target_entity or event.source_entity
    if not vault then return end
    vault.destructible = false
    vault.active = false
  elseif effect_id == "rabbasca_on_hack_console" then
    hack_vault(event)
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
      ["copper-plate"] = 200,
      ["battery"] = 20,
  })
  remote.call("freeplay", "set_created_items", {
      ["transport-belt"] = 100,
      ["inserter"] = 50,
  })
  remote.call("freeplay", "set_debris_items", {
      ["copper-plate"] = 5,
  })
end

script.on_init(give_starter_items)