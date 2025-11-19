-- Some globals black magic or something happening here, required for water borders
table.insert(water_tile_type_names, "rabbasca-harenic-sludge")

data:extend{
{
  type = "collision-layer",
  name = "harene",
},
util.merge{table.deepcopy(data.raw["tile"]["ammoniacal-ocean"]), {
  name = "rabbasca-harenic-sludge",
  default_cover_tile = "foundation",
  autoplace = { probability_expression = "rabbasca_harene_pools" },
  -- destroys_dropped_items = true,
  effect = "brash-ice-2",
  effect_color = {60,55,97},
  effect_color_secondary = { 70, 40, 120 },
  map_color = { 0.4, 0.1, 0.65},
  fluid = "energetic-residue"
}},
util.merge{ table.deepcopy(data.raw["tile"]["volcanic-ash-flats"]), {
    name = "rabbasca-rough",
    autoplace = { probability_expression = "rabbasca_rocky + rabbasca_rocky_variance" },
    map_color = {0.07, 0.06, 0.1},
}},
util.merge{ table.deepcopy(data.raw["tile"]["volcanic-pumice-stones"]), {
    name = "rabbasca-rough-2",
    autoplace = { probability_expression = "rabbasca_rocky" },
    map_color = {0.07, 0.061, 0.1},
}},
util.merge{ table.deepcopy(data.raw["tile"]["midland-yellow-crust-2"]), {
    name = "rabbasca-fertile",
    autoplace = { probability_expression = "rabbasca_fertile" },
    map_color = {0.61, 0.282, 0.1},
}},
util.merge { 
    table.deepcopy(data.raw["tile"]["concrete"]),
    {
      name = "rabbasca-energetic-concrete",
      collision_mask = { layers = { harene = true } },
      -- material_background = { tint  = {60,55,97}, },
      minable = { result = "rabbasca-energetic-concrete" },
      variants = { material_background = { picture = "__rabbasca-assets__/graphics/recolor/icons/concrete.png", } },
      frozen_variant = "rabbasca-energetic-concrete",
      check_collision_with_entities = true
    }
},
}