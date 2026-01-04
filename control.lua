require("api")
local remote_builder = require("__planet-rabbasca__.scripts.remote-builder")
local rutil = require("__planet-rabbasca__.scripts.surface-control")
local bunnyhop = require("__planet-rabbasca__.scripts.bunnyhop-control")

local function handle_script_events(event)
  local effect_id = event.effect_id
  if effect_id == "rabbasca_on_warp_attempt" then
    local from = event.source_entity or event.target_entity
    if not (from and from.name == "rabbasca-warp-pylon") then return end
    remote_builder.attempt_build_ghost(from)
  elseif effect_id == "rabbasca_on_warp_complete" then
    local from = event.source_entity or event.target_entity
    if not (from and from.name == "rabbasca-warp-container") then return end
    remote_builder.finalize_build_ghost(from)
  elseif effect_id == "rabbasca_on_recalc_evolution" then
    local from = event.source_entity or event.target_entity
    local position = (from and from.position) or event.target_position or event.source_position
    rutil.update_alertness(game.surfaces[event.surface_index], position)
    if from and from.name == "rabbasca-vault-spawner" then
      local vault = from.surface.find_entity("rabbasca-vault-crafter", position)
      rutil.rabbasca_set_vault_active(vault, false)
    end
    if from and from.name == "rabbasca-vault-console" then
      local vault = from.surface.find_entity("rabbasca-vault-crafter", position)
      rutil.rabbasca_set_vault_active(vault, true)
    end
  elseif effect_id == "rabbasca_on_modulate_vault_security" then
    local from = event.source_entity or event.target_entity
    local position = (from and from.position) or event.target_position or event.source_position
    if not from then return end
    local recipe = from.get_recipe()
    if not recipe then return end
    local max = Rabbasca.alertness_modulation_max() / Rabbasca.alertness_modulation_step()
    local offset = recipe.name == "rabbasca-security-modulation-up" and 1 or -1
    storage.alertness_modulation = math.max(-max, math.min(max, (storage.alertness_modulation or 0) + offset))
    rutil.update_alertness(game.surfaces[event.surface_index], position)
  elseif effect_id == "rabbasca_on_send_pylon_underground" then
    local from = event.source_entity or event.target_entity
    if not from then return end
    local surface = game.planets["rabbasca-underground"].surface or game.planets["rabbasca-underground"].create_surface()
    if not surface then return end
    local offset = from.position
    local radius = 3 * 32
    surface.request_to_generate_chunks(offset, 3)
    surface.force_generate_chunk_requests()
    local pos = surface.find_non_colliding_position("electromagnetic-plant", offset, radius, 1)
    if not pos then
      game.forces.player.print({ "rabbasca-extra.created-underground-pylon-error", offset.x, offset.y })
      return 
    end
    local tiles = {
      { position = {pos.x, pos.y}, name = "rabbasca-energetic-concrete" },
      { position = {pos.x+ 1, pos.y}, name = "rabbasca-energetic-concrete" },
      { position = {pos.x, pos.y+ 1}, name = "rabbasca-energetic-concrete" },
      { position = {pos.x+ 1, pos.y+ 1}, name = "rabbasca-energetic-concrete" },
    }
    surface.set_tiles(tiles)
    local spawner = surface.create_entity {
      name = "rabbasca-warp-pylon",
      position = pos,
      force = game.forces.player,
      snap_to_grid = true,
    }
    if spawner then
      game.forces.player.print({ "rabbasca-extra.created-underground-pylon", spawner.gps_tag })
      for _, p in pairs({
        { pos.x + 1.5, pos.y + 1.5 },
        { pos.x - 1.5, pos.y + 1.5 },
        { pos.x + 1.5, pos.y - 1.5 },
        { pos.x - 1.5, pos.y - 1.5 },
      }) do
        surface.create_entity {
          name = "small-lamp",
          position = p,
          force = game.forces.player,
          snap_to_grid = true,
        }
      end
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
  elseif effect_id == "rabbasca_replace_tiles" then
    local pos = event.source_entity and event.source_entity.position or event.target_position
    if not pos then return end
    pos = { x = math.floor(pos.x) - 0.5, y = math.floor(pos.y) - 0.5 }
    local surface = game.surfaces[event.surface_index]
    if not surface then return end
    local tiles = {
      { position = { pos.x,    pos.y - 1}, name = "harenic-lava" },
      { position = { pos.x,    pos.y + 1}, name = "harenic-lava" },
      { position = { pos.x + 1,    pos.y}, name = "harenic-lava" },
      { position = { pos.x - 1,    pos.y}, name = "harenic-lava" },
    }
    local center = { position = {pos.x,    pos.y}, name = "harenic-lava" }
    if math.random() < 0.22 then 
      surface.set_tiles({center})
    else
      table.insert(tiles, center)
    end
    for _, t in pairs(tiles) do
      if surface.can_place_entity{name = "harenic-lava-spreader", position = t.position} or math.random() < 0.21 then
        surface.create_entity {
          name = "harenic-lava-spreader",
          position = t.position,
          create_build_effect_smoke = false,
        } -- this seems to ignore buildability
      end
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
    
    local spawner = surface.create_entity {
      name = "rabbasca-vault-warp-spawner",
      position = pos,
      force = game.forces.rabbascans or game.forces.enemy,
      snap_to_grid = true,
    }
    if not spawner then return end
    surface.set_tiles(tiles)
    for _, player in pairs(game.connected_players) do
        player.add_custom_alert(spawner, { type = "entity", name = "rabbasca-vault-warp-spawner" }, { "rabbasca-extra.alert-enemy-spawner" }, true)
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

script.on_load(function()
  bunnyhop.register_bunnyhop_handler()
end)

script.on_event({
  defines.events.on_player_controller_changed, 
  defines.events.on_player_joined_game
}, function(event)
    local player = game.get_player(event.player_index)
    if not player then return end

    bunnyhop.clear_bunnyhop_ui(player)
    rutil.update_evolution_bar(player)
end)

script.on_event(defines.events.on_player_changed_surface, function(event)
    local player = game.players[event.player_index]
    rutil.update_evolution_bar(player)
end)

script.on_event(defines.events.on_surface_created, function(event)
  if (game.planets["rabbasca"].surface and event.surface_index == game.planets["rabbasca"].surface.index)
  or (game.planets["rabbasca-underground"].surface and event.surface_index == game.planets["rabbasca-underground"].surface.index) then
    local surface = game.surfaces[event.surface_index]
    surface.create_global_electric_network()
    surface.request_to_generate_chunks({0, 0}, 1)
    -- for _, force in pairs(game.forces) do
    --   force.chart(surface, {{-1, -1}, {1, 1}})
    -- end
    if surface.name == "rabbasca-underground" then
      surface.min_brightness = 0
      surface.daytime = 0.75
      surface.freeze_daytime = true
    end
  end
end)

local function give_starter_items()
  if not Rabbasca.is_aps_planet() then return end
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
  if game.forces.rabbascans then 
    log("Force 'rabbascans' already exists")
    return
  end
  log("Creating force 'rabbascans'")
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