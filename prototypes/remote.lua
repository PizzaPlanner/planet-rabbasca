local RECEIVER_RADIUS = 21 -- Also in scripts/remote-builder.lua. Should be unified sometime.
local rutil = require("__planet-rabbasca__.util")
-- local recycling = require("__quality__.prototypes.recycling")
local hatch = { 
  cargo_unit_entity_to_spawn = "rabbasca-warp-sequence", 
  receiving_cargo_units = {},
  travel_height = 2,
  slice_height = 2, 
  busy_timeout_ticks = 60, 
  hatch_opening_ticks = 240, 
  offset = {1.2, -2.7}, 
}
local warp_icons = {
      { icon = "__rabbasca-assets__/graphics/recolor/icons/item-warp-slot.png", icon_size = 64 },
      { icon = "__rabbasca-assets__/graphics/icons/warp.png", icon_size = 64, scale = 0.25, shift = {0, -3} }
}

local pad = util.merge {
    data.raw["cargo-landing-pad"]["cargo-landing-pad"],
    {
        name = "rabbasca-warp-cargo-pad",
        icon = "__rabbasca-assets__/graphics/by-hurricane/research-center-icon.png",
        minable = { result = "rabbasca-warp-cargo-pad", mining_time = 4 },
        placeable_by = { item = "rabbasca-warp-cargo-pad", count = 1 },
        inventory_size = 20,
        trash_inventory_size = 20,
    }
}

pad.cargo_station_parameters = {
    prefer_packed_cargo_units = false,
    is_input_station = true,
    is_output_station = true,
    hatch_definitions = { hatch, hatch, hatch, hatch, hatch, hatch, hatch, hatch, hatch },
    giga_hatch_definitions = {{
        covered_hatches = { 0, 1, 2, 3, 4, 5, 6, 7, 8 },
        hatch_graphics_front = {
            layers = {{
                filename = "__rabbasca-assets__/graphics/by-hurricane/research-center-animation.png",
                frame_count = 8 * 10,
                line_length = 10,
                width = 5900 / 10,
                height = 5120 / 8,
                scale = 0.17,
                shift = {1.2, -2.7},
            }}
        }
    }}
}
pad.surface_conditions = {
    { property = "harenic-energy-signatures", min = 20 }
}

data:extend {
  pad,
  {
    type = "assembling-machine",
    name = "rabbasca-warp-pylon",
    icon = "__rabbasca-assets__/graphics/by-hurricane/conduit-icon.png",
    -- fixed_recipe = "rabbasca-warp-sequence",
    flags = { "not-rotatable", "placeable-player", "player-creation" },
    crafting_categories = { "rabbasca-remote" },
    minable = { result = "rabbasca-warp-pylon", mining_time = 1 },
    placeable_by = { item = "rabbasca-warp-pylon", count = 1 },
    max_health = 240,
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
      distance = RECEIVER_RADIUS,
    },
    created_effect = {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        source_effects =
        {
          {
            type = "script",
            effect_id = "rabbasca_init_receiver"
          },
        }
      },
    },
    show_recipe_icon = false,
    graphics_set = {
      working_visualisations = {{
        animation = {
              filename = "__rabbasca-assets__/graphics/by-hurricane/conduit-emission.png",
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
      default_recipe_tint = { primary = {0.5, 1, 0} },
      idle_animation = {
        layers = {
          {
            filename = "__rabbasca-assets__/graphics/by-hurricane/conduit-animation.png",
            frame_count = 60,
            line_length = 10,
            width = 200,
            height = 290,
            scale = 1.0/3,
            flags = {"no-scale"},
            shift = {0, -0.5},
          },
          {
              filename = "__rabbasca-assets__/graphics/by-hurricane/conduit-hr-shadow.png",
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
    type = "cargo-pod",
    name = "rabbasca-warp-sequence",
    icons = warp_icons,
    flags = { "placeable-off-grid", "not-in-kill-statistics", "placeable-neutral" },
    collision_mask = { layers = { } },
    collision_box = {{0, 0}, {0, 0}},
    -- hidden = true,
    inventory_size = 1,
    spawned_container = "rabbasca-warp-container",
  },
  {
    name = "rabbasca-warp-container",
    type = "temporary-container",
    icon = "__rabbasca-assets__/graphics/recolor/icons/item-warp-slot.png",
    hidden = true,
    flags = { "placeable-off-grid", "not-in-kill-statistics", "placeable-neutral" },
    collision_mask = { layers = { } },
    collision_box = {{0, 0}, {0, 0}},
    destroy_on_empty = true,
    time_to_live = 1,
    inventory_size = 1,
    dying_trigger_effect = {
      type = "script",
      effect_id = "rabbasca_on_warp_complete"
    }
  },
  {
    type = "item",
    name = "rabbasca-warp-cargo-pad",
    icon = "__rabbasca-assets__/graphics/by-hurricane/research-center-icon.png",
    stack_size = 5,
    place_result = "rabbasca-warp-cargo-pad",
    subgroup = "space-interactors",
    order = "c[cargo-landing-pad]-r[rabbasca-warp-cargo-pad]",
  },
  {
      type = "item",
      name = "rabbasca-warp-pylon",
      icon = "__rabbasca-assets__/graphics/by-hurricane/conduit-icon.png",
      stack_size = 5,
      place_result = "rabbasca-warp-pylon",
      subgroup = "space-interactors",
      order = "c[cargo-landing-pad]-r[rabbasca-warp-pylon]",
  },
  {
    type = "item",
    name = "rabbasca-warp-sequence",
    category = "rabbasca-security",
    order = "b[vault-access-key]",
    icons = warp_icons,
    flags = { "ignore-spoil-time-modifier" },
    hidden = true,
    hidden_in_factoriopedia = true,
    auto_recycle = false,
    stack_size = 1,
    spoil_ticks = 1,
    spoil_to_trigger_result =
    {
      items_per_trigger = 1,
      trigger =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          source_effects =
          {
            {
              type = "script",
              effect_id = "rabbasca_on_warp_attempt"
            }
          }
        }
      }
    }
},
{
    type = "recipe-category",
    name = "rabbasca-remote",
},
{
    type = "recipe",
    name = "rabbasca-warp-cargo-pad",
    enabled = false,
    energy_required = 20,
    ingredients = {
        {type = "item", name = "cargo-landing-pad",          amount = 1 }, 
        {type = "item", name = "bunnyhop-engine-equipment",  amount = 1 },
        {type = "item", name = "rabbasca-warp-core",         amount = 10 },
        {type = "item", name = "superconductor",             amount = 30 },
    },
    results = { 
        { type = "item", name = "rabbasca-warp-cargo-pad", amount = 1 },
    },
    surface_conditions = {{ property = "harenic-energy-signatures", min = 20 }},
    main_product = "rabbasca-warp-cargo-pad",
    category = "complex-machinery"
},
{
    type = "recipe",
    name = "rabbasca-warp-sequence",
    icon = "__rabbasca-assets__/graphics/icons/warp.png",
    enabled = true,
    hidden = true,
    hidden_in_factoriopedia = true,
    hide_from_player_crafting = true,
    result_is_always_fresh = true,
    energy_required = 1,
    ingredients = { },
    results = { {type = "item", name = "rabbasca-warp-sequence", amount = 1 } },
    main_product = "rabbasca-warp-sequence",    
    category = "rabbasca-remote",
    crafting_machine_tint = {primary = {2, 2, 2}}
},
{
    type = "recipe",
    name = "rabbasca-remote-warmup",
    icon = data.raw["virtual-signal"]["signal-hourglass"].icon,
    enabled = true,
    hidden = true,
    hidden_in_factoriopedia = true,
    hide_from_player_crafting = true,
    result_is_always_fresh = true,
    energy_required = 7,
    ingredients = { },
    results = { {type = "item", name = "rabbasca-warp-sequence", amount = 1 } },
    main_product = "rabbasca-warp-sequence",    
    category = "rabbasca-remote",
    crafting_machine_tint = {primary = {0.3, 0.35, 0.4}}
},
}

data:extend {
  {
    type = "recipe",
    name = "rabbasca-warp-pylon-recycling",
    enabled = false,
    icons = generate_recycling_recipe_icons_from_item(data.raw.item["rabbasca-warp-pylon"]),
    ingredients = { { type = "item", name = "rabbasca-warp-pylon", amount = 1 }, },
    results = { { type = "item", name = "rabbasca-warp-core", amount = 1 }, },
    category = "recycling",
    hide_from_player_crafting = true,
    energy_required = 30,
    unlock_results = true,
    subgroup = "rabbasca-security",
    order = "x[rabbasca-warp-core]-recycling",
    localised_name = {"recipe-name.recycling", {"entity-name.rabbasca-warp-pylon"}},
  },
  {
    type = "recipe",
    name = "rabbasca-warp-pylon",
    enabled = false,
    category = "parameters", -- can not be crafted, just for unlocking the icon in menus?
    hidden_in_factoriopedia = true,
    hidden = true,
    hide_from_player_crafting = true,
    results = { { type = "item", name = "rabbasca-warp-pylon", amount = 1 }, },
    main_product = "rabbasca-warp-pylon"
  }
}