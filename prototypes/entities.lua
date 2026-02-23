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
    energy_usage = "6.82MW",
    module_slots = 6,
}}

assembler.energy_source.drain = "180kW"
assembler.next_upgrade = nil
assembler.deconstruction_alternative = nil
assembler.crafting_categories = { "complex-machinery", "install-ears-core" }
assembler.fluid_boxes = { 
{
  volume = 1000,
  render_layer = "object-under",
  pipe_picture = util.merge { assembler2pipepictures(), { 
    north = { shift = util.by_pixel(0, 28), filename = "__base__/graphics/entity/pipe/pipe-ending-down.png", width = 128, height = 128,  },
    east  = { shift = util.by_pixel(-24.5 - 6, 1), },
    west  = { shift = util.by_pixel(25.75 + 6, 1), },
    south = { shift = util.by_pixel(0, -31.25 - 6), },
  } },
  pipe_covers = util.merge { pipecoverspictures(), {
    north = { layers = {{ filename = "__core__/graphics/empty.png" }, { filename = "__core__/graphics/empty.png", width = 64, height = 64, }}},
    east  = { layers = {{ shift = util.by_pixel(-6, 0), }, { shift = util.by_pixel(-6, 0), }}},
    west  = { layers = {{ shift = util.by_pixel( 6, 0), }, { shift = util.by_pixel( 6, 0), }}},
    south = { layers = {{ shift = util.by_pixel(0, -6), }, { shift = util.by_pixel(0, -6), }}},
  } },
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
assembler.circuit_connector = circuit_connector_definitions.create_vector(
    universal_connector_template,
    {
      { variation = 25, main_offset = util.by_pixel_hr(-104, 92), shadow_offset = util.by_pixel_hr(0, 0), show_shadow = false, },
      { variation = 25, main_offset = util.by_pixel_hr(-104, 92), shadow_offset = util.by_pixel_hr(0, 0), show_shadow = false, },
      { variation = 25, main_offset = util.by_pixel_hr(-104, 92), shadow_offset = util.by_pixel_hr(0, 0), show_shadow = false, },
      { variation = 25, main_offset = util.by_pixel_hr(-104, 92), shadow_offset = util.by_pixel_hr(0, 0), show_shadow = false, },
    }
  )

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
      render_no_power_icon = false,
      render_no_network_icon = false
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
      icon = "__rabbasca-assets__/graphics/recolor/icons/turbofish.png",
      minable = { result = "rabbasca-turbofish" },
      autoplace = { probability_expression = "0.3" },
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
