require("__base__.prototypes.entity.combinator-pictures")

local access_console = util.merge{
  table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"]),
  {
    name = "rabbasca-vault-access-terminal",
    -- fixed_recipe = "rabbasca-vault-activate", -- must be set via script to be editable later
    max_health = 7200,
    -- healing_per_tick = 0.1 / second, -- doesn't work
    crafting_speed = 1,
    energy_usage = "2MW",
    allow_copy_paste = true,
    module_slots = 2,
    return_ingredients_on_change = true,
    trash_inventory_size = 1,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.6, -1}, {0.6, 0.6}},
    is_military_target = true,
    no_ears_upgrade = true
  }
}
access_console.flags = { "placeable-neutral", "not-deconstructable", "not-rotatable", "player-creation" }
access_console.allowed_effects = { "speed", "consumption", "pollution" }
access_console.next_upgrade = nil
access_console.minable = nil
access_console.fluid_boxes = { } 
access_console.energy_source = {
  type = "electric",
  usage_priority = "primary-input",
  emissions_per_minute = { ["vault-activity"] = 6 },
  drain = "0kW"
}
access_console.resistances = {
  { type = "physical", percent = 70 },
  { type = "fire", percent = 90 },
  { type = "poison", percent = 100 },
  { type = "laser", percent = 50 },
  { type = "electric", percent = 30 },
}
access_console.dying_trigger_effect = {
  type = "script",
  effect_id = "rabbasca_terminal_died"
}
access_console.created_effect = {
  type = "direct",
  action_delivery =
  {
    type = "instant",
    target_effects =
    {
      {
        type = "script",
        effect_id = "rabbasca_init_terminal"
      },
    }
  } 
}
-- access_console.loot = {{ item = "rabbasca-console-scrap", count_min = 165, count_max = 173 }}
access_console.surface_conditions = nil
access_console.crafting_categories = { "rabbasca-vault-hacking", "rabbasca-vault-extraction" }
access_console.graphics_set =
{
  animation =
  {
    layers =
    {
      {
        filename = "__Krastorio2Assets__/buildings/singularity-beacon/singularity-beacon.png",
        priority = "high",
        width = 360,
        height = 360,
        frame_count = 1,
        scale = 0.2
      }
    }
  },
}

local vault = util.merge{ 
  table.deepcopy(data.raw["unit-spawner"]["spitter-spawner"]), 
{
  name = "rabbasca-vault",
  type = "unit-spawner",
  captured_spawner_entity = nil,
  spawning_cooldown = {5 * second, 0.25 * second},
  max_count_of_owned_units = 20,
  max_count_of_owned_defensive_units = 1,
  max_friends_around_to_spawn = 8,
  max_defensive_friends_around_to_spawn = 1,
  spawning_radius = 12,
  map_generator_bounding_box = {{-10.5, -10.5}, {10.5, 10.5}},
  -- map_color = {0.9, 0.3, 0.4},
  collision_box = {{-2.5, -2},{2.5, 3}},
  selection_priority = 30
}}
vault.spawn_decoration = {}
vault.absorptions_per_second = { ["vault-activity"] = { absolute = 500, proportional = 0.5 }}
vault.autoplace = { probability_expression = "rabbasca_camps", force = "neutral" }
vault.created_effect = {
  type = "direct",
  action_delivery =
  {
    type = "instant",
    target_effects =
    {
      {
        type = "create-entity",
        entity_name = "rabbasca-vault-access-terminal",
        offsets = {{2, 2.5}},
      },
      {
        type = "script",
        effect_id = "make_invulnerable"
      }
    }
  } 
}
vault.result_units = {
  { unit = "vault-defender-1", spawn_points = {
    {evolution_factor = 0, spawn_weight = 0.1}, 
    {evolution_factor = 0.1, spawn_weight = 1},
    {evolution_factor = 0.2, spawn_weight = 0},
  }},
  { unit = "vault-defender-2", spawn_points = {
    {evolution_factor = 0.14, spawn_weight = 0}, 
    {evolution_factor = 0.25, spawn_weight = 1},
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
        scale = 1.5
      }
    }
  },
} }

data:extend {
  vault, 
  access_console, 
}