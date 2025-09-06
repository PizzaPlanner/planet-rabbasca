local rui = require("__planet-rabbasca__.scripts.vault-ui")

local function handle_teleport_effect(event)
  local effect_id = event.effect_id
  if effect_id == "rabbasca_init_terminal" then
    local console = event.target_entity or event.source_entity
    if not console then return end
    if console.name ~= "rabbasca-vault-access-terminal" then
      console.active = false
      console.operable = false
    end
    if console.name == "rabbasca-vault-timer" then
      console.operable = false
      console.destructible = false
    end
    console.force = game.forces.neutral
  end
  if effect_id == "make_invulnerable" then
    local monument = event.target_entity or event.source_entity
    if not monument then return end
    monument.destructible = false
    monument.active = false
    return
  end
  if effect_id == "rabbasca_on_hack_expire" then
    local dummy = event.target_entity or event.source_entity 
    if not dummy then return end
    local vault = dummy.surface.find_entity("rabbasca-vault", dummy.position)
    if not vault then return end
    vault.health = vault.max_health
    vault.force = game.forces.neutral
    vault.active = false
    local surface = vault.surface
    local position = vault.position
    local terminal_area = {{vault.position.x - 2, vault.position.y + 2},{vault.position.x + 2, vault.position.y + 3}}
    for _, console in pairs(surface.find_entities(terminal_area)) do
      if console.name == "rabbasca-vault-access-terminal" then
        console.active = true
        console.operable = true
      elseif console.name == "rabbasca-vault-extraction-terminal" then
        surface.spill_inventory{position = position, inventory = console.get_output_inventory(), enable_looted = true}
        console.active = false
        -- console.operable = false
        -- console.force = game.forces.neutral
      elseif console.name == "rabbasca-vault-research-terminal" then
        console.active = false
        -- console.operable = false
        -- console.force = game.forces.neutral
      end
    end
    -- surface.create_entity {
    --   name = "rabbasca-vault",
    --   position = position,
    --   force = game.forces.neutral,
    --   raise_built = true
    -- }
  end
  if effect_id == "rabbasca_on_hack_console" then
    local console = event.target_entity or event.source_entity
    if not console then return end
    if console.name ~= "rabbasca-vault-access-terminal" then return end
    local surface = console.surface
    local position = console.position
    local vault = surface.find_entity("rabbasca-vault", position)
    if not vault then return end
    vault.active = true
    vault.force = game.forces.enemy
    local info = surface.find_entity("rabbasca-vault-timer", vault.position) or surface.create_entity { -- just in case I guess
      name = "rabbasca-vault-timer",
      position = vault.position,
      force = game.forces.neutral,
      raise_built = true
    }
    local recipe = console.get_recipe()
    console.active = false
    console.operable = false
    if not recipe then return end
    local terminal_area = {{vault.position.x - 2, vault.position.y + 2},{vault.position.x + 2, vault.position.y + 3}}
    local alert_duration_multiplier = 1
    if recipe.name == "hack-rabbascan-vault-extraction" then
      for _, console2 in pairs(surface.find_entities_filtered({area = terminal_area, name = "rabbasca-vault-extraction-terminal"})) do
        console2.operable = true
        console2.active = true
        console2.force = game.forces.player
        alert_duration_multiplier = 0.8
      end
    elseif recipe.name == "hack-rabbascan-vault-research" then
      for _, console2 in pairs(surface.find_entities_filtered({area = terminal_area, name = "rabbasca-vault-research-terminal"})) do
        console2.operable = true
        console2.active = true
        console2.force = game.forces.player
      end
    elseif recipe.name == "rabbasca-sabotage-console" then
      surface.spill_inventory{position = position, inventory = console.get_inventory(defines.inventory.crafter_input), enable_looted = true}
      surface.spill_inventory{position = position, inventory = console.get_output_inventory(), enable_looted = true}
      console.set_recipe(nil)
      console.damage(console.max_health / 1.7, game.forces.player)
      alert_duration_multiplier = 0.4
    end
    info.insert({name="rabbasca-vault-access-timer", count=1, spoil_percent = 1 - alert_duration_multiplier}) 
    for i = 0, 20 do
      info.insert({name="rabbasca-vault-access-indicator", count=5, spoil_percent= 1 - (i * 0.05 * alert_duration_multiplier)})
    end
    return
  end
  -- if effect_id == "rabbasca_vault_spawned" then
  --   event.target_entity.insert_fluid({name = "harene", amount = 100}) 
  --   return
  -- end
  if not effect_id or not effect_id:find("^rabbasca_teleport_") then return end

  -- Extract planet name
  local planet = effect_id:gsub("^rabbasca_teleport_", "")

  -- Safety: check player exists
  local player = event.target_entity.player
  if not player then return end

  -- Unlock research if it exists
  local tech_name = "planet-discovery-" .. planet
  for _, force in pairs(game.forces) do
    local tech = force.technologies[tech_name]
    if tech and not tech.researched then
      tech.researched = true
    end
  end

  -- Check surface exists
  local surface = game.planets[planet].surface or game.planets[planet].create_surface()
  if not surface then return end
  local radius = surface.get_starting_area_radius()
  player.force.chart(surface, {{-radius, -radius}, {radius, radius}})

  local start_pos = surface.find_non_colliding_position("character", {0, 0}, surface.get_starting_area_radius(), 1)  or {0, 0}

  -- Teleport player
  if not player.teleport(start_pos, surface) then return end
  player.print("[Teleport] You have been teleported to " .. planet)
end

-- Register event
script.on_event(defines.events.on_script_trigger_effect, handle_teleport_effect)

script.on_event(defines.events.on_surface_created, function(event)
  if event.surface_index ~= game.planets["rabbasca"].surface.index then return end
  game.forces.enemy.set_evolution_factor_by_time(0, event.surface_index)
  game.forces.enemy.set_evolution_factor_by_pollution(1, event.surface_index)
  game.planets["rabbasca"].surface.create_global_electric_network()
end)

script.on_nth_tick(120,
function(event) 
  local surface = game.surfaces["rabbasca"]
  if not surface then return end
  local last_evo = storage.rabbasca_evo_last or 0.01
  local now_evo = game.forces.enemy.get_evolution_factor(surface)
  local delta = math.max(now_evo - last_evo, 0) * 100
  storage.rabbasca_evo_last = math.max(0, math.min(last_evo + delta, 1)) * 0.95
  game.forces.enemy.set_evolution_factor(storage.rabbasca_evo_last, surface)

  rui.update()
end)