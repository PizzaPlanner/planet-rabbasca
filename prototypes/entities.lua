require ("__base__.prototypes.entity.assemblerpipes")

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

assembler.next_upgrade = nil
assembler.deconstruction_alternative = nil
assembler.crafting_categories = { "complex-machinery", "install-ears-core" }
assembler.fluid_boxes = { 
{
  volume = 1000,
  pipe_picture = util.merge { assembler2pipepictures(), { north = { shift = util.by_pixel(2.25, 33.5), } } },
  pipe_covers = pipecoverspictures(),
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
local sprite_data = {   
  line_length = 10,
  width = 320,
  height = 320,
  frame_count = 100,
  scale = 0.5,
}

assembler.graphics_set = {
  frozen_patch = util.merge {{ filename = "__rabbasca-assets__/graphics/by-hurricane/gravity-assembler-frozen.png" }, sprite_data },
  working_visualisations = {
    {
      fadeout = true, 
      animation = util.merge { sprite_data, 
      { filename = "__rabbasca-assets__/graphics/by-hurricane/gravity-assembler-emission1.png", draw_as_glow = true, blend_mode = "additive" }},
    },
    {
      fadeout = true, 
      animation = util.merge { sprite_data, 
      { filename = "__rabbasca-assets__/graphics/by-hurricane/gravity-assembler-emission2.png", draw_as_glow = true, blend_mode = "additive" }},
    },
    {
      fadeout = true, 
      animation = util.merge { sprite_data, 
      { filename = "__rabbasca-assets__/graphics/by-hurricane/gravity-assembler-emission3.png", draw_as_glow = true, blend_mode = "additive" }},
    },
  },
  -- TODO: Shadow is missing
  idle_animation = { layers = { util.merge {{ filename = "__rabbasca-assets__/graphics/by-hurricane/gravity-assembler-animation.png" }, sprite_data } } },
  always_draw_idle_animation = true
}

data:extend{ 
  assembler,
  {
    type = "electric-energy-interface",
    name = "rabbasca-energy-source",
    icon = "__rabbasca-assets__/graphics/recolor/icons/vulcanus-bw.png",
    energy_production = Rabbasca.surface_megawatts() .. "MW",

    energy_source = { 
      type = "electric", 
      usage_priority = "primary-output", 
      buffer_capacity = (Rabbasca.surface_megawatts() / 6) .. "MJ", 
      output_flow_limit = Rabbasca.surface_megawatts() .. "MW",
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
  util.merge {
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
    }},
  util.merge{
    table.deepcopy(data.raw["fish"]["fish"]),
    {
      name = "rabbasca-turbofish",
      icon = "__rabbasca-assets__/graphics/recolor/icons/turbofish.png",
      minable = { result = "rabbasca-turbofish" },
      autoplace = { probability_expression = "rabbasca_harene_pools - 0.5" },
      -- collision_mask = { layers = { ground_tile = true } }
      map_generator_bounding_box = {{-1.5, -1.5}, {1.5, 1.5}},
      collision_mask = { layers = { lava_tile = true, ground_tile = true }, colliding_with_tiles_only = true }
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
      duration_in_ticks = 90 * second,
      target_movement_modifier = 1.9,
      damage_interval = 20,
      damage_per_tick = { amount = -5 },
    }
  },
  util.merge{
    table.deepcopy(data.raw["sticker"]["bioflux-speed-regen-sticker"]),
    {
      name = "hyperjuice-speed-sticker",
      duration_in_ticks = 600 * second,
      target_movement_modifier = 3.3,
      damage_interval = 20,
      damage_per_tick = { amount = -25 },
    }
  },
  util.merge {
    table.deepcopy(data.raw["rocket-silo-rocket"]["rocket-silo-rocket"]),
    {
      name = "rabbasca-rocket-silo-rocket",
      engine_starting_speed = 0.007,
      flying_acceleration = 0.03,
      flying_speed = 4.3333e-5,
      inventory_size = 40
    }
  }
}

data.raw["electric-energy-interface"]["rabbasca-energy-source"].collision_box = nil
data.raw["simple-entity"]["rabbasca-big-rock"].minable.results = {
  {type = "item", name = "stone", amount_min = 23, amount_max = 28}, 
  {type = "item", name = "iron-ore", amount_min = 17, amount_max = 22 }, 
  {type = "item", name = "carbon", amount_min = 3, amount_max = 5 }
}
data.raw["simple-entity"]["rabbasca-underground-rock"].minable.results = {
  {type = "item", name = "stone", amount_min = 12, amount_max = 17 }, 
  {type = "item", name = "calcite", amount_min = 9, amount_max = 12 }
}
for _, pic in pairs(data.raw["simple-entity"]["rabbasca-underground-rock"].pictures) do
  pic.scale = 5 * (pic.scale or 1)
end

data:extend { 
  util.merge {
    data.raw["electric-energy-interface"]["rabbasca-energy-source"],
    {
      name = "rabbasca-energy-source-big",
      energy_production = Rabbasca.surface_megawatts() * 5 .. "MW",
      energy_source = { 
        buffer_capacity = (Rabbasca.surface_megawatts() * 5 / 6) .. "MJ", 
        output_flow_limit = Rabbasca.surface_megawatts() * 5 .. "MW",
      },
      created_effect = {
        type = "direct",
        action_delivery = {
          {
            type = "instant",
            target_effects =
            {
              {
                type = "create-entity",
                entity_name = "rabbasca-energy-consumer-big",
                offsets = {{0, 0}},
                protected = true,
              },
            }
          }
        }
      }
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