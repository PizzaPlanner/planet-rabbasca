local stabilizer = util.merge { data.raw["assembling-machine"]["assembling-machine-3"],
{
    name = "rabbasca-warp-stabilizer",
    icon = "__rabbasca-assets__/graphics/by-hurricane/custom-atom-forge-icon.png",
    icon_size = 64,
    crafting_speed = 1,
    collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    energy_usage = "4.75GW",
    module_slots = 20,
  }}
stabilizer.minable = nil
stabilizer.placeable_by = nil
stabilizer.allowed_effects = { "speed", "productivity", "quality" }
stabilizer.flags = { "placeable-player", "player-creation" }
stabilizer.energy_source.drain = "250MW"
stabilizer.next_upgrade = nil
stabilizer.deconstruction_alternative = nil
stabilizer.crafting_categories = { "rabbasca-warp-stabilizer" }
stabilizer.fluid_boxes = { 
  {
    volume = 1000,
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    production_type = "output",
    pipe_connections = 
    {
      {
        flow_direction = "output",
        position = {-2, 4.2},
        direction = defines.direction.south,
      },
      {
        flow_direction = "output",
        position = {0, 4.2},
        direction = defines.direction.south,
      },
      {
        flow_direction = "output",
        position = {2, 4.2},
        direction = defines.direction.south,
      },
    }
  },
  {
    volume = 500,
    production_type = "input",
    filter = "fusion-plasma",
    pipe_connections = 
    {
      {
        flow_direction = "input-output",
        position = {-4.2, 3},
        direction = defines.direction.west,
        connection_category = "fusion-plasma",
      },
      {
        flow_direction = "input-output",
        position = {4.2, 3},
        direction = defines.direction.east,
        connection_category = "fusion-plasma",
      },
      {
        flow_direction = "input-output",
        position = {-4.2, 0},
        direction = defines.direction.west,
        connection_category = "fusion-plasma",
      },
      {
        flow_direction = "input-output",
        position = {4.2, 0},
        direction = defines.direction.east,
        connection_category = "fusion-plasma",
      },
    }
  },
}
-- assembler.effect_receiver = { base_effect = {
--   ["productivity"] = 1, 
-- } }
local sprite_data = {   
  line_length = 10,
  width = 4000 / 10,
  height = 3840 / 8,
  frame_count = 80,
  scale = 0.8,
  shift = util.by_pixel(0, -20)
}

stabilizer.graphics_set = {
  frozen_patch = util.merge {{ filename = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-frozen.png" }, sprite_data },
  working_visualisations = {
    {
      fadeout = true, 
      animation = util.merge { sprite_data, 
      { filename = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-emission1.png", draw_as_glow = true, blend_mode = "additive", apply_runtime_tint = true }},
      apply_recipe_tint = "primary"
    },
    {
      fadeout = true, 
      animation = util.merge { sprite_data, 
      { filename = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-emission2.png", draw_as_glow = true, blend_mode = "additive" }},
    },
  },
  shadow = { line_length = 1, frame_count = 80, width = 900, height = 500, draw_as_shadow = true, filename = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-shadow.png", scale = 0.8, },
  idle_animation = { layers = { util.merge {{ filename = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-animation.png" }, sprite_data } } },
  always_draw_idle_animation = true
}

local lab = util.merge {
  data.raw["lab"]["lab"],
  {
    name = "rabbasca-warp-tech-analyzer",
    energy_usage = "10MW",
    burns_fluid = true,
    scale_fluid_usage = true
  }
}
lab.inputs = { "rabbasca-warp-core", "rabbasca-warp-matrix" }
lab.minable.result = "rabbasca-warp-tech-analyzer"
lab.energy_source = {
  type = "fluid",
  fluid_box = {
    volume = 100,
    filter = "harene",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    production_type = "input",
    pipe_connections = 
    {
        {
          flow_direction = "input-output",
          position = {0, -1.2},
          direction = defines.direction.north,
        },
        {
          flow_direction = "input-output",
          position = {0, 1.2},
          direction = defines.direction.south,
        },
    },
  },
}

data:extend {
  stabilizer,
  lab,
  util.merge {
    data.raw["electric-energy-interface"]["rabbasca-energy-source"],
    {
      name = "rabbasca-energy-source-big",
      energy_production = Rabbasca.surface_megawatts() * 5 .. "MW",
      energy_source = { 
        buffer_capacity = (Rabbasca.surface_megawatts() * 5 / 6) .. "MJ", 
        output_flow_limit = Rabbasca.surface_megawatts() * 5 .. "MW",
      },
    },
  },
  util.merge {
    data.raw["electric-energy-interface"]["rabbasca-energy-source"],
    {
      name = "rabbasca-energy-consumer-big",
      icon = data.raw["segmented-unit"]["big-demolisher"].icon,
      type = "beacon",
      flags = data.raw["electric-energy-interface"]["rabbasca-energy-source"].flags,
      energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
      },
      energy_usage = Rabbasca.surface_megawatts() * 50 .. "MW",
      supply_area_distance = 0,
      distribution_effectivity = 0,
      module_slots = 0,
    }
  }
}