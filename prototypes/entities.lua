local color = {r=0.65, g=0.31, b=0.92}

function restrict_to_harene_pool(bbox)
  return {
{ 
  area = bbox, 
  required_tiles = { layers = { harene = true } },
  colliding_tiles = { layers = { is_object = true } }, -- must not be empty??
  remove_on_collision = true 
}}
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
  name = "small-harenide-collider",
  icon  = "__space-age__/graphics/icons/heating-tower.png",
  minable = { result = "small-harenide-collider" },
  max_fluid_usage = 0.01,
  collision_box = {{-1.25, -1.25}, {1.25, 1.25}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  -- loot = {{item = "harene-cubic-core"}},
  map_generator_bounding_box = {{-10, -10}, {10, 10}},
  autoplace = {
    probability_expression = "(rabbasca_camps > 0.85) * 3",
    tile_restriction = { "harene-infused-foundation" },
    force = "enemy",
  }
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
    name = "small-harenide-collider",
    stack_size = 5,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    place_result = "small-harenide-collider",
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
    module_slots = 8,
    -- loot = {{item = "harene-cubic-core"}}
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

local assembler = table.deepcopy(data.raw["assembling-machine"]["chemical-plant"])
assembler.minable.result = "harenic-chemical-plant"
-- assembler.fluid_boxes = { }
assembler.tile_buildability_rules = restrict_to_harene_pool({{-0.6, -0.6}, { 0.6, 0.6}})
assembler.crafting_categories = {"organic", "organic-or-chemistry"}
assembler = util.merge{assembler, {
    name = "harenic-chemical-plant",
    energy_source = { type = "void" },
    energy_usage = "17MW",
    module_slots = 8,
    crafting_speed = 3.0,
    loot = {{item = "harene-ears-core"}}
    -- quality_affects_energy_usage = true,
}}

local assembler_item = {
    type = "item",
    icon = "__space-age__/graphics/icons/biochamber.png",
    name = "harenic-chemical-plant",
    stack_size = 5,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    place_result = "harenic-chemical-plant",
}

local synthesizer = util.merge{ table.deepcopy(data.raw["assembling-machine"]["electromagnetic-plant"]),
{
  name = "harene-synthesizer",
  energy_usage = "10.5GW",
  module_slots = 0,
  crafting_speed = 1.0,
  loot = {{item = "harene-ears-core"}}
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
assembler.tile_buildability_rules = restrict_to_harene_pool({{-0.6, -0.6}, { 0.6, 0.6}})
transmuter = util.merge{transmuter, {
    name = "harene-transmuter",
    energy_source = { type = "void" },
    energy_usage = "100MW",
    module_slots = 2,
    crafting_speed = 1.0,
    loot = {{item = "harene-ears-core"}}
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
{ tile_buildability_rules = {0} },
{
  name = "moonstone-pipe",
  minable = { result = "moonstone-pipe" },
  tile_buildability_rules = restrict_to_harene_pool({{-0.6, -0.6}, { 0.6, 0.6}}),
  fluid_box = { volume = 1 },
  filter = "harene"
}
}
harene_pipe.fluid_box.pipe_connections[1].connection_category = {"harene"}
harene_pipe.fluid_box.pipe_connections[2].connection_category = {"harene"}
harene_pipe.fluid_box.pipe_connections[3].connection_category = {"harene"}
harene_pipe.fluid_box.pipe_connections[4].connection_category = {"harene"}
-- harene_pipe.collision_box = nil
local harene_pipe_item = {
    type = "item",
    icon = "__space-age__/graphics/icons/lithium-brine.png",
    name = "moonstone-pipe",
    stack_size = 50,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    place_result = "moonstone-pipe",
}

local moonstone_turret = util.merge{ table.deepcopy(data.raw["electric-turret"]["tesla-turret"]),
{ tile_buildability_rules = {0} },
{
  name = "moonstone-turret",
  minable = { result = "moonstone-turret" },
  energy_source = { type = "void" },
  tile_buildability_rules = restrict_to_harene_pool({{-1.6, -1.6}, {1.6, 1.6}}),
  loot = {{item = "harene-ears-core"}},
  map_generator_bounding_box = {{-10.5, -10.5}, {10.5, 10.5}},
  autoplace = {
    probability_expression = "(pow(rabbasca_camps * (1 - rabbasca_camps) * 4.2, 2) + 0.1) * rabbasca_starting_mask",
    tile_restriction = { "rabbasca-harene", "harene-infused-foundation" },
    force = "enemy",
  }
}}

data:extend{
  tower_item, tower, 
  assembler, assembler_item, 
  pump_item, pump, 
  transmuter, transmuter_item, 
  harene_pipe, harene_pipe_item,
  synthesizer, synthesizer_item,
  moonstone_turret, 
}

local moon_chest = util.merge{
  table.deepcopy(data.raw["linked-container"]["linked-chest"]),
  {
    name = "moonstone-chest",
    minable = { result = "moonstone-chest" },
    hidden = false,
    gui_mode = "none",
    link_id = 12141413,
    inventory_type = "with_filters_and_bar",
    inventory_size = 30,
  }
}
moon_chest.tile_buildability_rules = restrict_to_harene_pool({{-0.6, -0.6}, { 0.6, 0.6}})

data:extend {
  moon_chest,
  {
    type = "item",
    icon = "__base__/graphics/icons/linked-chest-icon.png",
    name = "moonstone-chest",
    stack_size = 5,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    place_result = "moonstone-chest",
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
moonstone_inserter.tile_buildability_rules = restrict_to_harene_pool({{-0.6, -0.6}, { 0.6, 0.6}})

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
      name = "rabbasca-moonstone-rock",
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
    table.deepcopy(data.raw["simple-entity"]["big-volcanic-rock"]),
    {
      name = "rabbasca-infused-moonstone-rock",
      minable = { 
        mining_time = 2.5,
      },
      autoplace = {
        probability_expression = "rabbasca_harene_pools - 0.3 + rabbasca_down - rabbasca_harene_pools_deep",
        tile_restriction = { "rabbasca-harene" },
      },
      map_generator_bounding_box = {{-12, -12}, {12, 12}},
      map_color = {0.31, 0.22, 0.61}
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
      collision_mask = { layers = { ground_tile = true } }
      -- map_generator_bounding_box = {{-3.5, -3.5}, {3.5, 3.5}},
    },
  },
  util.merge{
    table.deepcopy(data.raw["sticker"]["jellynut-speed-sticker"]),
    {
      name = "turbofish-speed-sticker",
      duration_in_ticks = 10 * second,
      target_movement_modifier = 4
    }
  }
}

local fish_action = table.deepcopy(require("__space-age__.prototypes.item-effects").jellynut_speed)
fish_action.attack_parameters.ammo_type.action.action_delivery.target_effects[1].sticker = "turbofish-speed-sticker"


data.raw["capsule"]["rabbasca-turbofish"].capsule_action = fish_action
data.raw["simple-entity"]["rabbasca-moonstone-rock"].minable.results = {{type = "item", name = "rabbasca-moonstone", amount_min = 9, amount_max = 12}}
data.raw["simple-entity"]["carotenoid"].minable.results = {{type = "item", name = "rabbasca-carotene-powder", amount_min = 40, amount_max = 55}}
data.raw["simple-entity"]["rabbasca-infused-moonstone-rock"].minable.results = {{type = "item", name = "harene-infused-moonstone", amount_min = 7, amount_max = 9}} 
for _, sprite in pairs(data.raw["simple-entity"]["rabbasca-infused-moonstone-rock"].pictures) do
  sprite.tint = {r=0.41, g=0.22, b=0.83}
  sprite.tint_as_overlay = true
end

