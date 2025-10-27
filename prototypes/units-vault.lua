local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

local vault_distractor = util.merge {
  table.deepcopy(data.raw["combat-robot"]["distractor"]),
  {
    name = "vault-distractor",
    max_health = 5,
    time_to_live = 8 * second,
    order = "r[rabbasca]-b",
    attack_parameters = {
      range = 3,
      damage_modifier = 0.23
    }
  }
}

local defender_1 = util.merge{ 
  table.deepcopy(data.raw["unit"]["small-spitter"]), 
  {
    name = "vault-defender-1",
    icon = "__base__/graphics/icons/defender.png",
    order = "r[rabbasca]-a",
    max_health = 16,
    healing_per_tick = 0,
    movement_speed = 0.13,
    distance_per_frame = 0.125,
    distraction_cooldown = 3 * second,
    has_belt_immunity = true,
    min_pursue_time = 10 * second,
    max_pursue_distance = 36,
    -- absorptions_to_join_attack = { ["vault-activity"] = 10 },
    -- loot = { { item = "firearm-magazine", count_min = 3, count_max = 3 } },
    -- radar_range = 1,
    ai_settings = {
      join_attacks = true,
      size_in_group = 1,
      destroy_when_commands_fail = true,
      do_separation = true,
      allow_try_return_to_spawner = true
    },
    radar_range = 1,
    render_layer = "air-object",
  }
}
defender_1.run_animation = table.deepcopy(data.raw["combat-robot"]["defender"].in_motion)
defender_1.collision_mask = { layers = { } }
defender_1.alternative_attacking_frame_sequence = nil
defender_1.attack_parameters = {
  type = "projectile",
  animation = table.deepcopy(data.raw["combat-robot"]["defender"].idle),
  activation_type = "throw",
  cooldown = 15 * second,
  cooldown_deviation = 0.2,
  projectile_center = {0, 1},
  projectile_creation_distance = 0.6,
  range = 4,
  warmup = 1 * second,
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
    table.deepcopy(data.raw["unit"]["medium-spitter"]), 
{
    name = "vault-defender-2",
    icon = "__base__/graphics/icons/defender.png",
    order = "r[rabbasca]-c",
    max_health = 24,
    healing_per_tick = -0.2 / second,
    movement_speed = 0.3,
    distance_per_frame = 0.125,
    distraction_cooldown = 20,
    min_pursue_time = 15 * second,
    max_pursue_distance = 50,
  }
}
defender_2.collision_mask = { layers = { } }
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

data:extend{
  vault_distractor, 
  defender_1, defender_2,
}