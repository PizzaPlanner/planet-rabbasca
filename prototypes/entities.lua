local rutil = require("__planet-rabbasca__.util")
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
    placeable_by = { item = "machining-assembler", count = 1 },
    crafting_speed = 1,
    perceived_performance = 0.5,
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    energy_usage = "9MW",
    module_slots = 6,
}}

assembler.deconstruction_alternative = nil
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

data:extend {
  assembler,
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
      { property = "harenic-energy-signatures", min = 20 }
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
    icon = "__planet-rabbasca__/graphics/icons/vulcanus-bw.png",
    energy_production = "50MW",

    energy_source = { 
      type = "electric", 
      usage_priority = "primary-output", 
      buffer_capacity = "8.333MJ", 
      output_flow_limit = "50MW",
      render_no_power_icon = false
    },
    gui_mode = "none",
    flags = { "placeable-neutral", "placeable-off-grid", "not-on-map", "not-deconstructable", "not-selectable-in-game" },
    autoplace = {
      probability_expression = "distance == 0",
    },
    collision_mask = { layers = { } },
    map_generator_bounding_box = {{-20, -20}, {20,  20}}
  },
}

data:extend {
  util.merge {
    table.deepcopy(data.raw["simple-entity"]["big-volcanic-rock"]),
    {
      name = "rabbasca-big-rock",
      minable = { 
        mining_time = 1.5,
      },
      autoplace = {
        probability_expression = "rabbasca_rocks(0.5)",
        tile_restriction = { "rabbasca-rough", "rabbasca-rough-2" },
      },
      map_color = {0.09, 0.12, 0.17},
  }},
  util.merge{
    table.deepcopy(data.raw["fish"]["fish"]),
    {
      name = "rabbasca-turbofish",
      icon = "__planet-rabbasca__/graphics/icons/turbofish.png",
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
      target_movement_modifier = 2.5
    }
  },
  util.merge{
    table.deepcopy(data.raw["sticker"]["bioflux-speed-regen-sticker"]),
    {
      name = "protein-shake-speed-sticker",
      duration_in_ticks = 60 * second,
      target_movement_modifier = 1.4,
      damage_interval = 20,
      damage_per_tick = { amount = -5 },
    }
  },
  util.merge {
    table.deepcopy(data.raw["rocket-silo-rocket"]["rocket-silo-rocket"]),
    {
      name = "rabbasca-rocket-silo-rocket",
      engine_starting_speed = 0.01,
      flying_acceleration = 0.05,
      flying_speed = 8.3333e-5,
      inventory_size = 40
    }
  }
}

data.raw["electric-energy-interface"]["rabbasca-energy-source"].collision_box = nil
data.raw["simple-entity"]["rabbasca-big-rock"].minable.results = {
  {type = "item", name = "stone", amount_min = 12, amount_max = 18}, 
  {type = "item", name = "iron-ore", amount_min = 9, amount_max = 15 }, 
  {type = "item", name = "copper-ore", amount_min = 7, amount_max = 12 }, 
  {type = "item", name = "carbon", amount_min = 2, amount_max = 5 }
}

