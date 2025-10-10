local rutil = require("__planet-rabbasca__.util")
local fff339 = require("__FFF339BeaconGraphics__.prototypes.sprites")
local color = {r=0.65, g=0.31, b=0.92}

function harene_energy_source (volume)
return { 
      type = "fluid", 
      burns_fluid = true,
      scale_fluid_usage = true,
      -- fluid_usage_per_tick = ??
      fluid_box = {
          volume = volume,
          filter = "harene",
          production_type = "input",
          pipe_connections = 
          {
              {
                flow_direction = "input-output",
                position = {0, 1},
                direction = defines.direction.south,
                connection_category = {"harene"}
              }
          },
        } 
    }
end

local assembler = util.merge { data.raw["assembling-machine"]["assembling-machine-3"],
{
    name = "machining-assembler",
    icon = data.raw["item"]["machining-assembler"].icon,
    minable = { result = "machining-assembler" },
    crafting_speed = 1,
    perceived_performance = 0.5,
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    energy_usage = "9MW",
    module_slots = 6,
}}

assembler.crafting_categories = { "complex-machinery", "install-ears-core" }
assembler.fluid_boxes = { 
{
  volume = 1000,
    production_type = "input",
    pipe_connections = 
    {
        {
          flow_direction = "input-output",
          position = {0, -2.2},
          direction = defines.direction.north,
        },
        {
          flow_direction = "input-output",
          position = {0, 2.2},
          direction = defines.direction.south,
        },
    },
},
}
assembler.effect_receiver = { base_effect = {
  ["productivity"] = 1, 
} }
-- assembler.surface_conditions = {
--   { property = "pressure", max = 0.1 }
-- }
assembler.graphics_set = {
  frozen_patch = util.sprite_load("__planet-rabbasca__/graphics/gravity-assembler/gravity-assembler-frozen", { scale = 0.5, frame_count = 100 }),
  animation =
    {
      layers =
      {
        util.merge{
          util.sprite_load("__planet-rabbasca__/graphics/gravity-assembler/gravity-assembler-animation", { scale = 0.5, frame_count = 100 }),
          frame_count = 1
        }
      }
    },
    working_visualisations =
    {
      util.sprite_load("__planet-rabbasca__/graphics/gravity-assembler/gravity-assembler-animation", { scale = 0.5, frame_count = 100 }),
      util.sprite_load("__planet-rabbasca__/graphics/gravity-assembler/gravity-assembler-color", { scale = 0.5, frame_count = 100 }),
      util.sprite_load("__planet-rabbasca__/graphics/gravity-assembler/gravity-assembler-emission", { scale = 0.5, frame_count = 100, draw_as_glow = true, blend_mode = "additive" }),
  },
  idle_animation = util.merge{
    util.sprite_load("__planet-rabbasca__/graphics/gravity-assembler/gravity-assembler-animation", { scale = 0.5, frame_count = 100 }),
    frame_count = 1
  }
}

local harene_platform = util.merge{ data.raw["space-platform-hub"]["space-platform-hub"],
  {
    name = "harene-space-platform-hub",
    inventory_size = 32,
    surface_conditions = {
      {
        property = "harenic-energy-signatures",
        min = 50,
      }
    }
  }
}

data:extend {
  assembler,
  harene_platform,
  {
    type = "roboport",
    name = "rabbasca-orbital-construction-roboport",
    energy_source = { type = "void" },
    energy_usage = "0kW",
    charging_energy = "0kW",
    recharge_minimum = "0kJ",
    robot_slots_count = 0,
    material_slots_count = 0,
    logistics_radius = 0,
    construction_radius = 64,
    request_to_open_door_timeout = 0,
    charge_approach_distance = 0,
    spawn_and_station_height = 0,
  },
  {
    type = "container",
    name = "rabbasca-remote-builder",
    minable = { result = "rabbasca-remote-builder", mining_time = 4 },
    placeable_by = { item = "rabbasca-remote-builder", count = 1 },
    inventory_type = "with_filters_and_bar",
    inventory_size = 30,
    surface_conditions = {
      { property = "harenic-energy-signatures", min = 50 }
    },
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}}
  },
  {
    type = "simple-entity-with-owner",
    name = "rabbasca-remote-receiver",
    minable = { result = "rabbasca-remote-receiver", mining_time = 1 },
    placeable_by = { item = "rabbasca-remote-receiver", count = 1 },
    surface_conditions = {
      { property = "gravity", min = 0.01 }
    },
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    tile_buildability_rules = { rutil.restrict_to_harene_pool({{-0.4, -0.4}, {0.4, 0.4}}) },
    radius_visualisation_specification = {
      sprite = data.raw["utility-sprites"]["default"].construction_radius_visualization,
      distance = 75,
    } 
  },
  -- {
  --   type = "proxy-container",
  --   name = "orbital-construction-deployer",
  --   minable = { result = "orbital-construction-deployer", mining_time = 1 },
  --   surface_conditions = { 
  --     { property = "gravity", max = 0 }
  --   }
  -- },
  {
    type = "electric-energy-interface",
    name = "rabbasca-energy-source",
    icon = "__muluna-graphics__/graphics/moon-icon-mipped.png",
    energy_production = "50MW",
    energy_source = { type = "electric", usage_priority = "primary-output", buffer_capacity = "10MJ" },
    gui_mode = "none",
    flags = { "placeable-neutral", "placeable-off-grid", "not-on-map", "not-deconstructable", "not-selectable-in-game" },
    autoplace = {
      probability_expression = "distance == 0",
    },
    collision_mask = { layers = { } },
    map_generator_bounding_box = {{-20, -20}, {20,  20}}
  },
  {
    type = "electric-energy-interface",
    name = "harene-platform-energy-source",
    icon =  data.raw["item"]["harene-ears-core"].icon,
    icons = data.raw["item"]["harene-ears-core"].icons,
    energy_production = "10MW",
    energy_source = { type = "electric", usage_priority = "primary-output", buffer_capacity = "0.5MJ" },
    gui_mode = "none",
    flags = { "placeable-neutral", "placeable-off-grid", "not-on-map", "not-deconstructable", "not-selectable-in-game" },
    collision_mask = { layers = { } },
    map_generator_bounding_box = {{-20, -20}, {20,  20}}
  }
}

data:extend {
  util.merge {
  table.deepcopy(data.raw["simple-entity"]["vulcanus-chimney"]),
  { minable = {0} },
  { 
    name = "carotenoid",
    minable = {
      mining_time = 0.4,
    },
    autoplace = {
      probability_expression = "rabbasca_carrot_noise",
      tile_restriction = { "rabbasca-fertile" },
    },
    map_color = {0.73, 0.55, 0.1},
    map_generator_bounding_box = {{-3.5, -3.5}, {3.5, 3.5}},
  }},
  util.merge {
    table.deepcopy(data.raw["simple-entity"]["big-volcanic-rock"]),
    {
      name = "moonstone-rock",
      minable = { 
        mining_time = 1.5,
      },
      autoplace = {
        probability_expression = "rabbasca_rocks",
        tile_restriction = { "rabbasca-rough", "rabbasca-rough-2" },
      },
      map_color = {0.09, 0.12, 0.17}
  }},
  util.merge {
    table.deepcopy(data.raw["simple-entity"]["fulgoran-ruin-small"]),
    {
      name = "harene-ears-core-capsule",
      minable = { 
        mining_time = 3,
      }
  }},
  util.merge {
    table.deepcopy(data.raw["simple-entity"]["fulgoran-ruin-small"]),
    {
      name = "harene-copy-core-capsule",
      minable = { 
        mining_time = 3,
      }
  }},
  util.merge {
    table.deepcopy(data.raw["capsule"]["raw-fish"]),
    {
      name = "rabbasca-turbofish",
      spoil_ticks = 3 * minute,
      spoil_result = "protein-powder",
    },
  },
  util.merge{
    table.deepcopy(data.raw["fish"]["fish"]),
    {
      name = "rabbasca-turbofish",
      minable = { result = "rabbasca-turbofish" },
      autoplace = { probability_expression = "rabbasca_harene_pools - 0.5" },
      -- collision_mask = { layers = { ground_tile = true } }
      map_generator_bounding_box = {{-1.5, -1.5}, {1.5, 1.5}},
    },
  },
  util.merge{
    table.deepcopy(data.raw["sticker"]["jellynut-speed-sticker"]),
    {
      name = "turbofish-speed-sticker",
      duration_in_ticks = 10 * second,
      target_movement_modifier = 4
    }
  },
}

local unpacker = util.merge{
  table.deepcopy(data.raw["furnace"]["electric-furnace"]),
  {
    name = "rabbasca-copy-unpacker",
    result_inventory_size = 2,
    energy_usage = "55kW",
    vector_to_place_result = {0, 0.7},
    minable = { result = "rabbasca-copy-unpacker" },
    show_recipe_icon = false,
    
  }
}
unpacker.collision_box = {{-0.4, -0.4}, {0.4, 0.4}}
unpacker.selection_box = {{-0.5, -0.5}, {0.5, 0.5}}
unpacker.crafting_categories = { "rabbasca-matter-printer-unpack" }
unpacker.graphics_set =
{
  animation =
  {
    layers =
    {
      {
        filename = "__Krastorio2Assets__/buildings/loader/kr-loader.png",
        priority = "high",
        width = 424 / 4,
        height = 170 / 2,
        frame_count = 8,
        line_length = 4,
        scale = 0.4,
        shift = { 0.08, 0.04 }
      }
    }
  },
}
data:extend{ unpacker,
{
    type = "item",
    icon = "__base__/graphics/icons/distractor-capsule.png",
    name = "rabbasca-copy-unpacker",
    stack_size = 50,
    place_result = "rabbasca-copy-unpacker",
    subgroup = "smelting-machine",
    order = "r[copy-unpacker]",
}
}

local fish_action = table.deepcopy(require("__space-age__.prototypes.item-effects").jellynut_speed)
fish_action.attack_parameters.ammo_type.action.action_delivery.target_effects[1].sticker = "turbofish-speed-sticker"

data.raw["electric-energy-interface"]["rabbasca-energy-source"].collision_box = nil
data.raw["capsule"]["rabbasca-turbofish"].capsule_action = fish_action
data.raw["simple-entity"]["moonstone-rock"].minable.results = {
  {type = "item", name = "haronite", amount_min = 12, amount_max = 18}, 
  {type = "item", name = "calcite", amount_min = 4, amount_max = 7 }
}
data.raw["simple-entity"]["carotenoid"].minable.results = {{type = "item", name = "rabbasca-carotene-powder", amount_min = 40, amount_max = 55}}
data.raw["simple-entity"]["harene-ears-core-capsule"].minable.results = {
  {type = "item", name = "harene-ears-core", amount_min = 1, amount_max  = 1 },
  {type = "item", name = "haronite-brick", amount_min = 10, amount_max  = 15 },
}
data.raw["simple-entity"]["harene-ears-core-capsule"].icons = {
  { icon = data.raw["simple-entity"]["harene-ears-core-capsule"].icon, scale = 0.6, shift = { -4, -4 } },
  { icon = data.raw["item"]["harene-ears-core"].icon, scale = 0.4, shift = { 8, 8 } }
}
data.raw["simple-entity"]["harene-copy-core-capsule"].minable.results = {
  {type = "item", name = "harene-copy-core-recharging", amount_min = 8, amount_max  = 8 },
  {type = "item", name = "haronite-brick", amount_min = 10, amount_max  = 15 },
}
data.raw["simple-entity"]["harene-copy-core-capsule"].icons = {
  { icon = data.raw["simple-entity"]["harene-copy-core-capsule"].icon, scale = 0.6, shift = { -4, -4 } },
  { icon = "__space-age__/graphics/icons/jelly.png", scale = 0.4, shift = { 8, 8 } }
}
data.raw["simple-entity"]["harene-copy-core-capsule"].icon = nil

local beacon_anims = { }
for _, anim in pairs(fff339.animation_list) do
  table.insert(beacon_anims, table.deepcopy(anim.animation))
end
data.raw["simple-entity-with-owner"]["rabbasca-remote-receiver"].animations = beacon_anims

