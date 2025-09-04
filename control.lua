local function handle_teleport_effect(event)
  local effect_id = event.effect_id
  if effect_id == "rabbasca_change_force_and_despawn" then
    local monument = event.target_entity or event.source_entity
    if not monument then return end
    if not monument.force == game.forces.neutral then return end
    local surface = monument.surface
    local position = monument.position
    monument.force = game.forces.player
    monument.destroy{}
    local spawner = surface.create_entity {
      name = "rabbasca-vault-terminal-spawner",
      position = position,
      force = game.forces.enemy,
      raise_built = true
    }
    if not spawner then return end
    game.forces.enemy.set_evolution_factor(game.forces.enemy.get_evolution_factor() + 0.02, surface)
    surface.create_entity {
      name = "rabbasca-vault-hacking-bot",
      position = position,
      force = game.forces.player,
      raise_built = true
    }
    return
  end
  if effect_id == "rabbasca_vault_spawned" then
    event.target_entity.insert_fluid({name = "harene", amount = 100}) 
    return
  end
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
end)

script.on_event(defines.events.on_chunk_generated, function(event)
  if event.surface ~= game.planets["rabbasca"].surface then return end
  local surface = event.surface

  for _, power in pairs(surface.find_entities_filtered({area = event.area, name = "rabbasca-vault"})) do
      if power.force == game.forces.neutral then return end -- make sure this only triggers once per entity
      power.clear_fluid_inside()
      power.insert_fluid({name = "harene", amount = 50}) 
      -- local left_top = { power.position.x - 12, power.position.y - 12}
      -- local right_bottom = { power.position.x + 12, power.position.y + 12}

      -- local tiles = {}
      -- for x = left_top.x, right_bottom.x do
      --   for y = left_top.y, right_bottom.y do
      --     table.insert(tiles, {name = "harene-infused-foundation", position = {x, y}})
      --   end
      -- end
      -- surface.set_tiles(tiles)

      -- requires never version lol
      -- local territory = surface.create_territory{chunk = event.position}
      if math.abs(event.position.x) + math.abs(event.position.y) < 8 then return end
      surface.create_entity{
          name = "moonstone-turret",
          position = surface.find_non_colliding_position("moonstone-turret", {power.position.x - 8, power.position.y}, 4, 1),
          force = power.force,
          raise_built = true
      }
      surface.create_entity{
          name = "moonstone-turret",
          position = surface.find_non_colliding_position("moonstone-turret", {x = power.position.x + 8, y = power.position.y}, 4, 1),
          force = power.force,
          raise_built = true
      }
      power.force = game.forces.neutral
  end
end)