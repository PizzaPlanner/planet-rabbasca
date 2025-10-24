local color = {r=0.73, g=0.42, b=1}

local scrap_resource = util.merge {
  table.deepcopy(data.raw["resource"]["scrap"]),
  {
    name = "rabbascan-scrap",
    minimum = 50,
    normal = 100,
    map_color = { 0.24, 0.31, 0.11 }
  }
}
scrap_resource.minable =
{
  mining_time = 1,
  results =
  {
    { type = "item", name = "plastic-bar",  amount = 1 },
    { type = "item", name = "vault-access-key",  amount = 1, probability = 0.03 },
  }
}
scrap_resource.collision_mask = { layers = { resource = true } }
scrap_resource.autoplace = {
  tile_restriction = { "rabbasca-rough", "rabbasca-rough-2" },
  probability_expression = "rabbasca_scrap",
  richness_expression = "(480 + 89\z 
    * multioctave_noise{x = x, y = y, persistence = 0.44, seed0 = map_seed, input_scale = 1.3, seed1 = 'scrappening', octaves = 6 })\z
    * lerp(1, 50, distance / 10000)\z
    * control:rabbasca_scrap:richness",
}

local mixed_oxide = util.merge {
  table.deepcopy(data.raw["resource"]["calcite"]),
  {
    name = "rabbasca-mixed-oxide-ore",
    map_color = { 0.63, 0.73, 0.95 }
  },
}
mixed_oxide.minable =
{
  mining_time = 0.75,
  results =
  {
    { type = "item", name = "calcite", amount = 1, probability = 0.93 },
    { type = "item", name = "carbon", amount = 1, probability = 0.85 },
    { type = "item", name = "ice",  amount = 1, probability = 0.1 },
  }
}
mixed_oxide.collision_mask = { layers = { resource = true } }
mixed_oxide.autoplace = {
  tile_restriction = { "rabbasca-rough", "rabbasca-rough-2" },
  probability_expression = "rabbasca_rocks(1.14)",
  richness_expression = "(132 + 26\z 
    * multioctave_noise{x = x, y = y, persistence = 0.44, seed0 = map_seed, input_scale = 1.5, seed1 = 'frosty', octaves = 4 })\z
    * lerp(1, 100, distance / 2000)\z
    * control:rabbasca_rocks:richness",
}

local harene_resource = {
  type = "resource",
  name = "harene-vent",
  icons = {{ icon = "__space-age__/graphics/icons/fluorine-vent.png", tint = color }},
  flags = {"placeable-neutral"},
  category = "basic-fluid",
  order="a-b-f",
  infinite = true,
  highlight = true,
  minimum = 20000,
  normal = 100000,
  infinite_depletion_amount = 10,
  resource_patch_search_radius = 48,
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
        name = "harene-gas",
        amount_min = 5,
        amount_max = 5,
      }
    }
  },
  collision_mask = { layers = { resource = true } },
  tile_buildability_rules = {{ 
    area = {{-2.4, -2.4}, {2.4, 2.4}}, 
    required_tiles = { layers = { ground_tile = true } },
    colliding_tiles = { layers = { is_object = true, water_tile = true } },
    remove_on_collision = true 
  }},
  collision_box = {{ -1.5, -1.5}, {1.5, 1.5}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  map_generator_bounding_box = {{-15, -15}, {15, 15}},
  autoplace = {
    tile_restriction = { "rabbasca-rough", "rabbasca-rough-2" },
    probability_expression = "(rabbasca_down > 0) * (rabbasca_harene_pools < 0)\z
      * multioctave_noise{x = x, y = y, persistence = 0.44, seed0 = map_seed, input_scale = 3.6, seed1 = 'atomizedfish', octaves = 4 }\z
      * multioctave_noise{x = x, y = y, persistence = 0.62, seed0 = map_seed, input_scale = 4.3, seed1 = 'unlimitedpower', octaves = 7 }\z
      * multioctave_noise{x = x, y = y, persistence = 0.62, seed0 = map_seed, input_scale = 4.3, seed1 = 'canthisspreadbetterplease', octaves = 7 }",
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
        tint = {r = 0.36, g = 0.31, b = 0.4}
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
        tint = color,
        scale = 1.0,
        shift = util.by_pixel( 0.5, -54.0)
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
        scale = 1.0,
        shift = util.by_pixel( 0.5, -54.0)
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
        tint = util.multiply_color(color, 0.2)
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
data:extend{ harene_resource, scrap_resource, mixed_oxide }

data:extend{ {
    type = "resource-category",
    name = "harene"
},
}