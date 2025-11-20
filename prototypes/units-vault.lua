local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

local defender_1 = util.merge{ 
  table.deepcopy(data.raw["unit"]["small-spitter"]), 
  {
    name = "vault-defender-1",
    icon = "__base__/graphics/icons/defender.png",
    order = "r[rabbasca]-b1",
    max_health = 15,
    healing_per_tick = -0.1 / second,
    movement_speed = 0.13,
    distance_per_frame = 0.125,
    distraction_cooldown = 3 * second,
    has_belt_immunity = true,
    min_pursue_time = 10 * second,
    max_pursue_distance = 36,
    ai_settings = {
      join_attacks = true, -- must be true so spawners keep more than one unit around 
      size_in_group = 1,
      destroy_when_commands_fail = true,
      do_separation = true,
      allow_try_return_to_spawner = true
    },
    radar_range = 1,
    render_layer = "air-object",
  }
}
defender_1.factoriopedia_simulation = table.deepcopy(data.raw["combat-robot"]["defender"].factoriopedia_simulation)
defender_1.corpse = nil
defender_1.absorptions_to_join_attack = { }
defender_1.run_animation = table.deepcopy(data.raw["combat-robot"]["defender"].in_motion)
defender_1.collision_mask = data.raw["combat-robot"]["defender"].collision_mask
defender_1.alternative_attacking_frame_sequence = nil
defender_1.resistances = {
  { type = "physical", percent = 0 },
  { type = "explosion", percent = 0 },
  { type = "fire", percent = 75 },
  { type = "poison", percent = 100 },
  { type = "acid", percent = 100 },
  { type = "laser", percent = 80 },
  { type = "electric", percent = 0 },
}
defender_1.attack_parameters = {
  type = "projectile",
  animation = table.deepcopy(data.raw["combat-robot"]["defender"].idle),
  activation_type = "throw",
  cooldown = 7 * second,
  cooldown_deviation = 0.2,
  projectile_center = {0, 1},
  projectile_creation_distance = 0.6,
  range = 4,
  warmup = 1.5 * second,
  ammo_category = "capsule",
  ammo_type =
  {
    target_type = "position",
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          { type = "create-entity", entity_name = "vault-distractor", offset_deviation = {{-1, -1}, {1, 1}}, repeat_count = 2 }
        }
      }
    }
  }
}
local defender_2 = util.merge {
    table.deepcopy(defender_1), 
{
    name = "vault-defender-2",
    icon = "__base__/graphics/icons/defender.png",
    order = "r[rabbasca]-b2",
    max_health = 24,
    move_while_shooting = true,
    healing_per_tick = -0.3 / second,
    movement_speed = 0.3,
    distance_per_frame = 0.125,
    distraction_cooldown = 20,
    min_pursue_time = 15 * second,
    max_pursue_distance = 50,
  }
}
defender_2.alternative_attacking_frame_sequence = nil
defender_2.resistances = {
  { type = "physical", percent = 0, decrease = 3 },
  { type = "explosion", percent = 0 },
  { type = "fire", percent = 75 },
  { type = "poison", percent = 100 },
  { type = "acid", percent = 100 },
  { type = "laser", percent = 95 },
  { type = "electric", percent = 0 },
}
defender_2.attack_parameters = {
  type = "projectile",
  animation = defender_2.attack_parameters.animation,
  cooldown = 19,
  cooldown_deviation = 0.2,
  projectile_center = {0, 1},
  projectile_creation_distance = 0.6,
  range = 10,
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
            damage = { amount = 5, type = "physical"}
          }
        }
      }
    }
  }
}

local vault_distractor = util.merge {
  table.deepcopy(data.raw["combat-robot"]["distractor"]),
  {
    name = "vault-distractor",
    max_health = 5,
    time_to_live = 8 * second,
    subgroup = defender_1.subgroup,
    order = "r[rabbasca]-c",
    attack_parameters = {
      range = 3,
      damage_modifier = 0.23
    }
  }
}

local defender_heavy = util.merge {
    table.deepcopy(defender_2), 
{
    name = "vault-defender-heavy",
    icon = "__base__/graphics/icons/distractor.png",
    order = "r[rabbasca]-b3",
    max_health = 820,
    healing_per_tick = -3.5 / second,
    move_while_shooting = true,
    movement_speed = 0.12,
    distance_per_frame = 0.08,
    factoriopedia_simulation = table.deepcopy(data.raw["combat-robot"]["distractor"].factoriopedia_simulation)
}
}
defender_heavy.created_effect = {
  type = "direct",
  action_delivery =
  {
    type = "instant",
    source_effects =
    {
      { type = "create-entity", entity_name = "vault-defender-2", offset_deviation = {{-5, -5}, {5, 5}}, repeat_count = 5 },
    }
  }
}
defender_heavy.run_animation = table.deepcopy(data.raw["combat-robot"]["distractor"].in_motion)
defender_heavy.resistances = {
  { type = "physical", percent = 80, decrease = 12 },
  { type = "explosion", percent = 17 },
  { type = "fire", percent = 0 },
  { type = "poison", percent = 100 },
  { type = "acid", percent = 100 },
  { type = "laser", percent = 30 },
  { type = "electric", percent = 50 },
}
defender_heavy.attack_parameters = util.merge {
  vault_distractor.attack_parameters,
  {
    range = 7,
    damage_modifier = 0.15,
    animation = table.deepcopy(data.raw["combat-robot"]["distractor"].idle),
  }
}

local defender_ouchy = util.merge {
    table.deepcopy(defender_2), 
{
    name = "vault-defender-charged",
    icon = "__base__/graphics/icons/destroyer.png",
    order = "r[rabbasca]-b4",
    max_health = 280,
    move_while_shooting = false,
    healing_per_tick = -7 / second,
    movement_speed = 0.44,
    distance_per_frame = 0.213,
  }
}
defender_ouchy.factoriopedia_simulation = table.deepcopy(data.raw["combat-robot"]["destroyer"].factoriopedia_simulation)
defender_ouchy.created_effect = {
  type = "direct",
  action_delivery =
  {
    type = "instant",
    source_effects =
    {
      { type = "create-entity", entity_name = "vault-defender-2", offset_deviation = {{-12, -12}, {12, 12}}, repeat_count = 8 },
    }
  }
}
defender_ouchy.run_animation = table.deepcopy(data.raw["combat-robot"]["destroyer"].in_motion)
defender_ouchy.resistances = {
  { type = "physical", percent = 0, decrease = 14 },
  { type = "explosion", percent = 0 },
  { type = "fire", percent = 0 },
  { type = "poison", percent = 100 },
  { type = "acid", percent = 100 },
  { type = "laser", percent = 90, decrease = 3 },
  { type = "electric", percent = 95 },
}
defender_ouchy.attack_parameters = util.merge {
  table.deepcopy(data.raw["combat-robot"]["destroyer"].attack_parameters),
  {
    range = 4,
    cooldown = 0.3 * second,
    damage_modifier = 2.3,
    animation = table.deepcopy(data.raw["combat-robot"]["destroyer"].idle),
  }
}

local defender_spawny = util.merge {
    table.deepcopy(defender_ouchy), 
{
    name = "vault-defender-spawny",
    icon = "__base__/graphics/icons/destroyer.png",
    order = "r[rabbasca]-d",
    max_health = 320,
    move_while_shooting = false,
    healing_per_tick = -3.2 / second,
    movement_speed = 1.4,
    distance_per_frame = 0.4,
    distraction_cooldown = 20,
    min_pursue_time = 15 * second,
    max_pursue_distance = 30,
  }
}
defender_spawny.created_effect = {
  type = "direct",
  action_delivery =
  {
    type = "instant",
    source_effects =
    {
      -- { type = "create-entity", entity_name = "rabbasca-vault-warp-spawner", offset_deviation = {{-20, -20}, {20, 20}}, repeat_count = 1, check_buildability = true, find_non_colliding_position = true },
      { type = "create-entity", entity_name = "vault-defender-1", offset_deviation = {{-12, -12}, {12, 12}}, repeat_count = 7 },
      { type = "create-entity", entity_name = "vault-defender-heavy", offset_deviation = {{-7, -7}, {7, 7}}, repeat_count = 3 },
    }
  }
}
defender_spawny.resistances = {
  { type = "physical", percent = 25, decrease = 4 },
  { type = "explosion", percent = 5 },
  { type = "fire", percent = 5 },
  { type = "poison", percent = 100 },
  { type = "acid", percent = 100 },
  { type = "laser", percent = 33 },
  { type = "electric", percent = 75 },
}
defender_spawny.attack_parameters = {
  type = "projectile",
  animation = table.deepcopy(data.raw["combat-robot"]["destroyer"].idle),
  activation_type = "throw",
  cooldown = 3 * second,
  cooldown_deviation = 0.3,
  projectile_center = {0, 1},
  projectile_creation_distance = 0.6,
  range = 6.5,
  warmup = 2 * second,
  ammo_category = "capsule",
  ammo_type =
  {
    target_type = "position",
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
              type = "script",
              effect_id = "rabbasca_summon_pylon_grid_aligned",
              repeat_count = 2, 
              repeat_count_deviation = 1
          }
        }
      }
    }
  }
}
defender_spawny.attack_parameters.animation.scale = 2
defender_spawny.run_animation.scale = 2

data:extend{
  vault_distractor, 
  defender_1, defender_2, defender_spawny,
  defender_heavy, defender_ouchy
}