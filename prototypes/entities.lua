local color = {r=0.65, g=0.31, b=0.92}

function restrict_to_harene_pool(bbox)
  return {

  }
end

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

local tower = util.merge{ table.deepcopy(data.raw["fusion-generator"]["fusion-generator"]),
{  
  name = "small-harene-collider",
  icon  = "__space-age__/graphics/icons/heating-tower.png",
  minable = { result = "small-harene-collider" },
  max_fluid_usage = 0.01,
  collision_box = {{-1.25, -1.25}, {1.25, 1.25}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
}}
tower.graphics_set = require ("__planet-rabbasca__.prototypes.fusion-system-pictures").generator_graphics_set
tower.input_fluid_box = {
    volume = 10,
    filter = "harene",
    minimum_temperature = 15.0,
    production_type = "input",
    pipe_connections = 
    {
        {
          flow_direction = "input",
          position = {0, 1},
          direction = defines.direction.south,
          connection_category = {"harene"}
        }
    },
}
tower.output_fluid_box = {
    volume = 10,
    filter = "beta-carotene",
    minimum_temperature = 52.0,
    production_type = "output",
    pipe_connections = 
    {
        {
          flow_direction = "output",
          position = {0, -1},
          direction = defines.direction.north,
        }
    },
}
local tower_item = {
    type = "item",
    icon = "__space-age__/graphics/icons/heating-tower.png",
    name = "small-harene-collider",
    stack_size = 10,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    place_result = "small-harene-collider",
}

local pump =  table.deepcopy(data.raw["mining-drill"]["pumpjack"])
pump.minable.result = "harene-extractor"
pump.output_fluid_box = {
    volume = 10,
    filter = "harene",
    minimum_temperature = 15.0,
    production_type = "output",
    pipe_connections = 
    {
        {
          flow_direction = "output",
          position = {0, 1},
          direction = defines.direction.south,
          connection_category = {"harene"}
        },
        {
          flow_direction = "output",
          position = {0, -1},
          direction = defines.direction.north,
          connection_category = {"harene"}
        },
        {
          flow_direction = "output",
          position = {1, 0},
          direction = defines.direction.east,
          connection_category = {"harene"}
        },
        {
          flow_direction = "output",
          position = {-1, 0},
          direction = defines.direction.west,
          connection_category = {"harene"}
        },
    },
}
pump = util.merge{pump, {
    name = "harene-extractor",
    energy_source = { type = "void" },
    energy_usage = "1MW",
    resource_categories = {"harene"},
    module_slots = 8
}}
local pump_item = {
    type = "item",
    icon = "__space-age__/graphics/icons/heating-tower.png",
    name = "harene-extractor",
    stack_size = 5,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    place_result = "harene-extractor",
}

local assembler = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"])
assembler.minable.result = "rabbasca-harean-assembler"
assembler.fluid_boxes = { }
assembler = util.merge{assembler, {
    name = "rabbasca-harean-assembler",
    energy_source = harene_energy_source(1),
    energy_usage = "17MW",
    module_slots = 8,
    crafting_speed = 10.0,
    -- quality_affects_energy_usage = true,
}}

local assembler_item = {
    type = "item",
    icon = "__space-age__/graphics/icons/lithium-brine.png",
    name = "rabbasca-harean-assembler",
    stack_size = 5,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    place_result = "rabbasca-harean-assembler",
}

local synthesizer = util.merge{ table.deepcopy(data.raw["assembling-machine"]["electromagnetic-plant"]),
{
  name = "harene-synthesizer",
  energy_usage = "10.5GW",
  module_slots = 0,
  crafting_speed = 1.0
}
}
synthesizer.crafting_categories = { "harene-synthesis" }
synthesizer.fluid_boxes = {
  {
    volume = 20,
    filter = "harene",
    production_type = "output",
    pipe_connections = 
    {
        {
          flow_direction = "output",
          position = {1.699, 1},
          direction = defines.direction.east,
          connection_category = {"harene"}
        },
    },
  },
  {
    volume = 500,
    filter = "beta-carotene",
    production_type = "input",
    pipe_connections = 
    {
        {
          flow_direction = "input",
          position = {-1.677, -1},
          direction = defines.direction.west,
        },
    },
  }
}

local synthesizer_item = {
    type = "item",
    icon = "__space-age__/graphics/icons/lithium-brine.png",
    name = "harene-synthesizer",
    stack_size = 5,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    place_result = "harene-synthesizer",
}

local transmuter = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"])
transmuter.minable.result = "harene-transmuter"
transmuter.fluid_boxes = { }
transmuter.crafting_categories = {"harene-transmutation"}
transmuter = util.merge{transmuter, {
    name = "harene-transmuter",
    energy_source = harene_energy_source(5),
    energy_usage = "100MW",
    module_slots = 2,
    crafting_speed = 1.0,
    -- quality_affects_energy_usage = true,
}}

local transmuter_item = {
    type = "item",
    icon = "__space-age__/graphics/icons/lithium-brine.png",
    name = "harene-transmuter",
    stack_size = 5,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    place_result = "harene-transmuter",
}

local surface_property = {
    type = "surface-property",
    name = "mooniness",
    default_value = 1.0,
    hidden = true
}

local thruster_graphics = table.deepcopy(data.raw["thruster"]["thruster"]["graphics_set"])
thruster_graphics.working_visualisations[5] = {
  fadeout = true,
  animation = util.sprite_load("__space-age__/graphics/entity/thruster/thruster-light",
  {
    animation_speed = 0.5,
    frame_count = 64,
    blend_mode = "additive",
    draw_as_glow = true,
    scale = 0.5,
    shift = {0,3},
    tint = color
  }),
}

local harene_pipe = util.merge{ table.deepcopy(data.raw["pipe"]["pipe"]),
  name = "harene-pipe",
  minable = { result = "harene-pipe" },
}
harene_pipe.fluid_box = table.deepcopy(harene_pipe.fluid_box)
harene_pipe.fluid_box.volume = 1
harene_pipe.fluid_box.pipe_connections = {
  { direction = defines.direction.north, position = {0, 0}, connection_category = {"harene"} },
  { direction = defines.direction.east, position = {0, 0}, connection_category = {"harene"} },
  { direction = defines.direction.south, position = {0, 0}, connection_category = {"harene"} },
  { direction = defines.direction.west, position = {0, 0}, connection_category = {"harene"} }
}
-- harene_pipe.collision_box = nil
-- local harene_pipe_item = {
--     type = "item",
--     icon = "__space-age__/graphics/icons/lithium-brine.png",
--     name = "harene-pipe",
--     stack_size = 5,
--     subgroup = "transport",
--     order = "b[personal-transport]-c[startertron]",
--     place_result = "harene-pipe",
-- }

data:extend{
  tower_item, tower, 
  assembler, assembler_item, 
  pump_item, pump, 
  surface_property, 
  transmuter, transmuter_item, 
  harene_pipe, -- harene_pipe_item,
  synthesizer, synthesizer_item
}

local moon_chest = util.merge{
  table.deepcopy(data.raw["linked-container"]["linked-chest"]),
  {
    name = "moonfolk-chest",
    minable = { result = "moonfolk-chest" },
    hidden = false,
    gui_mode = "none",
    link_id = 12141413,
  }
}
moon_chest.tile_buildability_rules = {
{ 
  area = {{-0.6, -0.6}, {0.6, 0.6}}, 
  required_tiles = { layers = { harene = true } },
  colliding_tiles = { layers = { is_object = true } }, -- must not be empty??
  remove_on_collision = true 
}}

data:extend {
  moon_chest,
  {
    type = "item",
    icon = "__base__/graphics/icons/linked-chest-icon.png",
    name = "moonfolk-chest",
    stack_size = 5,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    place_result = "moonfolk-chest",
  },
  util.merge {
    table.deepcopy(data.raw["thruster"]["thruster"]),
    {
      name = "harene-thruster",
      minable = { result = "harene-thruster" },
      min_performance = {fluid_volume = 0.1, fluid_usage = 0.2, effectivity = 0.3},
      max_performance = {fluid_volume = 0.8, fluid_usage = 1, effectivity = 1},
      fuel_fluid_box =
      {
        filter = "thruster-fuel",
        production_type = "input",
        draw_only_when_connected = true,
        volume = 1000,
        pipe_connections =
        {
          {flow_direction = "input-output", direction = defines.direction.west, position = {-1.5,  0}, enable_working_visualisations = { "pipe-4" }, connection_category = {"harene"} },
          {flow_direction = "input-output", direction = defines.direction.east, position = { 1.5,  0}, enable_working_visualisations = { "pipe-2" }, connection_category = {"harene"} },
        }
      },
      oxidizer_fluid_box =
      {
        filter = "harene",
        production_type = "input",
        -- pipe_covers = pipecoverspictures(),
        draw_only_when_connected = true,
        volume = 50,
        pipe_connections =
        {
          {flow_direction = "input", direction = defines.direction.north, position = { -1.5, -2}, enable_working_visualisations = { "pipe-1" }, connection_category = {"harene"}},
          {flow_direction = "input", direction = defines.direction.north, position = { 1.5, -2}, enable_working_visualisations = { "pipe-3" }, connection_category = {"harene"}},
        }
      },
      graphics_set = thruster_graphics
    },
  },
  {
    type = "item",
    icon = "__space-age__/graphics/icons/thruster.png",
    name = "harene-thruster",
    stack_size = 5,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    place_result = "harene-thruster",
  },
}
local moonstone_inserter = util.merge {
  table.deepcopy(data.raw["inserter"]["fast-inserter"]),
  { 
      minable = { result = "carotene-inserter" },
      name = "carotene-inserter",
      bulk = true,
      uses_inserter_stack_size_bonus = true,
      wait_for_full_hand = false,
      stack_size_bonus = 17,
      grab_less_to_match_belt_stack = true,
      energy_source = { type = "void" }
  }
}
moonstone_inserter.
data:extend {
  moonstone_inserter,
  {
    type = "item",
    icon = "__space-age__/graphics/icons/stack-inserter.png",
    name = "carotene-inserter",
    stack_size = 50,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    place_result = "carotene-inserter",
  },
  util.merge {
  table.deepcopy(data.raw["simple-entity"]["vulcanus-chimney"]),
  minable = {0},
  { 
    name = "carotenoid",
    minable = {
      mining_particle = "copper-ore-particle",
      mining_time = 0.4,
      results = {
        {type = "item", name = "rabbasca-carotene-powder", amount_min = 40, amount_max = 55},
      }
    },
    autoplace = {
      probability_expression = "rabbasca_carrot_noise",
      tile_restriction = { "rabbasca-fertile" },
    },
    map_color = {0.73, 0.55, 0.1}
  }},
  util.merge {
    table.deepcopy(data.raw["simple-entity"]["big-volcanic-rock"]),
    minable = {0},
    {
      name = "rabbasca-moonstone-rock",
      minable = { 
        mining_particle = "stone-particle",
        mining_time = 1.5,
        results = {
          {type = "item", name = "rabbasca-moonstone", amount_min = 3, amount_max = 3},
        }
      },
      autoplace = {
        probability_expression = "rabbasca_rocks",
        tile_restriction = { "rabbasca-rough", "rabbasca-rough-2" },
      },
      map_color = {0.09, 0.12, 0.17}
  }},
}