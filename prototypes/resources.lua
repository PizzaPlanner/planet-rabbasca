local color = {r=0.65, g=0.31, b=0.92}

local harene_resource = {
  type = "resource",
  name = "harene-vent",
  icon = "__space-age__/graphics/icons/lithium-brine.png",
  icon_size = 32,
  flags = {"placeable-neutral"},
  category = "harene",
  order="a-b-f",
  infinite = true,
  highlight = true,
  minimum = 20000,
  normal = 100000,
  infinite_depletion_amount = 10,
  resource_patch_search_radius = 5,
  tree_removal_probability = 1.0,
  cliff_removal_probability = 1.0,
  tree_removal_max_distance = 64 * 64,
  minable =
  {
    mining_time = 1,
    results =
    {
      {
        type = "fluid",
        name = "harene",
        amount_min = 1,
        amount_max = 1,
        probability = 1
      }
    }
  },
  collision_mask = { layers = { resource = true } },
  tile_buildability_rules = {{ 
    area = {{-2.4, -2.4}, {2.4, 2.4}}, 
    required_tiles = { layers = { harene = true } },
    colliding_tiles = { layers = { is_object = true } },
    remove_on_collision = true 
  }},
  collision_box = {{ -3.0, -3.0}, {3.0, 3.0}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  autoplace = {
    tile_restriction = { "rabbasca-harene-deep" },
    probability_expression = "rabbasca_harene_vent_probability",
    richness_expression = "rabbasca_harene_richness",
  },
  stage_counts = {0},
  stages =
  {
    layers =
    {
      util.sprite_load("__space-age__/graphics/entity/fluorine-vent/fluorine-vent",
      {
        priority = "extra-high",
        frame_count = 4,
        scale = 1.0,
        tint = util.multiply_color(color, 0.3)
      })
    }
  },

  draw_stateless_visualisation_under_building = false,
  stateless_visualisation =
  {
    {
      count = 1,
      render_layer = "smoke",
      animation = util.sprite_load("__space-age__/graphics/entity/lithium-brine/smoke-1",
      {
        priority = "extra-high",
        frame_count = 64,
        animation_speed = 0.35,
        tint = util.multiply_color(color, 1),
        scale = 1.0
        --shift = util.by_pixel( 0.5, -54.0)
      })
    },
    {
      count = 1,
      render_layer = "smoke",
      animation = util.sprite_load("__space-age__/graphics/entity/lithium-brine/smoke-2",
      {
        priority = "extra-high",
        frame_count = 64,
        animation_speed = 0.35,
        tint = util.multiply_color(color, 0.5),
        scale = 1.0
        --shift = util.by_pixel( 0.5, -54.0)
      })
    },
    {
      count = 1,
      render_layer = "smoke",
      animation = {
        filename = "__space-age__/graphics/entity/fluorine-vent/fluorine-vent-gas-outer.png",
        frame_count = 47,
        line_length = 16,
        width = 90,
        height = 188,
        animation_speed = 0.5,
        shift = util.by_pixel(-2, -40),
        scale = 1.0,
        tint = util.multiply_color(color, 0.1)
      }
    },
    {
      count = 1,
      render_layer = "smoke",
      animation = {
        filename = "__space-age__/graphics/entity/fluorine-vent/fluorine-vent-gas-inner.png",
        frame_count = 47,
        line_length = 16,
        width = 40,
        height = 84,
        animation_speed = 0.5,
        shift = util.by_pixel(0, -14),
        scale = 1.0,
        tint = util.multiply_color(color, 0.1),
      }
    }
  },
  map_color = color,
  map_grid = false
}
data:extend{ harene_resource }

data:extend{ {
    type = "resource-category",
    name = "harene"
},
{
  type = "fluid",
    name = "harene",
    icon = "__space-age__/graphics/icons/fluid/electrolyte.png",
    base_color = color,
    flow_color = color,
    default_temperature = 35.0,
    fuel_value = "100MJ",
    auto_barrel = false
},
{
    type = "fluid",
    name = "beta-carotene",
    icon = "__space-age__/graphics/icons/fluid/thruster-fuel.png",
    base_color = { 0.8, 0.42, 0.02 },
    flow_color = { 0.8, 0.42, 0.02 },
    default_temperature = 14.0,
    auto_barrel = true
},
}