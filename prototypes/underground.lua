-- Items
data:extend{
{
    type = "item",
    name = "rabbasca-packaged-pylon",
    category = "rabbasca-security",
    order = "b[vault-access-key]",
    icon = "__rabbasca-assets__/graphics/recolor/icons/omega-carotene.png",
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
              effect_id = "rabbasca_on_send_pylon_underground"
            }
          }
        }
      }
    }
},
{
    type = "fluid",
    name = "rabbasca-perfluorosulfonic-acid",
    icons = 
    {
      { icon = data.raw["fluid"]["fluorine"].icon, icon_size = 64 },
      { icon = data.raw["fluid"]["sulfuric-acid"].icon, icon_size = 64, scale = 0.3 }
    },
    base_color = {0.65, 0.83, 0.15},
    flow_color = {0.65, 0.83, 0.15},
    default_temperature = 192,
},
{
  type = "item",
  name = "rabbasca-lithium-amide",
  icon = data.raw["item"]["lithium"].icon,
  stack_size = 50,
  weight = 25 * kg,
},
}

-- Recipes
data:extend {
    {
        type = "recipe",
        name = "rabbasca-petroleum-gas-from-atmosphere",
        icons = {
            { icon = data.raw["fluid"]["petroleum-gas"].icon, icon_size = 64, },
            { icon = data.raw["planet"]["rabbasca-underground"].icon, icon_size = 64, scale = 0.3, shift = { 8, 8 } },
        },
        enabled = false,
        energy_required = 2,
        ingredients = { },
        results = { 
            { type = "fluid", name = "petroleum-gas", amount = 50 },
        },
        enabled = false,
        allow_productivity = false,
        category = "cryogenics",
        surface_conditions = { Rabbasca.only_underground() },
        subgroup = "fluid-recipes",
        order = "r[rabbasca]-a[petroleum-gas]",
    },
    {
        type = "recipe",
        name = "rabbasca-perfluorosulfonic-acid-from-atmosphere",
        icons = util.merge {
            data.raw["fluid"]["rabbasca-perfluorosulfonic-acid"].icons,
            { {}, {}, { icon = data.raw["planet"]["rabbasca-underground"].icon, icon_size = 64, scale = 0.3, shift = { 8, 8 } }},
        },
        enabled = false,
        energy_required = 2,
        ingredients = { },
        results = { 
            { type = "fluid", name = "rabbasca-perfluorosulfonic-acid", amount = 100 },
        },
        enabled = false,
        allow_productivity = false,
        category = "cryogenics",
        surface_conditions = { Rabbasca.only_underground() },
        subgroup = "fluid-recipes",
        order = "r[rabbasca]-a[perfluorosulfonic-acid]",
    },
    {
        type = "recipe",
        name = "rabbasca-decompose-perfluorosulfonic-acid",
        enabled = false,
        icons = {
            { icon = data.raw["fluid"]["fluorine"].icon, scale = 0.5, shift = {-3, -8}, icon_size = 64 },
            { icon = data.raw["fluid"]["sulfuric-acid"].icon, scale = 0.5, shift = {-3, -8}, icon_size = 64 },
            { icon = data.raw["fluid"]["fluorine"].icon, scale = 0.5, shift = {3, 8}, icon_size = 64 },
            { icon = data.raw["fluid"]["sulfuric-acid"].icon, scale = 0.5, shift = {8, 3}, icon_size = 64 },
        },
        energy_required = 2,
        ingredients = {
            { type = "fluid", name = "rabbasca-perfluorosulfonic-acid", amount = 100 },
        },
        results = {
            { type = "fluid", name = "fluorine", amount = 80 }, 
            { type = "fluid", name = "sulfuric-acid", amount = 20 },
        },
        enabled = false,
        allow_productivity = false,
        category = "chemistry-or-cryogenics",
        surface_conditions = { Rabbasca.only_underground() },
        subgroup = "fluid-recipes",
        order = "r[rabbasca]-a[perfluorosulfonic-acid-decompose]",
    },
}

-- Technologies
data:extend{
{
    type = "technology",
    name = "rabbasca-underground",
    icon = "__rabbasca-assets__/graphics/recolor/technologies/rabbasca-big.png",
    icon_size = 256,
    prerequisites = { "interplanetary-construction-2", "fusion-reactor" },
    effects = {
      {
        type = "unlock-space-location",
        space_location = "rabbasca-underground",
        use_icon_overlay_constant = true
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-packaged-pylon"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-perfluorosulfonic-acid-from-atmosphere"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-petroleum-gas-from-atmosphere"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-decompose-perfluorosulfonic-acid"
      },
    },
    unit = {
        count = 1000,
        time = 60,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"athletic-science-pack", 1},
            {"metallurgic-science-pack", 1},
            {"promethium-science-pack", 1},
        }
    }
},
}

-- Vault-recipes
Rabbasca.create_vault_recipe("rabbasca-packaged-pylon", {
  icons = {
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {icon = data.raw["item"]["rabbasca-warp-pylon"].icon, icon_size = 64, shift = {-8, 8}, scale = 0.4},
    {icon = data.raw["planet"]["rabbasca-underground"].icon, icon_size = 64, shift = {8, 8}, scale = 0.4},
  },
  ingredients = {
      { type = "item", name = "haronite-plate", amount = 5 },
      { type = "item", name = "rabbasca-warp-pylon", amount = 1 },
      { type = "item", name = "bunnyhop-engine-equipment", amount = 1 },
      { type = "item", name = "rabbasca-energetic-concrete", amount = 4 },
      { type = "item", name = "small-lamp", amount = 4 },
  },
  results = { 
      { type = "item", name = "rabbasca-packaged-pylon", amount = 1 },
  },
  energy_required = 40,
  allow_productivity = false,
})

-- Tips and tricks
data:extend {
{
    type = "tips-and-tricks-item",
    name = "rabbasca-underground-briefing",
    category = "space-age",
    tag = "[planet=rabbasca-underground]",
    indent = 1,
    order = "r[rabbasca]-u",
    trigger = {
        type = "research",
        technology = "rabbasca-underground",
    },
}
}

-- Surfaces
data:extend { 
  {
    type = "planet",
    name = "rabbasca-underground",
    icon = "__rabbasca-assets__/graphics/by-openai/rabbasca-underground.png", 
    icon_size = 128,
    hidden = true,
    draw_orbit = false,
    distance = 10,
    orientation = 0,
    gleba.order .. "-r[rabbasca-underground]",
    map_seed_offset = rabbasca_seed_offset,
    surface_properties = {
        ["gravity"] = 8,
        ["solar-power"] = 0,
        ["pressure"] = Rabbasca.underground_pressure(),
        ["magnetic-field"] = 0.01,
        ["harenic-energy-signatures"] = Rabbasca.surface_megawatts() * 0.1,
        ["day-night-cycle"] = 30 * second,
    },
    map_gen_settings = {
      cliff_settings = {
        name = "rabbasca-underground-cliff",
        cliff_elevation_0 = 0.255,
        cliff_elevation_interval = 0.4,
        cliff_smoothing = 0,
        -- richness = 10,
      },
      property_expression_names = {
        elevation = "rabbasca_underground_elevation",
        cliff_elevation = "rabbasca_underground_elevation",
        cliffiness = "1",
      },
      autoplace_controls = 
      {
          ["rabbasca_vaults"] = {},
      },
      autoplace_settings = {
      tile = { settings = {
        ["rabbasca-underground-rubble"] = {},
        ["rabbasca-underground-out-of-map"] = {},
      }},
      entity = { settings = {
        ["rabbasca-energy-source-big"] = {},
        -- ["rabbasca-underground-rock"] = {},
        ["rabbasca-carbonic-ore"] = {},
        ["rabbasca-lithium-amide"] = {},
      }}
      },
      territory_settings =
      {
        units = {"rabbasca-underground-devourer"},
        territory_index_expression = "rabbasca_devourer_territory_expression",
        territory_variation_expression = "demolisher_variation_expression",
        minimum_territory_size = 8
      },
    },
    surface_render_parameters = {
      shadow_opacity = 0.8,
      draw_sprite_clouds = false,
      clouds = nil,
      day_night_cycle_color_lookup = {
          {0.0, "__rabbasca-assets__/graphics/recolor/textures/lut-underground.png"},
          {0.5, "__rabbasca-assets__/graphics/recolor/textures/lut-black.png"}
      },
      fog = util.merge {
        data.raw["planet"]["vulcanus"].surface_render_parameters.fog,
        {
          color1 = {0.45, 0.3706, 1},
          color2 = {0.4, 0.2706,  0.9902},
          tick_factor = 0.0005,
        }
      }
    },
  }
}

-- Resources

local carbonic_ore = util.merge {
  table.deepcopy(data.raw["resource"]["coal"]),
  {
    name = "rabbasca-carbonic-ore",
    icon = data.raw["item"]["coal"].icon,
    minimum = 100,
    normal = 100,
    infinite = true,
    map_color = { 0.03, 0.1, 0.07 },
    -- stages = { sheet = { filename = "__rabbasca-assets__/graphics/recolor/icons/carotenoid-ore.png" } },
    cliff_removal_probability = 0,
    tree_removal_probability = 0,
  }
}
carbonic_ore.minable.results =
{
  { type = "item", name = "coal",    amount = 1, probability = 0.25, },
  { type = "item", name = "stone",    amount = 1, probability = 0.1, },
  { type = "item", name = "sulfur",   amount = 1, probability = 0.03, },
  -- { type = "item", name = "haronite",  amount = 1, probability = 0.03, },
}
carbonic_ore.autoplace = {
  tile_restriction = { "rabbasca-underground-rubble" },
  probability_expression = "rabbasca_underground_resources",
  richness_expression = "100",
}

local lithium_amide = util.merge {
  table.deepcopy(data.raw["resource"]["calcite"]),
  {
    name = "rabbasca-lithium-amide",
    icon = data.raw["item"]["calcite"].icon,
    minimum = 100,
    normal = 100,
    infinite = false,
    map_color = { 0.85, 0.94, 0.92 },
    -- stages = { sheet = { filename = "__rabbasca-assets__/graphics/recolor/icons/carotenoid-ore.png" } },
    cliff_removal_probability = 0,
    tree_removal_probability = 0,
  }
}
lithium_amide.minable.results =
{
  { type = "item", name = "rabbasca-lithium-amide", amount = 1 },
  -- { type = "item", name = "calcite",  amount = 1, probability = 0.05, },
}
lithium_amide.autoplace = {
  probability_expression = "rabbasca_underground_lithium_amide",
  richness_expression = "550 * (1 + sqrt(distance))",
}

data:extend{ carbonic_ore, lithium_amide }