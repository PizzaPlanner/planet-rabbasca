data:extend {
    {
        type = "recipe-category",
        name = "rabbasca-warp-stabilizer",
    },
    {
        type = "item-subgroup",
        name = "rabbasca-warp-stabilizer",
        group = data.raw["item-group"]["rabbasca-extensions"] and "rabbasca-extensions" or "intermediate-products",
        order = "1[stabilizer]"
    },
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
            { type = "fluid", name = "fluorine", amount = 70 }, 
            { type = "fluid", name = "sulfuric-acid", amount = 30 },
        },
        allow_productivity = false,
        category = "chemistry-or-cryogenics",
        surface_conditions = { Rabbasca.only_underground() },
        subgroup = "fluid-recipes",
        order = "r[rabbasca]-a[perfluorosulfonic-acid-decompose]",
    },
    {
        type = "recipe",
        name = "rabbasca-lithium-amide-fission",
        icons = {
            { icon = data.raw["item"]["rabbasca-lithium-amide"].icon, scale = 0.5, shift = {-3, -8}, icon_size = 64 },
            { icon = data.raw["item"]["lithium"].icon, scale = 0.5, shift = {8, 3}, icon_size = 64 },
            { icon = data.raw["fluid"]["ammonia"].icon, scale = 0.5, shift = {3, 8}, icon_size = 64 },
        },
        enabled = false,
        energy_required = 12,
        ingredients = {
            { type = "item", name = "rabbasca-lithium-amide", amount = 4 },
            { type = "fluid", name = "sulfuric-acid", amount = 50 },
        },
        results = { 
            { type = "item", name = "lithium", amount = 5 },
            { type = "fluid", name = "ammonia", amount = 80 },
        },
        surface_conditions = { Rabbasca.only_underground() },
        category = "electromagnetics"
    },
    {
        type = "recipe",
        name = "rabbasca-reboot-stabilizer",
        enabled = true,
        hidden = true,
        hidden_in_factoriopedia = true,
        energy_required = 30,
        ingredients = { { type = "item", name = "lithium-plate", amount = 1 } },
        results = { { type = "item", name = "rabbasca-reboot-stabilizer", amount = 1 } },
        category = "rabbasca-warp-stabilizer",
        result_is_always_fresh = true,
        auto_recycle = false,
        crafting_machine_tint = {
            primary = { 0.95, 0.83, 0.14 }
        }
    },
    {
        type = "recipe",
        name = "rabbasca-perfluorosulfonic-filter",
        enabled = false,
        energy_required = 35,
        result_is_always_fresh = true,
        ingredients = {
            { type = "fluid", name = "rabbasca-perfluorosulfonic-acid", amount = 150 },
            { type = "fluid", name = "ammonia",       amount = 10 },
            { type = "item",  name = "lithium-plate", amount = 3 },
        },
        results = { { type = "item", name = "rabbasca-perfluorosulfonic-filter", amount = 1 } },
        category = "chemistry-or-cryogenics"
    },
    {
        type = "recipe",
        name = "rabbasca-holmium-from-harenic-lava",
        icons = {
            { icon = data.raw["fluid"]["harenic-lava"].icon, icon_size = 64, shift = {-8, -8}},
            { icon = data.raw["fluid"]["holmium-solution"].icon, icon_size = 64, shift = {8, 8}},
        },
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "fluid", name = "harenic-lava", amount = 500 },
            { type = "item",  name = "rabbasca-perfluorosulfonic-filter", amount = 1 },
        },
        results = { 
            { type = "fluid", name = "harenic-lava", amount = 490, ignored_by_productivity = 500 },
            { type = "item", name = "rabbasca-perfluorosulfonic-filter", amount = 1, probability = 0.7, ignored_by_productivity = 1 },
            { type = "fluid", name = "holmium-solution", amount = 10, },
        },
        category = "metallurgy"
    },
    {
        type = "recipe",
        name = "rabbasca-copper-from-harenic-lava",
        icons = {
            { icon = data.raw["fluid"]["harenic-lava"].icon, icon_size = 64, shift = {-8, -8}},
            { icon = data.raw["fluid"]["molten-copper"].icon, icon_size = 64, shift = {8, 8}},
        },
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "fluid", name = "harenic-lava", amount = 500 },
            { type = "fluid", name = "harene-gas", amount = 65 },
            { type = "item",  name = "rabbasca-perfluorosulfonic-filter", amount = 1 },
        },
        results = { 
            { type = "fluid", name = "harenic-lava", amount = 450, ignored_by_productivity = 500 },
            { type = "item", name = "rabbasca-perfluorosulfonic-filter", amount = 1, probability = 0.7, ignored_by_productivity = 1 },
            { type = "fluid", name = "molten-copper", amount = 50, },
        },
        category = "metallurgy"
    },
    {
        type = "recipe",
        name = "rabbasca-iron-from-harenic-lava",
        icons = {
            { icon = data.raw["fluid"]["harenic-lava"].icon, icon_size = 64, shift = {-8, -8}},
            { icon = data.raw["fluid"]["molten-iron"].icon, icon_size = 64, shift = {8, 8}},
        },
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "fluid", name = "harenic-lava", amount = 500 },
            { type = "fluid", name = "fluorine", amount = 120 },
            { type = "item",  name = "rabbasca-perfluorosulfonic-filter", amount = 1 },
        },
        results = { 
            { type = "fluid", name = "harenic-lava", amount = 420, ignored_by_productivity = 500 },
            { type = "item", name = "rabbasca-perfluorosulfonic-filter", amount = 1, probability = 0.7, ignored_by_productivity = 1 },
            { type = "fluid", name = "molten-iron", amount = 50, },
        },
        category = "metallurgy"
    },
    {
        type = "recipe",
        name = "rabbasca-warp-matrix",
        enabled = false,
        main_product = "rabbasca-warp-matrix",
        energy_required = 1,
        result_is_always_fresh = true,
        preserve_products_in_machine_output = true,
        ingredients = { },
        results = { 
            { type = "item", name = "rabbasca-warp-matrix", amount = 5 },
        },
        crafting_machine_tint =
        {
            primary = { 0.5, 0.83, 1 }
        },
        category = "rabbasca-warp-stabilizer"
    },
    {
        type = "recipe",
        name = "rabbasca-coordinate-calibrations",
        enabled = false,
        energy_required = 5,
        ingredients = {
            { type = "item",  name = "rabbasca-warp-matrix", amount = 5 },
            { type = "item", name = "low-density-structure",  amount = 1 },
        },
        results = { { type = "item", name = "rabbasca-coordinate-calibrations", amount = 1 } },
        surface_conditions = { Rabbasca.only_underground(true) },
        category = "cryogenics"
    },
    {
        type = "recipe",
        name = "rabbasca-spatial-anchor",
        enabled = false,
        energy_required = 5,
        ingredients = {
            { type = "item",  name = "rabbasca-warp-matrix", amount = 5 },
            { type = "item",  name = "haronite-plate",  amount = 5 },
        },
        results = { { type = "item", name = "rabbasca-spatial-anchor", amount = 1 } },
        category = "electromagnetics",
        surface_conditions = { Rabbasca.only_underground(true) },
    },
    {
        type = "recipe",
        name = "rabbasca-holmium-coating",
        enabled = false,
        energy_required = 7,
        ingredients = {
            { type = "item", name = "tungsten-ore", amount = 5 },
            { type = "fluid", name = "holmium-solution", amount = 70 },
            { type = "fluid", name = "rabbasca-perfluorosulfonic-acid", amount = 100 },
        },
        results = {
            { type = "item", name = "rabbasca-holmium-coating", amount = 1 },
        },
        allow_productivity = true,
        category = "metallurgy",
        surface_conditions = { Rabbasca.only_underground(true) },
    },
    {
        type = "recipe",
        name = "rabbasca-spacetime-evolutionizer",
        enabled = false,
        energy_required = 12,
        ingredients = {
            { type = "item", name = "rabbasca-warp-matrix", amount = 5 },
            { type = "item", name = "carbon-fiber", amount = 5 },
            { type = "item", name = "pentapod-egg", amount = 1 },
        },
        results = {
            { type = "item", name = "rabbasca-spacetime-evolutionizer", amount = 1 },
        },
        allow_productivity = true,
        surface_conditions = { Rabbasca.only_underground(true) },
        category = "organic",
    },
    {
        type = "recipe",
        name = "rabbasca-warp-core",
        enabled = false,
        auto_recycle = false,
        energy_required = 25,
        ingredients = {
            { type = "item", name = "rabbasca-holmium-coating", amount = 1 },
            { type = "item", name = "rabbasca-coordinate-calibrations", amount = 1 },
            { type = "item", name = "rabbasca-spatial-anchor",  amount = 1 },
            { type = "item", name = "rabbasca-spacetime-evolutionizer",  amount = 1 },
        },
        results = { { type = "item", name = "rabbasca-warp-core", amount = 1 } },
        category = "electromagnetics"
    },
    {
        type = "recipe",
        name = "rabbasca-warp-tech-analyzer",
        enabled = false,
        energy_required = 2,
        ingredients = {
            { type = "item", name = "lab", amount = 1 },
            { type = "item", name = "pipe",  amount = 10 },
        },
        results = { { type = "item", name = "rabbasca-warp-tech-analyzer", amount = 1 } },
        category = "crafting"
    },
    {
        type = "recipe",
        name = "rabbasca-warp-pylon",
        enabled = false,
        energy_required = 10,
        ingredients = {
            { type = "item", name = "rabbasca-warp-core", amount = 20 },
            { type = "item", name = "haronite-plate",  amount = 4 },
        },
        results = { { type = "item", name = "rabbasca-warp-pylon", amount = 1 } },
        category = "complex-machinery"
    },
}

Rabbasca.create_vault_recipe("rabbasca-locate-stabilizer", {
  icons = {
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {icon = data.raw["item"]["rabbasca-warp-pylon"].icon, icon_size = 64, shift = {-8, 8}, scale = 0.4},
    {icon = data.raw["planet"]["rabbasca-underground"].icon, icon_size = 64, shift = {8, 8}, scale = 0.4},
  },
  ingredients = {
      { type = "item", name = "haronite-plate", amount = 5 },
      { type = "item", name = "rabbasca-warp-core", amount = 1 },
      { type = "item", name = "rabbasca-energetic-concrete", amount = 4 },
      { type = "item", name = "fusion-power-cell", amount = 10 },
  },
  results = { 
      { type = "item", name = "rabbasca-locate-stabilizer", amount = 1 },
  },
  energy_required = 120,
  allow_productivity = false,
})