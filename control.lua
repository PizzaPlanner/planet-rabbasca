require("__planet-rabbasca__/scripts/remote-builder")
local rui = require("__planet-rabbasca__.scripts.vault-ui")
local bunnyhop = require("__planet-rabbasca__/bunnyhop")

local function handle_script_events(event)
  local effect_id = event.effect_id
  if effect_id == "rabbasca_init_terminal" then
    local console = event.target_entity or event.source_entity
    if not console then return end
    if console.name == "rabbasca-vault-access-terminal" then
      console.set_recipe("rabbasca-vault-activate")
      console.recipe_locked = true
      console.force = game.forces.neutral
    end
  elseif effect_id == "rabbasca_terminal_died" then
    local console = event.target_entity or event.source_entity
    if not console then return end
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
    local console = event.target_entity or event.source_entity
    if not console then return end
    local surface = console.surface
    local position = console.position
    local vault = surface.find_entity("rabbasca-vault", position)
    if not vault then 
      console.die()
      return 
    end
    local recipe = console.get_recipe()
    if not recipe then return end
    if recipe.name == "rabbasca-vault-regenerate-core" then
      console.set_recipe("rabbasca-vault-deactivate")
    elseif recipe.name == "rabbasca-vault-activate" then
      vault.active = true
      vault.force = game.forces.enemy
      if console.is_crafting() then
        -- set_recipe returns nothing and remaining items are not placed in crafter_trash
        -- workaround: re-create the item consumed by next craft and spill whole input
        local input = console.get_inventory(defines.inventory.crafter_input)
        input.insert({name = "vault-access-key"}) -- one already removed from input on craft
        if input then 
          surface.spill_inventory{position = position, inventory = input, enable_looted = true}
        end
      end
      console.force = game.forces.player
      console.recipe_locked = false
      console.set_recipe(nil)
    elseif recipe.name == "rabbasca-vault-deactivate" then
      vault.active = false
      vault.force = game.forces.neutral
      console.set_recipe("rabbasca-vault-activate")
      console.recipe_locked = true
      console.force = game.forces.neutral
    else
      local out_pos = surface.find_non_colliding_position(recipe.name, position, 5, 1)
      if not out_pos then return end
      local capsule = surface.create_entity {
        name = recipe.name,
        position = out_pos,
        force = game.forces.neutral,
      }
      if not capsule then return end
      capsule.order_deconstruction(game.forces.player)
      console.set_recipe("rabbasca-vault-regenerate-core")
      console.recipe_locked = true
    end
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
      ["iron-plate"] = 50,
  })
  remote.call("freeplay", "set_created_items", {
      ["assembling-machine-2"] = 5,
      ["transport-belt"] = 100,
      ["inserter"] = 50,
      ["chemical-plant"] = 5,
      ["gun-turret"] = 4,
  })
  remote.call("freeplay", "set_debris_items", {
      ["iron-plate"] = 5
  })
end

script.on_init(give_starter_items)