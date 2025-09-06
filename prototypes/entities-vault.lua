require("__base__.prototypes.entity.combinator-pictures")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

local access_console = util.merge{
  table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"]),
  {
    name = "rabbasca-vault-access-terminal",
    max_health = 1500,
    crafting_speed = 1,
    energy_usage = "100MW",
    allow_copy_paste = false,
    module_slots = 1,
    return_ingredients_on_change = true,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.6, -1}, {0.6, 0.6}},
  }
}
access_console.fluid_boxes = { } 
-- access_console.allowed_effects = nil
access_console.energy_source = {
  type = "void",
  emissions_per_minute = { transmutives = 1*minute } -- actual numbers are way higher
}
access_console.resistances = {
  { type = "physical", percent = 10 },
  { type = "fire", percent = 80 },
  { type = "poison", percent = 100 },
  { type = "laser", percent = 50 },
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
access_console.collision_mask = { layers = { } }
access_console.loot = { { item = "infused-haronite-plate", count_min = 3, count_max = 3 } }
access_console.minable = nil
access_console.flags = {"placeable-player", "not-deconstructable", "not-rotatable", "placeable-off-grid"}
access_console.surface_conditions = nil
access_console.crafting_categories = { "rabbasca-vault-hacking" }
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
        scale = 0.25
      }
    }
  },
}

local extraction_console = util.merge{ 
  table.deepcopy(access_console),
  {
    name = "rabbasca-vault-extraction-terminal",
    energy_usage = "1GW",
    vector_to_place_result = {0.5, 1}
  } 
}
extraction_console.crafting_categories = { "rabbasca-vault-extraction" }

local research_console = util.merge{
  table.deepcopy(extraction_console),
  {
    name = "rabbasca-vault-research-terminal",
    type = "lab",
    energy_usage = "200MW",
    inputs = {"rabbascan-encrypted-vault-data"}
  }
}
research_console.on_animation = access_console.graphics_set.animation
research_console.off_animation = access_console.graphics_set.animation

local defender = util.merge{ 
  table.deepcopy(data.raw["unit"]["small-spitter"]), 
  {
    name = "vault-defender-1",
    healing_per_tick = 0,
    movement_speed = 0.2,
    distance_per_frame = 0.125,
    distraction_cooldown = 20,
    min_pursue_time = 15 * second,
    max_pursue_distance = 50,
    absorptions_to_join_attack = { transmutives = 500 },
    loot = { { item = "firearm-magazine", count_min = 3, count_max = 3 } },
    ai_settings = {
      join_attacks = true,
      size_in_group = 1,
      destroy_when_commands_fail = true,
      do_separation = true,
    },
  }
}
defender.collision_mask = { layers = { } }
defender.attack_parameters = {
  type = "projectile",
  animation = defender.attack_parameters.animation,
  cooldown = 30,
  cooldown_deviation = 0.2,
  projectile_center = {0, 1},
  projectile_creation_distance = 0.6,
  range = 5,
  sound = sounds.defender_gunshot,
  ammo_category = "bullet",
  ammo_type =
  {
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        source_effects =
        {
          type = "create-explosion",
          entity_name = "explosion-gunshot-small"
        },
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "explosion-hit"
          },
          {
            type = "damage",
            damage = { amount = 1, type = "physical"}
          }
        }
      }
    }
  }
}

local vault = util.merge{ 
  table.deepcopy(data.raw["unit-spawner"]["spitter-spawner"]), 
{
  name = "rabbasca-vault",
  type = "unit-spawner",
  captured_spawner_entity = nil,
  spawning_cooldown = {15 * second, 0.25 * second},
  max_count_of_owned_units = 4,
  max_count_of_owned_defensive_units = 0,
  max_friends_around_to_spawn = 1,
  max_defensive_friends_around_to_spawn = 0,
  spawning_radius = 12,
  map_generator_bounding_box = {{-10.5, -10.5}, {10.5, 10.5}},
  map_color = {0.9, 0.3, 0.4},
  collision_box = {{-2.5, -2},{2.5, 3}},
  selection_priority = 30
}}
vault.absorptions_per_second = { transmutives = { absolute = 100, proportional = 0.5 }}
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
        offsets = {{0, 2.5}},
      },
      {
        type = "create-entity",
        entity_name = "rabbasca-vault-extraction-terminal",
        offsets = {{1.5, 2.5}},
      },
      {
        type = "create-entity",
        entity_name = "rabbasca-vault-research-terminal",
        offsets = {{-1.5, 2.5}},
      },
      {
        type = "create-entity",
        entity_name = "rabbasca-vault-timer",
        offsets = {{0, 0}},
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
    {evolution_factor = 0.06, spawn_weight = 1},
    {evolution_factor = 0.1, spawn_weight = 0},
  }},
  { unit = "small-spitter", spawn_points = {
    {evolution_factor = 0.08, spawn_weight = 0}, 
    {evolution_factor = 0.09, spawn_weight = 1},
    {evolution_factor = 0.2, spawn_weight = 0},
  }},
  { unit = "medium-biter", spawn_points = {
    {evolution_factor = 0.14, spawn_weight = 0}, 
    {evolution_factor = 0.15, spawn_weight = 1},
    {evolution_factor = 0.3, spawn_weight = 0},
  }},
    { unit = "big-biter", spawn_points = {
    {evolution_factor = 0.25, spawn_weight = 0}, 
    {evolution_factor = 0.3, spawn_weight = 0.5},
    {evolution_factor = 0.8, spawn_weight = 1},
    {evolution_factor = 1, spawn_weight = 0},
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

local timer_dummy = {
    name = "rabbasca-vault-timer",
    type = "container",
    max_health = 100,
    inventory_size = 100,
    -- selectable_in_game = false,
    -- allow_copy_paste = false,
    selection_box = {{-1, -1}, {1, 1}},
    flags = { "not-in-kill-statistics", "not-deconstructable", "not-repairable", "not-rotatable", "placeable-off-grid" },
    -- dying_trigger_effect = {
    --     type = "script",
    --     effect_id = "rabbasca_on_hack_expire"
    -- },
    -- activity_led_light_offsets =
    -- {
    --   {0.296875, -0.40625},
    --   {0.25, -0.03125},
    --   {-0.296875, -0.078125},
    --   {-0.21875, -0.46875}
    -- },
    created_effect = {
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
}

data:extend {
  vault, 
  access_console, 
  extraction_console, 
  research_console,
  defender, timer_dummy
}