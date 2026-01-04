local color = {r=0.73, g=0.42, b=1}

local carrot_ore = util.merge {
  table.deepcopy(data.raw["resource"]["copper-ore"]),
  {
    name = "carotenoid-ore",
    minimum = 50,
    normal = 100,
    map_color = { 0.82, 0.52, 0.215 },
    stages = { sheet = { filename = "__rabbasca-assets__/graphics/recolor/icons/carotenoid-ore.png" } },
    resource_patch_search_radius = 32,
  }
}
carrot_ore.icon = data.raw["item"]["carotenoid-ore"].icon
carrot_ore.minable =
{
  mining_time = 2,
  mining_particle = "copper-ore-particle",
  results =
  {
    { type = "item", name = "carotenoid-ore",  amount = 1 },
  }
}
carrot_ore.collision_mask = { layers = { resource = true } }
carrot_ore.autoplace = {
  tile_restriction = { "rabbasca-fertile" },
  probability_expression = "rabbasca_carrot_noise",
  richness_expression = "(480 + 89\z 
    * multioctave_noise{x = x, y = y, persistence = 0.44, seed0 = map_seed, input_scale = 1.3, seed1 = 'noglassesneeded', octaves = 6 })\z
    * lerp(1, 50, distance / 5000)\z
    * control:rabbasca_carotenoids:richness",
}

local battle_scrap = util.merge {
  table.deepcopy(data.raw["resource"]["scrap"]),
  {
    name = "rabbascan-scrap",
    map_color = { 0.83, 0.217, 0.13 }
  },
}
battle_scrap.minable =
{
  mining_time = 0.75,
  results =
  {
    { type = "item", name = "firearm-magazine", amount = 1, probability = 0.15 },
    { type = "item", name = "grenade", amount = 1, probability = 0.13 },
    { type = "item", name = "rocket", amount = 1, probability = 0.09 },
    { type = "item", name = "flamethrower-ammo", amount = 1, probability = 0.07 },
    { type = "item", name = "vault-access-key", amount = 1, probability = 0.06 },
  }
}
battle_scrap.collision_mask = { layers = { resource = true } }
battle_scrap.autoplace = {
  tile_restriction = { "rabbasca-rough", "rabbasca-rough-2" },
  probability_expression = "rabbasca_vaults * (rabbasca_vaults < 0.7) * (0.53 + 0.8 * multioctave_noise{x = x, y = y, persistence = 0.8, seed0 = map_seed, input_scale = 0.86, seed1 = 'scrappening', octaves = 4 })",
  richness_expression = "(17 + 9\z 
    * multioctave_noise{x = x, y = y, persistence = 0.44, seed0 = map_seed, input_scale = 1.5, seed1 = 'whoneedscircuits', octaves = 4 })\z
    * lerp(2, 20, distance / 2000)\z
    * control:rabbasca_vaults:richness",
}

local harene_resource = {
  type = "resource",
  name = "harene-vent",
  icons = {{ icon = "__space-age__/graphics/icons/fluorine-vent.png", icon_size = 64, tint = color }},
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
    probability_expression = "(rabbasca_down(1) > 0) * (rabbasca_harene_pools < 0)\z
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
data:extend{ harene_resource, carrot_ore, battle_scrap }