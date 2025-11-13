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
  pipe_covers = assembler.fluid_boxes.pipe_covers,
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
local sprite_data = {   
  line_length = 10,
  width = 320,
  height = 320,
  frame_count = 100,
  scale = 0.5,
}

assembler.graphics_set = {
  frozen_patch = util.merge {{ filename = "__planet-rabbasca__/graphics/gravity-assembler/gravity-assembler-frozen.png" }, sprite_data },
  working_visualisations = {
    {
      fadeout = true, 
      animation = util.merge { sprite_data, 
      { filename = "__planet-rabbasca__/graphics/gravity-assembler/gravity-assembler-emission1.png", draw_as_glow = true, blend_mode = "additive" }},
    },
    {
      fadeout = true, 
      animation = util.merge { sprite_data, 
      { filename = "__planet-rabbasca__/graphics/gravity-assembler/gravity-assembler-emission2.png", draw_as_glow = true, blend_mode = "additive" }},
    },
    {
      fadeout = true, 
      animation = util.merge { sprite_data, 
      { filename = "__planet-rabbasca__/graphics/gravity-assembler/gravity-assembler-emission3.png", draw_as_glow = true, blend_mode = "additive" }},
    },
  },
  idle_animation = { layers = { util.merge {{ filename = "__planet-rabbasca__/graphics/gravity-assembler/gravity-assembler-animation.png" }, sprite_data } } },
  always_draw_idle_animation = true
}

data:extend {
  assembler,
  {
    type = "container",
    name = "rabbasca-remote-builder",
    icon = "__planet-rabbasca__/graphics/research-center/research-center-icon.png",
    flags = { "not-rotatable", "placeable-player", "player-creation" },
    minable = { result = "rabbasca-remote-builder", mining_time = 4 },
    placeable_by = { item = "rabbasca-remote-builder", count = 1 },
    inventory_type = "with_filters_and_bar",
    inventory_size = 30,
    surface_conditions = {
      { property = "harenic-energy-signatures", min = 20 }
    },
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    graphics_set = {
    }
  },
  {
    type = "assembling-machine",
    name = "rabbasca-remote-receiver",
    icon = "__planet-rabbasca__/graphics/conduit/conduit-icon.png",
    fixed_recipe = "rabbasca-remote-call",
    flags = { "not-rotatable", "placeable-player", "player-creation" },
    crafting_categories = { "rabbasca-remote" },
    minable = { result = "rabbasca-remote-receiver", mining_time = 1 },
    placeable_by = { item = "rabbasca-remote-receiver", count = 1 },
    surface_conditions = {
      { property = "gravity", min = 0.01 }
    },
    energy_usage = "1MW",
    crafting_speed = 1,
    energy_source = { type = "void" },
    collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selection_box = {{-1, -1}, {1, 1}},
    tile_buildability_rules = { rutil.restrict_to_harene_pool({{-0.8, -0.8}, {0.8, 0.8}}) },
    radius_visualisation_specification = {
      sprite = data.raw["utility-sprites"]["default"].construction_radius_visualization,
      distance = 75,
    },
    graphics_set = {
      working_visualisations = {{
        animation = {
              filename = "__planet-rabbasca__/graphics/conduit/conduit-emission.png",
              frame_count = 60,
              line_length = 10,
              width = 200,
              height = 290,
              draw_as_glow = true,
              blend_mode = "additive-soft",
              scale = 1.0/3,
              shift = {0, -0.5},
              apply_runtime_tint = true
        },
        apply_recipe_tint = "primary"
      }},
      default_recipe_tint = { primary = {0.5, 0.75, 1} },
      idle_animation = {
        layers = {
          {
            filename = "__planet-rabbasca__/graphics/conduit/conduit-animation.png",
            frame_count = 60,
            line_length = 10,
            width = 200,
            height = 290,
            scale = 1.0/3,
            flags = {"no-scale"},
            shift = {0, -0.5},
          },
          {
              filename = "__planet-rabbasca__/graphics/conduit/conduit-hr-shadow.png",
              repeat_count = 60,
              width = 600,
              height = 400,
              scale = 1.0/3,
              draw_as_shadow = true,
              shift = {0, -0.5},
          },
        }
      },
      always_draw_idle_animation = true
    },
  },
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

