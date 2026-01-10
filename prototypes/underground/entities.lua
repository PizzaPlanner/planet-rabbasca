local rock = util.merge {
    table.deepcopy(data.raw["simple-entity"]["big-volcanic-rock"]),
    {
      name = "rabbasca-underground-rock",
      minable = { 
        mining_time = 3,
      },
      autoplace = {
        probability_expression = "rabbasca_underground_elevation > 0.85",
      },
      map_color = {0.09, 0.12, 0.17},
      collision_box = {{-3, -3}, {3, 3.5}},
      selection_box = {{-2.9, -2.9}, {2.9, 3.4}},
    }
}

rock.minable.results = {
  {type = "item", name = "stone", amount_min = 12, amount_max = 17 }, 
  {type = "item", name = "calcite", amount_min = 9, amount_max = 12 }
}
for _, pic in pairs(rock.pictures) do
  pic.scale = 5 * (pic.scale or 1)
end

local stabilizer = util.merge { data.raw["assembling-machine"]["assembling-machine-3"],
{
    name = "rabbasca-warp-stabilizer",
    icon = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-icon.png",
    icon_size = 640,
    crafting_speed = 1,
    collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    energy_usage = "12GW",
    module_slots = 20,
  }}
stabilizer.minable = nil
stabilizer.placeable_by = nil
stabilizer.allowed_effects = { "speed", "productivity", "quality" }
stabilizer.flags = { "placeable-neutral", "player-creation" }
stabilizer.energy_source.drain = "4GW"
stabilizer.next_upgrade = nil
stabilizer.deconstruction_alternative = nil
stabilizer.crafting_categories = { "rabbasca-warp-stabilizer" }
stabilizer.fluid_boxes = { 
  {
    volume = 1000,
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    production_type = "input",
    pipe_connections = 
    {
        {
          flow_direction = "input-output",
          position = {0, -4.2},
          direction = defines.direction.north,
        },
    }
  },
  {
    volume = 1000,
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    production_type = "output",
    pipe_connections = 
    {
      {
        flow_direction = "output",
        position = {0, 4.2},
        direction = defines.direction.south,
      },
    }
  },
  {
    volume = 1000,
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    production_type = "input",
    pipe_connections = 
    {
      {
        flow_direction = "input-output",
        position = {4.2, 0},
        direction = defines.direction.east,
      },
    }
  },
  {
    volume = 1000,
    pipe_picture = assembler3pipepictures(),
    pipe_covers = pipecoverspictures(),
    production_type = "input",
    pipe_connections = 
    {
      {
        flow_direction = "input-output",
        position = {-4.2, 0},
        direction = defines.direction.west,
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
  scale = 0.75,
}

stabilizer.graphics_set = {
  frozen_patch = util.merge {{ filename = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-frozen.png" }, sprite_data },
  working_visualisations = {
    {
      fadeout = true, 
      animation = util.merge { sprite_data, 
      { filename = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-emission1.png", draw_as_glow = true, blend_mode = "additive" }},
    },
    {
      fadeout = true, 
      animation = util.merge { sprite_data, 
      { filename = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-emission2.png", draw_as_glow = true, blend_mode = "additive" }},
    },
  },
  shadow = { line_length = 1, frame_count = 80, width = 900, height = 500, draw_as_shadow = true, filename = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-shadow.png", scale = 0.75, },
  idle_animation = { layers = { util.merge {{ filename = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-animation.png" }, sprite_data } } },
  always_draw_idle_animation = true
}
data:extend {
  stabilizer,
  rock,
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