require("__quality__.prototypes.recycling")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local logistic_chest_opened_duration = 7

local function make_warp_sequence(name, icon, tint)
return {
    type = "recipe",
    name = name,
    icons = {
      { icon = "__rabbasca-assets__/graphics/icons/warp.png", icon_size = 64 },
      { icon = icon, icon_size = 64, scale = 0.25, shift = { 8, 8 } },
    },
    enabled = false,
    hide_from_player_crafting = true,
    hidden = true,
    hide_from_stats = true,
    hide_from_signal_gui = true,
    hidden_in_factoriopedia = true,
    result_is_always_fresh = true,
    energy_required = 0.5,
    ingredients = { },
    results = { {type = "item", name = "rabbasca-warp-sequence", amount = 1 } },
    main_product = "rabbasca-warp-sequence",
    crafting_machine_tint = {primary = tint or {1, 1, 1}},
    category = "rabbasca-remote",
    subgroup = "rabbasca-remote-warping",
    order = "c[sequence]",
}
end

local warp_icons = {
      { icon = "__rabbasca-assets__/graphics/recolor/icons/item-warp-slot.png", icon_size = 64 },
      { icon = "__rabbasca-assets__/graphics/icons/warp.png", icon_size = 64, scale = 0.25, shift = {0, -3} }
}

data:extend {
  {
    type = "virtual-signal",
    name = "rabbasca-warp-inventory",
    icon = "__rabbasca-assets__/graphics/icons/warp.png",
    subgroup = "pictographs",
    order = "r[warp-inventory]"
  },
  {
    type = "logistic-container",
    name = "rabbasca-warp-input",
    icon = "__rabbasca-assets__/graphics/by-hurricane/research-center-icon.png",
    icon_size = 64,
    flags = { "placeable-player", "player-creation", "no-automated-item-removal" },
    minable = {mining_time = 0.5, result = "rabbasca-warp-input"},
    max_health = 100,
    corpse = "requester-chest-remnants",
    dying_explosion = "requester-chest-explosion",
    collision_box = {{-0.85, -0.85}, {0.85, 0.85}},
    selection_box = {{-1, -1}, {1, 1}},
    damaged_trigger_effect = hit_effects.entity(),
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "impact",
        percent = 60
      }
    },
    fast_replaceable_group = "container",
    inventory_size = 9,
    icon_draw_specification = {scale = 0.7},
    trash_inventory_size = 10,
    logistic_mode = "requester",
    open_sound = sounds.metallic_chest_open,
    close_sound = sounds.metallic_chest_close,
    animation_sound = sounds.logistics_chest_open,
    impact_category = "metal",
    opened_duration = logistic_chest_opened_duration,
    animation =
    {
      layers =
      {
        {
          filename = "__rabbasca-assets__/graphics/by-hurricane/research-center-animation.png",
          frame_count = 8 * 10,
          line_length = 10,
          width = 5900 / 10,
          height = 5120 / 8,
          scale = 0.1,
          shift = {0, 0},
        },
      }
    },
  },
  {
      type = "item",
      name = "rabbasca-warp-input",
      icon = "__rabbasca-assets__/graphics/by-hurricane/research-center-icon.png",
      icon_size = 64,
      stack_size = 10,
      place_result = "rabbasca-warp-input",
      weight = 100 * kg,
      subgroup = "rabbasca-remote-warping",
      order = "a[placeable]-b[input]",
  },
  {
    type = "recipe",
    name = "rabbasca-warp-input",
    energy_required = 8,
    enabled = false,
    category = "crafting",
    ingredients = { { type = "item", name = "rabbasca-warp-core", amount = 5 } },
    results = { { type = "item", name = "rabbasca-warp-input", amount = 1 } }
  },
  {
    type = "assembling-machine",
    name = "rabbasca-warp-pylon",
    icon = "__rabbasca-assets__/graphics/by-hurricane/conduit-icon.png",
    icon_size = 64,
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
    crafting_speed_quality_multiplier = { }, -- filled in final-fixes
    energy_source = { type = "void" },
    collision_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selection_box = {{-1, -1}, {1, 1}},
    tile_buildability_rules = { Rabbasca.ears_flooring_rule({{-0.8, -0.8}, {0.8, 0.8}}) },
    radius_visualisation_specification = {
      sprite = data.raw["utility-sprites"]["default"].construction_radius_visualization,
      distance = Rabbasca.get_warp_radius(),
    },
    custom_tooltip_fields = {
      {
        name = {"tooltip.rabbasca-warp-pylon-range"},
        value = {"tooltip-value.rabbasca-warp-pylon-range", "21"},
        quality_header = "quality-tooltip.increases",
        quality_values = { },
      }
    },
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
      type = "item",
      name = "rabbasca-warp-pylon",
      icon = "__rabbasca-assets__/graphics/by-hurricane/conduit-icon.png",
      icon_size = 64,
      stack_size = 5,
      place_result = "rabbasca-warp-pylon",
      weight = 200 * kg,
      subgroup = "rabbasca-remote-warping",
      order = "a[placeable]-a[pylon]",
  },
  Rabbasca.make_trigger_item({
    name = "rabbasca-warp-sequence",
    category = "rabbasca-remote",
    subgroup = "rabbasca-remote-warping",
    order = "b[warp-sequence]",
    icons = warp_icons,
    hidden = false,
    hidden_in_factoriopedia = false,
  }, "rabbasca_on_warp_attempt"),
{
    type = "recipe-category",
    name = "rabbasca-remote",
},
{
    type = "item-subgroup",
    name = "rabbasca-remote",
    group = data.raw["item-group"]["rabbasca-extensions"] and "rabbasca-extensions" or "space",
    order = "03[remote]"
},
{
    type = "item-subgroup",
    name = "rabbasca-remote-warping",
    group = data.raw["item-group"]["rabbasca-extensions"] and "rabbasca-extensions" or "space",
    order = "03[remote-warping]"
},
make_warp_sequence("rabbasca-warp-sequence-building", data.raw["entity-ghost"]["entity-ghost"].icon, {1, 1, 1}),
make_warp_sequence("rabbasca-warp-sequence-tile", data.raw["tile-ghost"]["tile-ghost"].icon, {1, 0.6, 1}),
make_warp_sequence("rabbasca-warp-sequence-module", data.raw["item-request-proxy"]["item-request-proxy"].icon, {1, 1, 0.7}),
make_warp_sequence("rabbasca-warp-sequence-reverse", data.raw["deconstruction-item"]["deconstruction-planner"].icon, {1, 0.3, 0,3}),
make_warp_sequence("rabbasca-warp-sequence-upgrade", data.raw["upgrade-item"]["upgrade-planner"].icon, {0.5, 1, 0.5}),
{
    type = "recipe",
    name = "rabbasca-remote-warmup",
    icon = data.raw["virtual-signal"]["signal-hourglass"].icon,
    enabled = true,
    hidden = false,
    hide_from_player_crafting = true,
    hide_from_stats = true,
    hide_from_signal_gui = true,
    result_is_always_fresh = true,
    energy_required = 7,
    ingredients = { },
    results = { {type = "item", name = "rabbasca-warp-sequence", amount = 1 } },
    category = "rabbasca-remote",
    subgroup = "rabbasca-remote-warping",
    order = "d[warmup]",
    crafting_machine_tint = {primary = {0.3, 0.35, 0.4}}
},
{
    type = "animation",
    name = "rabbasca-warp-smoke",
    lines_per_file = 4,
    line_length = 8,
    frame_count = 32,
    width = 64,
    height = 64,
    draw_as_glow = true,
    filename = "__rabbasca-assets__/graphics/textures/warp-smoke.png"
}
}

data:extend {
  -- {
  --   type = "recipe",
  --   name = "rabbasca-warp-pylon-recycling",
  --   enabled = false,
  --   icons = generate_recycling_recipe_icons_from_item(data.raw.item["rabbasca-warp-pylon"]),
  --   ingredients = { { type = "item", name = "rabbasca-warp-pylon", amount = 1 }, },
  --   results = { 
  --     { type = "item", name = "rabbasca-warp-core", amount = 3 }, 
  --     { type = "item", name = "haronite-plate",     amount = 1 }, 
  --   },
  --   category = "recycling",
  --   hide_from_player_crafting = true,
  --   energy_required = 30,
  --   unlock_results = true,
  --   subgroup = "rabbasca-security",
  --   order = "x[rabbasca-warp-core]-recycling",
  --   localised_name = {"recipe-name.recycling", {"entity-name.rabbasca-warp-pylon"}},
  -- },
  {
    type = "recipe",
    name = "rabbasca-warp-pylon-indicator",
    enabled = false,
    category = "parameters", -- can not be crafted, just for unlocking the icon in menus?
    hidden_in_factoriopedia = true,
    hidden = true,
    hide_from_player_crafting = true,
    results = { { type = "item", name = "rabbasca-warp-pylon", amount = 1 }, },
    main_product = "rabbasca-warp-pylon"
  }
}