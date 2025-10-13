local tile_trigger_effects = require("__space-age__/prototypes/tile/tile-trigger-effects")
local tile_pollution = require("__space-age__/prototypes/tile/tile-pollution-values")
local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")
local base_sounds = require("__base__/prototypes/entity/sounds")
local base_tile_sounds = require("__base__/prototypes/tile/tile-sounds")
local tile_sounds = require("__space-age__/prototypes/tile/tile-sounds")

local tile_graphics = require("__base__/prototypes/tile/tile-graphics")
local tile_spritesheet_layout = tile_graphics.tile_spritesheet_layout

local patch_for_inner_corner_of_transition_between_transition = tile_graphics.patch_for_inner_corner_of_transition_between_transition

local smooth_ice_vehicle_speed_modifier = 1
local ice_vehicle_speed_modifier = 1.4
local snow_vehicle_speed_modifier = 1.8

default_transition_group_id = default_transition_group_id or 0
water_transition_group_id = water_transition_group_id or 1
out_of_map_transition_group_id = out_of_map_transition_group_id or 2
lava_transition_group_id = lava_transition_group_id or 3

table.insert(water_tile_type_names, "rabbasca-harene")

local foundation_transitions =
{
  {
    to_tiles = water_tile_type_names,
    transition_group = water_transition_group_id,

    spritesheet = "__space-age__/graphics/terrain/water-transitions/foundation.png",
    layout = tile_spritesheet_layout.transition_8_8_8_4_4,
    background_enabled = false,
    effect_map_layout =
    {
      spritesheet = "__base__/graphics/terrain/effect-maps/water-stone-mask.png",
      inner_corner_count = 1,
      outer_corner_count = 1,
      side_count = 1,
      u_transition_count = 1,
      o_transition_count = 1
    }
  },
  concrete_to_out_of_map_transition
}

tile_collision_masks.harene = function() 
return {
    layers = { 
        resource = true, 
        harene = true,
    }}
end

local harene_tile = util.merge{table.deepcopy(data.raw["tile"]["ammoniacal-ocean"]), {
  name = "rabbasca-harene",
  -- subgroup = "aquilo-tiles",
--   allowed_neighbors = { "water" },
  default_cover_tile = "foundation",
  autoplace = { probability_expression = "rabbasca_harene_pools" },
  destroys_dropped_items = true,
  effect = "brash-ice-2",
  effect_color = {60,55,97},
  effect_color_secondary = { 70, 40, 120 },
  map_color = { 0.4, 0.1, 0.65},
}}
-- harene_tile.collision_mask = { layers = { harene = true, ground_tile = true } }
harene_tile.fluid = "energetic-residue"
-- local harene_tile_deep = util.merge{harene_tile, {
--     name = "rabbasca-harene-deep",
--     autoplace = { probability_expression = "rabbasca_harene_pools_deep" },
--     effect = "brash-ice-2",
--     effect_color = {33,22,61},
--     effect_color_secondary = { 90, 77, 100 }
-- }}
-- harene_tile_deep.collision_mask = { layers = { harene = true, water_tile = true } }
-- harene_tile_deep.fluid = "harenic-sludge"

data:extend{
{
  type = "collision-layer",
  name = "harene",
},
util.merge{ table.deepcopy(data.raw["tile"]["ice-smooth"]), {
    name = "rabbasca-ice",
    collision_mask = tile_collision_masks.ground(),
    autoplace = { probability_expression = "rabbasca_icy" },
    map_color = {0.2, 0.4, 0.7}
}},

util.merge{ table.deepcopy(data.raw["tile"]["volcanic-ash-flats"]), {
    name = "rabbasca-rough",
    collision_mask = tile_collision_masks.ground(),
    autoplace = { probability_expression = "rabbasca_rocky + rabbasca_rocky_variance" },
    map_color = {0.07, 0.06, 0.1}
}},
util.merge{ table.deepcopy(data.raw["tile"]["volcanic-pumice-stones"]), {
    name = "rabbasca-rough-2",
    collision_mask = tile_collision_masks.ground(),
    autoplace = { probability_expression = "rabbasca_rocky" },
    map_color = {0.07, 0.061, 0.1}
}},
util.merge{ table.deepcopy(data.raw["tile"]["midland-yellow-crust-2"]), {
    name = "rabbasca-fertile",
    autoplace = { probability_expression = "rabbasca_fertile" },
    map_color = {0.61, 0.282, 0.1}
}},
util.merge { 
    table.deepcopy(data.raw["tile"]["concrete"]),
    {
      name = "rabbasca-energetic-concrete",
      collision_mask = { layers = { harene = true } },
      -- material_background = { tint  = {60,55,97}, },
      minable = { result = "rabbasca-energetic-concrete" },
      variants = { material_background = { picture = "__planet-rabbasca__/graphics/icons/concrete.png", } },
    }
},
util.merge { 
    table.deepcopy(data.raw["tile"]["foundation"]),
    {
      name = "harene-infused-foundation",
      collision_mask = { layers = { harene = true } },
      effect_color = {60,55,97},
      minable = { result = "harene-infused-foundation" }
    }
},
util.merge { 
    table.deepcopy(data.raw["tile"]["space-platform-foundation"]),
    {
      name = "harene-infused-space-platform",
      collision_mask = { layers = { harene = true } },
      effect_color = {60,55,97},
      minable = { result = "harene-infused-space-platform" }
    }
},
harene_tile, harene_tile_deep
}