require("__planet-rabbasca__/scripts/remote-builder")
local rui = require("__planet-rabbasca__.scripts.vault-ui")
local bunnyhop = require("__planet-rabbasca__/bunnyhop")

local function show_teleport_ui(player, max_range)
    local surface = player.surface
    local reachable_surfaces = bunnyhop.get_connections(surface.name, max_range)

    if #reachable_surfaces == 0 then 
      player.print("[item=bunnyhop-engine] No discovered planet within "..max_range.."km")
      return 
    end

    if player.gui.screen.bunnyhop_ui then
        rui.clear_bunnyhop_ui()
    end

    local frame = player.gui.screen.add{
        type = "frame",
        name = "bunnyhop_ui",
        caption = "Bunnyhop within "..max_range.."km",
        direction = "vertical"
    }
    frame.auto_center = true
    local pb = frame.add{
        type = "progressbar",
        name = "bunnyhop_charge",
        value = 1
    }
    pb.style.horizontally_stretchable = true
    -- pb.tags = { last_x = player.position.x, last_y = player.position.y }

    local list = frame.add{ 
      type = "list-box", 
      name = "bunnyhop_surface_list",
      selected_index = current_index,
      items = reachable_surfaces 
    }
    list.selected_index = 1
    rui.extend_bunnyhop_ui(player)
end

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
    local monument = event.target_entity or event.source_entity
    if not monument then return end
    monument.destructible = false
    monument.active = false
    return
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
      local input = console.get_inventory(defines.inventory.crafter_input)
      if input then 
        surface.spill_inventory{position = position, inventory = input, enable_looted = true}
      end
      console.recipe_locked = false
      console.set_recipe(nil)
      console.force = game.forces.player
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
    -- info.insert({name="rabbasca-vault-access-timer", count=1, spoil_percent = 1 - alert_duration_multiplier}) 
    -- for i = 0, 20 do
    --   info.insert({name="rabbasca-vault-access-indicator", count=5, spoil_percent= 1 - (i * 0.05 * alert_duration_multiplier)})
    -- end
    return
  end
  -- if effect_id == "rabbasca_vault_spawned" then
  --   event.target_entity.insert_fluid({name = "harene", amount = 100}) 
  --   return
  -- end
  if not effect_id or not effect_id:find("^rabbasca_teleport") then return end
  local engine = event.source_entity or event.target_entity
  local player = engine.player or engine.owner_location.player
  if player then 
    show_teleport_ui(player, 1000)
  end
end

-- Register event
script.on_event(defines.events.on_script_trigger_effect, handle_script_events)

script.on_event(defines.events.on_surface_created, function(event)
  if not game.planets["rabbasca"] or not game.planets["rabbasca"].surface then return end
  if event.surface_index ~= game.planets["rabbasca"].surface.index then return end
  game.forces.enemy.set_evolution_factor_by_time(0, event.surface_index)
  game.forces.enemy.set_evolution_factor_by_pollution(1, event.surface_index)
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