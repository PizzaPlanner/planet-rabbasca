-- Some globals black magic or something happening here, required for water borders
table.insert(water_tile_type_names, "rabbasca-harene")
table.insert(water_tile_type_names, "harenic-lava")

local lava_effect = util.merge { data.raw["tile-effect"]["lava"],
{
  name = "harenic-lava",
  foam_color = { 44, 10, 76 },
  
}}
lava_effect.water.textures[2].filename = "__rabbasca-assets__/graphics/recolor/textures/lava.png"
local lava = util.merge{ table.deepcopy(data.raw["tile"]["lava"]), {
    name = "harenic-lava",
    effect_color = { 44, 30, 180 },
    effect_color_secondary = { 140, 52, 111 },
    map_color = { 0.76, 0.33, 0.85 },
    effect = "harenic-lava",
    fluid = "harenic-lava",
    particle_tints = { primary = { 44, 30, 180 }, secondary = { 44, 30, 180 },},
}}
lava.autoplace = nil
lava.variants.main[1].picture = "__rabbasca-assets__/graphics/recolor/textures/lava-transitions.png"
lava.variants.main[2].picture = "__rabbasca-assets__/graphics/recolor/textures/lava-transitions.png"
lava.variants.main[3].picture = "__rabbasca-assets__/graphics/recolor/textures/lava-transitions.png"

data:extend{
{
  type = "collision-layer",
  name = "harene",
},
lava, lava_effect,
util.merge{table.deepcopy(data.raw["tile"]["ammoniacal-ocean"]), {
  name = "rabbasca-harene",
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
util.merge { 
    table.deepcopy(data.raw["tile"]["foundation"]),
    {
      name = "haronite-plate",
      collision_mask = { layers = { harene = true } },
      minable = { result = "haronite-plate" },
      -- variants = { material_background = { picture = "__rabbasca-assets__/graphics/recolor/textures/haronite-plate.png", } },
      frozen_variant = "haronite-plate",
      check_collision_with_entities = true
    }
}
}

local lava_transition = { spritesheet = "__rabbasca-assets__/graphics/recolor/textures/lava-stone-lightmap.png" }
local lava_patch =
{
  filename = "__rabbasca-assets__/graphics/recolor/textures/lava-patch.png",
  scale = 0.5,
  width = 64,
  height = 64
}

for _, tile in pairs({ "rabbasca-rough", "rabbasca-rough-2"}) do
  data.raw["tile"][tile].transitions[2].lightmap_layout = lava_transition
  data.raw["tile"][tile].transitions_between_transitions[1].water_patch = lava_patch 
end