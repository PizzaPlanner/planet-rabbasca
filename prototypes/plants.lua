data:extend{ 
{
    type = "plant",
    name = "rabbasca-carrot", -- in water. science
    icon = "__space-age__/graphics/icons/jellystem.png",
    flags = plant_flags,
    minable =
    {
      mining_particle = "jellystem-mining-particle",
      mining_time = 0.5,
      results = {{type = "item", name = "rabbasca-carotene-powder", amount = 50}},
    },
    mining_sound = sound_variations("__space-age__/sound/mining/axe-mining-jellystem", 5, 0.4),
    mined_sound = sound_variations("__space-age__/sound/mining/mined-jellystem", 6, 0.35),
    growth_ticks = 5 * minutes,
    emissions_per_second = { },
    harvest_emissions = { },
    max_health = 170,
    collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
    --collision_mask = {layers={player=true, ground_tile=true, train=true}},
    selection_box = {{-1, -3}, {1, 0.8}},
    drawing_box_vertical_extension = 0.8,
    subgroup = "trees",
    order = "a[tree]-c[rabbasca]-a[seedable]-b[carrot]",
    impact_category = "tree",
    factoriopedia_simulation = simulations.factoriopedia_jellystem,
    autoplace =
    {
      control = "rabbasca_plants",
      order = "a[tree]-b[forest]-b",
      probability_expression = "rabbasca_carrot_noise",
      richness_expression = "random_penalty_at(3, 1)",
      tile_restriction = {"rabbasca-fertile"}
    },
    variations = gleba_tree_variations("jellystem", 8, 4, 1.3, 640, 560, util.by_pixel(52, -73)),
    colors = {
      {r = 255, g = 150, b =  11},
      {r = 233, g = 140, b =  42},
      --{r = 207, g = 202, b =  235},
      {r = 255, g = 132, b =  17},
      {r = 230, g = 167, b =  23},
      {r = 242, g = 155, b =  18},
      {r = 230, g = 140, b =  22},
    },
    agricultural_tower_tint =
    {
      primary = {r = 0.620, g = 0.307, b = 0.461, a = 1.000}, -- #eac1f5ff
      secondary = {r = 0.336, g = 0.624, b = 0.340, a = 1.000}, -- #885289ff
    },
    ambient_sounds =
    {
      sound =
      {
        variations = sound_variations("__space-age__/sound/world/plants/jellystem", 8, 0.5),
        advanced_volume_control =
        {
          fades = {fade_in = {curve_type = "cosine", from = {control = 0.5, volume_percentage = 0.0}, to = {1.5, 100.0}}}
        }
      },
      radius = 7.5,
      min_entity_count = 2,
      max_entity_count = 10,
      entity_to_sound_ratio = 0.5,
      average_pause_seconds = 7
    },
    map_color = {230, 140, 15},
    -- tile_buildability_rules = { {area = {{-0.55, -0.55}, {0.55, 0.55}}, required_tiles = {"natural-jellynut-soil", "artificial-jellynut-soil"}, remove_on_collision = true} },
  },
}