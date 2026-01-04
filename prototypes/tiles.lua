-- Some globals black magic or something happening here, required for water borders
table.insert(water_tile_type_names, "rabbasca-harenic-sludge")
table.insert(water_tile_type_names, "harenic-lava")
table.insert(out_of_map_tile_type_names, "rabbasca-underground-out-of-map")

local lava_effect = util.merge { data.raw["tile-effect"]["lava"],
{
  name = "harenic-lava",
  foam_color = { 44, 10, 76 },
  
}}
lava_effect.water.textures[2].filename = "__rabbasca-assets__/graphics/recolor/textures/lava.png"
local lava = util.merge{ table.deepcopy(data.raw["tile"]["lava"]), {
    name = "harenic-lava",
    effect_color = { 111, 30, 180 },
    effect_color_secondary = { 140, 52, 111 },
    map_color = { 0.5, 0.15, 0.85 },
    effect = "harenic-lava",
    fluid = "harenic-lava",
    particle_tints = { primary = { 111, 30, 180 }, secondary = { 145, 30, 180 },},
}}
lava.autoplace = nil
lava.variants.main[1].picture = "__rabbasca-assets__/graphics/recolor/textures/lava-transitions.png"
lava.variants.main[2].picture = "__rabbasca-assets__/graphics/recolor/textures/lava-transitions.png"
lava.variants.main[3].picture = "__rabbasca-assets__/graphics/recolor/textures/lava-transitions.png"

table.insert(data.raw["item"]["foundation"].place_as_tile.tile_condition, "harenic-lava")
table.insert(data.raw["item"]["foundation"].place_as_tile.tile_condition, "rabbasca-harenic-sludge")

data:extend{
{
  type = "collision-layer",
  name = "harene",
},
lava, lava_effect,
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
util.merge{ table.deepcopy(data.raw["tile"]["volcanic-ash-cracks"]), {
    name = "rabbasca-wasted",
    autoplace = nil,
    map_color = {0.05, 0.01, 0.04},
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
util.merge{ table.deepcopy(data.raw["tile"]["volcanic-ash-flats"]), {
    name = "rabbasca-underground-rubble",
    autoplace = { probability_expression = "0" },
    map_color = { 0.17, 0.06, 0.1 },
}},
util.merge { 
    table.deepcopy(data.raw["tile"]["out-of-map"]),
    {
      name = "rabbasca-underground-out-of-map",
      autoplace = { probability_expression = "(0.25 - rabbasca_underground_elevation) * 2" }
    }
},
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
    table.deepcopy(data.raw["tile"]["space-platform-foundation"]),
    {
      name = "haronite-plate",
      collision_mask = { layers = { harene = true } },
      minable = { result = "haronite-plate" },
      max_health = 500,
      layer = data.raw["tile"]["foundation"].layer,
      transition_overlay_layer_offset = 2,
      layer_group = "ground-artificial",
      variants = { 
        material_background = { picture = "__rabbasca-assets__/graphics/foundation/haronite-plate.png", count = 1 }, 
        transition = table.deepcopy(data.raw["tile"]["foundation"].variants.transition)
      },
      allowed_neighbors = { "space-platform-foundation" },
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

for _, tile in pairs({ "rabbasca-rough", "rabbasca-rough-2", "rabbasca-wasted"}) do
  data.raw["tile"][tile].transitions[2].lightmap_layout = lava_transition
  data.raw["tile"][tile].transitions_between_transitions[1].water_patch = lava_patch 
end

data.raw["tile"]["haronite-plate"].bound_decoratives = nil