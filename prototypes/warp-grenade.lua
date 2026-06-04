
data:extend{
    {
      type = "explosion",
      name = "rabbasca-warp-grenade-fissure",
      flags = {"not-on-map"},
      hidden = true,
      icon = "__base__/graphics/icons/small-scorchmark.png",
      subgroup = "explosions",
      height = 0,
      render_layer = "ground-patch-higher2",
      created_effect =
      {
        {
          type = "direct",
          action_delivery =
          {
            {
                type = "instant",
                target_effects = {
                    type = "create-entity",
                    entity_name = "big-explosion"
                }
            },
            {
                type = "delayed",
                delayed_trigger = "rabbasca-warp-grenade-fissure-explosion-delay"
            }
          }
        },
      },
      animations = 
      {
        filename = "__rabbasca-assets__/graphics/recolor/textures/warp-grenade-effect.png",
        frame_count = 12,
        line_length = 4,
        width = 3704 / 4,
        height = 2872 / 4,
        priority = "high",
        --frame_count/fissure_eruption_ticks
        animation_speed = 0.25,
        run_mode = "forward-then-backward",
        draw_as_glow = true,
        scale = 0.35,
      },
      light =
      {
        intensity = 1,
        size = 30,
        color = {r = 1.0, g = 0.5, b = 0}
      },
      light_intensity_factor_final = 1,
      light_size_factor_final = 1
    },
    {
      type = "delayed-active-trigger",
      name = "rabbasca-warp-grenade-fissure-explosion-delay",
      delay = 30,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            target_effects =
            {
              {
                type = "create-entity",
                entity_name = "rabbasca-warp-grenade-anomaly"
              },
              {
                type = "destroy-decoratives",
                from_render_layer = "decorative",
                to_render_layer = "object",
                include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                include_decals = false,
                invoke_decorative_trigger = true,
                decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                radius = 3 -- large radius for demostrative purposes
              }
            }
          }
        }
      }
    },
    {
      type = "explosion",
      name = "rabbasca-warp-grenade-anomaly",
      flags = {"not-on-map"},
      hidden = true,
      icon = "__base__/graphics/icons/explosion.png",
      subgroup = "explosions",
      height = 0,
      animations = util.empty_sprite(),
      sound =
      {
        aggregation =
        {
          max_count = 1,
          remove = true
        },
        switch_vibration_data =
        {
          filename = "__base__/sound/fight/medium-explosion.bnvib",
          gain = 1.0
        },
        audible_distance_modifier = 0.5,
        variations = sound_variations("__base__/sound/fight/medium-explosion", 5, 1, volume_multiplier("main-menu", 1.2) )
      },
      created_effect =
      {
        {
          type = "area",
          ignore_collision_condition = true,
          radius = 3.3,
          action_delivery =
          {
            type = "instant",
            target_effects =
            {
              {
                type = "script",
                effect_id = "rabbasca_on_warp_explosion"
              },
            }
          }
        },
      }
    },
}