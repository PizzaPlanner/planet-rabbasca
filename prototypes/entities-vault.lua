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
        effect_id = "rabbasca_on_recalc_evolution"
      }
    }
  }
}

local spawner = util.merge{ 
  table.deepcopy(data.raw["unit-spawner"]["spitter-spawner"]), 
{
  name = "rabbasca-vault-spawner",
  type = "unit-spawner",
  icon = "__Krastorio2Assets__/icons/entities/singularity-beacon.png",
  icon_size = 64,
  max_health = 7200,
  healing_per_tick = 3.6 / second,
  spawning_cooldown = {5 * second, 0.7 * second},
  max_count_of_owned_units = 20,
  max_count_of_owned_defensive_units = 1,
  max_friends_around_to_spawn = 8,
  max_defensive_friends_around_to_spawn = 1,
  captured_spawner_entity = "rabbasca-vault-console",
  time_to_capture = 20 * second,
  spawning_radius = 12,
  collision_box = {{-0.7, -0.7},{0.7, 0.9}},
  selection_box = {{-0.8, -0.8},{0.8, 1.0}},
  order = "r[rabbasca]-a"
}}
spawner.corpse = nil
spawner.autoplace = nil -- IMPORTANT: prevents spawning on nauvis
spawner.spawn_decoration = {}
spawner.damaged_trigger_effect = nil
spawner.absorptions_per_second = { }
spawner.flags = { "placeable-enemy", "not-deconstructable", "not-repairable", "not-rotatable", "player-creation", "placeable-off-grid" }
spawner.created_effect = {
  type = "direct",
  action_delivery = {
    {
      type = "delayed",
      delayed_trigger = "rabbasca-calculate-evolution"
    },
    {
      type = "instant",
      source_effects = {
        type = "script",
        effect_id = "rabbasca_init_spawner"
      }
    }
  }
}
spawner.resistances = {
  { type = "physical", percent = 90, decrease = 80,  },
  { type = "explosion", percent = 85, decrease = 200, },
  { type = "fire", percent = 90 },
  { type = "poison", percent = 100 },
  { type = "acid", percent = 100 },
  { type = "laser", percent = 95, decrease = 15 },
  { type = "electric", percent = 87, decrease = 40, },
  { type = "impact", percent = 80 },
}
spawner.result_units = {
{ unit = "vault-defender-1", spawn_points = {
    {evolution_factor = 0, spawn_weight = 1}, 
    {evolution_factor = 0.05, spawn_weight = 1},
    {evolution_factor = 0.1, spawn_weight = 0.3},
    {evolution_factor = 0.3, spawn_weight = 0},
  }},
{ unit = "vault-defender-2", spawn_points = {
    {evolution_factor = 0.1, spawn_weight = 0}, 
    {evolution_factor = 0.15, spawn_weight = 0.5},
    {evolution_factor = 0.35, spawn_weight = 0.2},
    {evolution_factor = 0.5, spawn_weight = 0.1},
  }},
{ unit = "vault-defender-heavy", spawn_points = {
    {evolution_factor = 0.25, spawn_weight = 0}, 
    {evolution_factor = 0.3, spawn_weight = 0.6},
    {evolution_factor = 1, spawn_weight = 0.4},
  }},
{ unit = "vault-defender-charged", spawn_points = {
    {evolution_factor = 0.4, spawn_weight = 0}, 
    {evolution_factor = 0.45, spawn_weight = 0.4},
    {evolution_factor = 1, spawn_weight = 0.6},
  }},
{ unit = "vault-defender-spawny", spawn_points = {
    {evolution_factor = 0.6, spawn_weight = 0}, 
    {evolution_factor = 0.65, spawn_weight = 0.01},
    {evolution_factor = 1, spawn_weight = 0.07},
  }},
}
spawner.graphics_set =
{
  animations = {
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
} }

local access_console = util.merge{
  table.deepcopy(spawner),
  {
    name = "rabbasca-vault-console",
    type = "assembling-machine",
    max_health = 7200,
    healing_per_tick = -72 / second, -- does not do anything; just for factoriopedia
    production_health_effect = {
      producing = -12 / second * 10 - 80, -- Values are per tick, reduced by physical resistance, both percentual and flat
      not_producing = -72 / second * 10 - 80
    },
    enable_logistic_control_behavior = false,
    -- show_recipe_icon = false,
    result_inventory_size = 0,
    source_inventory_size = 1,
    crafting_speed = 1,
    energy_usage = "1MW",
    allow_copy_paste = true,
    module_slots = 0,
    fixed_recipe = "rabbasca-extend-hack-vault-security-key",
    return_ingredients_on_change = true,
    ignore_output_full = true,
    is_military_target = true,
    no_ears_upgrade = true,
    hidden_in_factoriopedia = true,
    cant_insert_at_source_message_key = "inventory-restriction.not-a-vault-key",
  }
}
access_console.created_effect = {
  type = "direct",
  action_delivery = {
    type = "delayed",
    delayed_trigger = "rabbasca-calculate-evolution"
  }
}
access_console.flags = { "placeable-player", "not-deconstructable", "not-repairable",  "not-rotatable", "player-creation", "placeable-off-grid" }
access_console.circuit_connector = nil
access_console.circuit_connector_flipped = nil
access_console.allowed_effects = { }
access_console.next_upgrade = nil
access_console.minable = nil
access_console.crafting_categories = { "rabbasca-vault-hacking" }
access_console.dying_trigger_effect = {
  {
    type = "create-entity",
    as_enemy = true,
    entity_name = "rabbasca-vault-spawner",
    ignore_no_enemies_mode = true,
    protected = true,
  },
}
access_console.fluid_boxes = { } 
access_console.energy_source = {
  type = "void"
}
access_console.graphics_set = {
  animation = spawner.graphics_set.animations[1],
  idle_animation = spawner.graphics_set.animations[1]
}

local vault_crafter = {
  name = "rabbasca-vault-crafter",
  type = "assembling-machine",
  icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png",
  icon_size = 64,
  max_health = 72000,
  production_health_effect = {
      not_producing = 100,
      producing = 100
  },
  friendly_map_color = {0.3, 1, 0.3},
  map_generator_bounding_box = {{-16, -16}, {16, 16}},
  collision_box = {{-2.4, -1.9},{2.4, 2.2}},
  selection_box = {{-2.5, -2.5},{2.5, 2.5}},
  selection_priority = 30,
  subgroup = "enemies",
  order = "r[rabbasca]-a",
  crafting_speed = 1,
  energy_usage = "1MW",
  allow_copy_paste = true,
  module_slots = 2,
  disabled_when_recipe_not_researched = true,
  autoplace = { probability_expression = "rabbasca_vaults > 0.85", force = "neutral" },
  flags = { "placeable-player", "not-rotatable"},
  allowed_effects = { "speed", "consumption", "pollution", "quality" },
  energy_source = {
    type = "burner",
    burner_usage = "food",
    effectivity = 1,
    fuel_categories = { "carotene" },
    fuel_inventory_size = 1
  },
  crafting_categories = { "rabbasca-vault-extraction" },
  circuit_wire_max_distance = 32,
  circuit_connector = data.raw["assembling-machine"]["foundry"].circuit_connector,
  icon_draw_specification = data.raw["assembling-machine"]["foundry"].icon_draw_specification,
  icons_positioning = data.raw["assembling-machine"]["foundry"].icons_positioning,
  resistances = {
    { type = "physical", percent = 95, decrease = 8000 },
    { type = "explosion", percent = 80, decrease = 400 },
    { type = "fire", percent = 100 },
    { type = "poison", percent = 100 },
    { type = "acid", percent = 100 },
    { type = "laser", percent = 100 },
    { type = "electric", percent = 99 },
    { type = "impact", percent = 99 },
  },
  graphics_set = {
    animation = {
        filename = "__Krastorio2Assets__/buildings/stabilizer-charging-station/stabilizer-charging-station.png",
        priority = "high",
        width = 170,
        height = 170,
        frame_count = 80,
        line_length = 10,
        scale = 1.5
    },
    idle_animation = {
        filename = "__Krastorio2Assets__/buildings/stabilizer-charging-station/stabilizer-charging-station.png",
        priority = "high",
        width = 170,
        height = 170,
        frame_count = 80,
        line_length = 10,
        scale = 1.5
    },
  },
  created_effect = {
    type = "direct",
    action_delivery =
    {
      type = "instant",
      target_effects =
      {
        {
          type = "create-entity",
          entity_name = "rabbasca-vault-spawner",
          offsets = {{2, 2.2}},
          protected = true,
        },
      }
    } 
  },
  dying_trigger_effect = {
    type = "create-entity",
    entity_name = "rabbasca-vault-meltdown",
    as_enemy = true,
    ignore_no_enemies_mode = true,
    protected = true,
  }
}

local pylon = util.merge{ 
  table.deepcopy(spawner), 
{
  name = "rabbasca-vault-warp-spawner",
  icon = "__rabbasca-assets__/graphics/by-hurricane/conduit-icon.png",
  icon_size = 64,
  max_health = 2336, -- will be much higher due to evolution
  healing_per_tick = -35 / second,
  spawning_cooldown = {4 * second, 2.5 * second},
  time_to_capture = 60 * second,
  max_count_of_owned_units = 16,
  max_friends_around_to_spawn = 64,
  spawning_radius = 8,
  captured_spawner_entity = "rabbasca-warp-pylon",
  collision_box = {{-0.9, -0.9},{0.9, 0.9}},
  selection_box = {{-1, -1},{1, 1}},
  order = "r[rabbasca]-b"
}}
pylon.flags = { "placeable-enemy" }
pylon.created_effect = nil
pylon.resistances = {
  { type = "physical", percent = 99 },
  { type = "explosion", percent = 10, decrease = 80 },
  { type = "fire", percent = 25 },
  { type = "poison", percent = 100 },
  { type = "acid", percent = 100 },
  { type = "laser", percent = 99 },
  { type = "electric", percent = 30 },
  { type = "impact", percent = 5 },
}
pylon.result_units = {
{ unit = "vault-defender-2", spawn_points = {
    {evolution_factor = 0.0, spawn_weight = 0.3}, 
    {evolution_factor = 1.0, spawn_weight = 0.3},
  }},
{ unit = "vault-defender-heavy", spawn_points = {
    {evolution_factor = 0.0, spawn_weight = 0.7}, 
    {evolution_factor = 1.0, spawn_weight = 0.7},
  }},
{ unit = "vault-defender-charged", spawn_points = {
    {evolution_factor = 0.0, spawn_weight = 0.4}, 
    {evolution_factor = 1.0, spawn_weight = 0.4},
  }},
}
pylon.graphics_set =
{
  animations = {
    layers =
    {
      {
          filename = "__rabbasca-assets__/graphics/by-hurricane/conduit-animation.png",
          frame_count = 60,
          line_length = 10,
          width = 200,
          height = 290,
          scale = 1.0/3,
          flags = {"no-scale"},
          shift = {0, -0.5},
      },
      {
          filename = "__rabbasca-assets__/graphics/by-hurricane/conduit-hr-shadow.png",
          repeat_count = 60,
          width = 600,
          height = 400,
          scale = 1.0/3,
          draw_as_shadow = true,
          shift = {0, -0.5},
      },
      {
          filename = "__rabbasca-assets__/graphics/by-hurricane/conduit-emission.png",
          frame_count = 60,
          line_length = 10,
          width = 200,
          height = 290,
          draw_as_glow = true,
          blend_mode = "additive-soft",
          scale = 1.0/3,
          shift = {0, -0.5},
          tint = {1.0, 0.11, 0.32}
      },
    },
}}

local vault_core = util.merge{ 
  table.deepcopy(pylon), 
{
  name = "rabbasca-vault-meltdown",
  icons = {
    { icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64 },
    { icon = data.raw["virtual-signal"]["signal-explosion"].icon, icon_size = 64, scale = 0.3, shift = { 8, 8 } }
  },
  hidden = true,
  hidden_in_factoriopedia = true,
  max_health = 3000, -- Will always be *10 due to forced max evolution
  healing_per_tick = -1000 / second,
  spawning_cooldown = {0.3 * second, 0.3 * second},
  max_count_of_owned_units = 64,
  max_friends_around_to_spawn = 128,
  spawning_radius = 8,
  collision_box = {{-0.4, -0.4},{0.4, 0.4}},
  selection_box = {{-0.5, -1},{1, 1}},
  order = "r[rabbasca]-x",
}}
vault_core.collision_mask = { 
  layers = { }, 
  colliding_with_tiles_only = true,
}
vault_core.flags = { "placeable-neutral", "placeable-off-grid" }
vault_core.minable = nil
vault_core.captured_spawner_entity = nil
vault_core.created_effect = {
  type = "direct",
  action_delivery = {
    {
      type = "delayed",
      delayed_trigger = "rabbasca-calculate-evolution"
    }
  }
}
vault_core.dying_trigger_effect = require("__planet-rabbasca__.prototypes.meltdown")
vault_core.resistances = { } -- filled later
vault_core.result_units = {
{ unit = "big-strafer-pentapod", spawn_points = {
  {evolution_factor = 0, spawn_weight = 0.3},
  }},
{ unit = "big-stomper-pentapod", spawn_points = {
  {evolution_factor = 0, spawn_weight = 0.3},
  }},
{ unit = "behemoth-biter", spawn_points = {
  {evolution_factor = 0, spawn_weight = 0.3},
  }},
{ unit = "behemoth-spitter", spawn_points = {
    {evolution_factor = 0, spawn_weight = 0.3},
  }},
}
vault_core.graphics_set = {
  animations = {
    layers =
    {
      {
          filename = "__rabbasca-assets__/graphics/by-hurricane/conduit-emission.png",
          frame_count = 60,
          line_length = 10,
          width = 200,
          height = 290,
          draw_as_glow = true,
          blend_mode = "additive-soft",
          scale = 1.0/3,
          shift = {0, -0.5},
          tint = {1.0, 0, 0}
      },
    },
}}
local capture_bot = {
  type = "capture-robot",
  icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png",
  icon_size = 64,
  name = "rabbasca-capture-robot",
  capture_speed = 1,
  max_health = 100,
  speed = 0.01,
  hidden_in_factoriopedia = true,
  alert_when_damaged = false,
}

local capture_bot_2 = {
  type = "capture-robot",
  icon = "__Krastorio2Assets__/icons/cards/advanced-tech-card.png",
  icon_size = 64,
  name = "rabbasca-capture-robot-2",
  capture_speed = 1.4,
  max_health = 800,
  speed = 0.01,
  hidden_in_factoriopedia = true,
  alert_when_damaged = false,
}

data:extend {
  delayed_recalc_trigger,
  spawner, pylon,
  access_console,
  capture_bot, capture_bot_2,
  vault_crafter, vault_core
}

data:extend {
  {
    type = "explosion",
    name = "rabbasca-meltdown-effect",
    flags = {"not-on-map"},
    hidden = true,
    icons =
    {
      {icon = "__base__/graphics/icons/explosion.png"},
      {icon = "__base__/graphics/icons/atomic-bomb.png"}
    },
    localised_name = {"entity-name.rabbasca-vault-meltdown"},
    order = "a-d-a-b",
    subgroup = "explosions",
    height = 0,
    animations = util.empty_sprite(),
    surface_conditions = { Rabbasca.above_harenic_threshold() },
    created_effect =
    {
      type = "direct",
      action_delivery =
      {
      {
        type = "delayed",
        delayed_trigger = "rabbasca-calculate-evolution"
      },
      {
        type = "instant",
        target_effects =
        {
          {
            type = "set-tile",
            tile_name = "rabbasca-wasted",
            radius = 43,
            apply_projection = false,
            tile_collision_mask = { layers={out_of_map=true, water_tile = true} }
          },
          {
            type = "set-tile",
            tile_name = "rabbasca-harenic-sludge",
            radius = 6,
            apply_projection = false,
            tile_collision_mask = { layers={out_of_map=true} },
          },
          {
            type = "create-entity",
            entity_name = "harenic-lava-spreader",
          },
          {
            type = "nested-result",
            action =
            {
              type = "cluster",
              cluster_count = 32,
              distance = 15,
              distance_deviation = 40,
              action_delivery =
              {
                type = "instant",
                target_effects = {
                  {
                    type = "set-tile",
                    tile_name = "rabbasca-harenic-sludge",
                    radius = 3,
                    apply_projection = false,
                    tile_collision_mask = { layers={out_of_map=true} },
                  },
                  {
                    type = "create-entity",
                    entity_name = "harenic-lava-spreader",
                  },
                }
              }
            }
          },
        }
      }
      }
    }
  },
  {
    type = "temporary-container",
    name = "harenic-lava-spreader",
    icon = "__rabbasca-assets__/graphics/recolor/icons/harenic-lava.png",
    icon_size = 64,
    flags = { "not-on-map", "not-in-kill-statistics", "placeable-neutral" },
    collision_mask = { 
      layers = { lava_tile = true, out_of_map = true, ground_tile = true }, 
      consider_tile_transitions = true,
      colliding_with_tiles_only = true,
    },
    inventory_size = 0,
    hidden = true,
    hidden_in_factoriopedia = true,
    max_health = 99999,
    time_to_live = 4,
    -- alert_after_time = 1,
    destroy_on_empty = false,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{-0.2, -0.2}, {0.2, 0.2}},
    dying_trigger_effect = {
      type = "script",
      effect_id = "rabbasca_replace_tiles",
    },
    resistances = {
      { type = "physical", percent = 100  },
      { type = "explosion", percent = 100, },
      { type = "fire", percent = 100 },
      { type = "poison", percent = 100 },
      { type = "acid", percent = 100 },
      { type = "laser", percent = 100 },
      { type = "electric", percent = 100 },
      { type = "impact", percent = 100 },
    }
  },
}