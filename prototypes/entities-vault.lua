local delayed_recalc_trigger = {
  type = "delayed-active-trigger",
  name = "rabbasca-calculate-evolution",
  delay = 5,
  action = {
    type = "direct",
    action_delivery = {
      type = "instant",
      source_effects = {
        type = "script",
        effect_id = "rabbasca_on_hack_console"
      }
    }
  }
}

local vault = util.merge{ 
  table.deepcopy(data.raw["unit-spawner"]["spitter-spawner"]), 
{
  name = "rabbasca-vault",
  type = "unit-spawner",
  icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png",
  max_health = 72000,
  healing_per_tick = 72 / second,
  spawning_cooldown = {5 * second, 0.25 * second},
  max_count_of_owned_units = 20,
  max_count_of_owned_defensive_units = 1,
  max_friends_around_to_spawn = 8,
  max_defensive_friends_around_to_spawn = 1,
  spawning_radius = 12,
  captured_spawner_entity = "rabbasca-vault-hacked",
  map_generator_bounding_box = {{-8, -8}, {8, 8}},
  -- map_color = {0.9, 0.3, 0.4},
  collision_box = {{-2.4, -1.9},{2.4, 2.2}}, -- shift by 2, 2.5
  selection_box = {{-2.5, -2.5},{2.5, 2.5}},
  selection_priority = 30
}}
vault.spawn_decoration = {}
vault.damaged_trigger_effect = nil
vault.absorptions_per_second = { } -- { ["vault-activity"] = { absolute = 500, proportional = 0.5 }}
vault.autoplace = { probability_expression = "rabbasca_camps > 0.9", force = "enemy" }
vault.created_effect = {
  type = "direct",
  action_delivery = {
    type = "delayed",
    delayed_trigger = "rabbasca-calculate-evolution"
  }
}
vault.resistances = {
  { type = "physical", percent = 95 },
  { type = "explosion", percent = 90 },
  { type = "fire", percent = 90 },
  { type = "poison", percent = 100 },
  { type = "acid", percent = 100 },
  { type = "laser", percent = 99 },
  { type = "electric", percent = 87 },
  { type = "impact", percent = 98 },
}
-- vault.created_effect = {
--   type = "direct",
--   action_delivery =
--   {
--     type = "instant",
--     target_effects =
--     {
--       {
--         type = "create-entity",
--         entity_name = "rabbasca-vault-hacked",
--         offsets = {{0, 0.1}},
--       },
--       {
--         type = "script",
--         effect_id = "rabbasca_init_vault"
--       }
--     }
--   } 
-- }
vault.result_units = {
  { unit = "vault-defender-1", spawn_points = {
    {evolution_factor = 0, spawn_weight = 1}, 
    {evolution_factor = 0.05, spawn_weight = 1},
    {evolution_factor = 0.1, spawn_weight = 0.3},
    {evolution_factor = 0.3, spawn_weight = 0},
  }},
  { unit = "vault-defender-2", spawn_points = {
    {evolution_factor = 0.05, spawn_weight = 0}, 
    {evolution_factor = 0.1, spawn_weight = 0.5},
    {evolution_factor = 0.25, spawn_weight = 0.2},
    {evolution_factor = 0.3, spawn_weight = 0},
  }},
  { unit = "medium-biter", spawn_points = {
    {evolution_factor = 0.2, spawn_weight = 0}, 
    {evolution_factor = 0.3, spawn_weight = 1},
    {evolution_factor = 0.5, spawn_weight = 0},
  }},
    { unit = "big-biter", spawn_points = {
    {evolution_factor = 0.3, spawn_weight = 0}, 
    {evolution_factor = 0.4, spawn_weight = 0.5},
    {evolution_factor = 0.7, spawn_weight = 1},
    {evolution_factor = 1, spawn_weight = 0},
  }},
    { unit = "behemoth-biter", spawn_points = {
    {evolution_factor = 0.9, spawn_weight = 0}, 
    {evolution_factor = 0.91, spawn_weight = 0.5},
  }},
}
vault.graphics_set =
{
  animations = {
  {
    layers =
    {
      {
        filename = "__Krastorio2Assets__/buildings/stabilizer-charging-station/stabilizer-charging-station.png",
        priority = "high",
        width = 170,
        height = 170,
        frame_count = 80,
        line_length = 10,
        scale = 1.5,
      }
    }
  },
} }

local access_console = util.merge{
  table.deepcopy(vault),
  {
    name = "rabbasca-vault-hacked",
    type = "furnace",
    max_health = 7200,
    production_health_effect = {
      not_producing = -36,
      producing = 0.72
    },
    crafting_speed = 1,
    energy_usage = "1MW",
    allow_copy_paste = true,
    module_slots = 1,
    return_ingredients_on_change = true,
    ignore_output_full = true,
    result_inventory_size = 10,
    source_inventory_size = 1,
    cant_insert_at_source_message_key = "inventory-restriction.not-a-vault-key",
    is_military_target = true,
    no_ears_upgrade = true,
  }
}
access_console.circuit_connector = nil
access_console.circuit_connector_flipped = nil
access_console.flags = { "placeable-player", "not-deconstructable", "not-repairable", "not-rotatable", "player-creation" }
access_console.allowed_effects = { "speed", "consumption", "pollution" }
access_console.next_upgrade = nil
access_console.minable = nil
access_console.dying_trigger_effect = {
    type = "create-entity",
    as_enemy = true,
    entity_name = "rabbasca-vault",
    ignore_no_enemies_mode = true,
    protected = true,
}
access_console.fluid_boxes = { } 
access_console.energy_source = {
  type = "burner",
  burner_usage = "food",
  effectivity = 1,
  fuel_categories = { "carotene" },
  fuel_inventory_size = 1
}
access_console.crafting_categories = { "rabbasca-vault-hacking", "rabbasca-vault-extraction" }
access_console.graphics_set = {
  animation = vault.graphics_set.animations[1],
  idle_animation = vault.graphics_set.animations[1]
}

local capture_bot = {
  type = "capture-robot",
  icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png",
  name = "rabbasca-capture-robot",
  capture_speed = 1,
  max_health = 120,
  speed = 0.01
}

data:extend {
  delayed_recalc_trigger,
  vault, 
  access_console,
  capture_bot 
}