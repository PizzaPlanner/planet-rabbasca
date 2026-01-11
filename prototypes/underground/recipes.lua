local function make_materialize_recipe(name, icon, result, ingredients)
    return {
        type = "recipe",
        name = name,
        icons = {
            { icon = icon },
            { icon = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-icon.png", icon_size = 640, scale = 0.03, shift = {8, 8} },
        },
        energy_required = 20,
        ingredients = ingredients,
        results = { result },
        enabled = false,
        auto_recycle = false,
        category = "rabbasca-warp-stabilizer",
        subgroup = "rabbasca-warp-stabilizer",
        order = "f[materialized]-"..result.name,
    }
end
data:extend {
    {
        type = "recipe-category",
        name = "rabbasca-warp-stabilizer",
    },
    {
        type = "item-subgroup",
        name = "rabbasca-warp-stabilizer",
        group = data.raw["item-group"]["rabbasca-extensions"] and "rabbasca-extensions" or "intermediate-products",
        order = "a[stabilizer]"
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
            { type = "fluid", name = "ammonia", amount = 60 },
        },
        category = "electromagnetics"
    },
    {
        type = "recipe",
        name = "rabbasca-reboot-stabilizer",
        enabled = true,
        hidden = true,
        hidden_in_factoriopedia = true,
        energy_required = 30,
        ingredients = { { type = "fluid", name = "fusion-plasma", amount = 200 } },
        results = { { type = "item", name = "rabbasca-reboot-stabilizer", amount = 1 } },
        category = "rabbasca-warp-stabilizer",
        result_is_always_fresh = true,
        auto_recycle = false, 
    },
    {
        type = "recipe",
        name = "rabbasca-holmium-filter",
        enabled = false,
        energy_required = 35,
        result_is_always_fresh = true,
        ingredients = {
            { type = "fluid", name = "sulfuric-acid", amount = 20 },
            { type = "fluid", name = "ammonia",       amount = 10 },
            { type = "item",  name = "lithium-plate", amount = 3 },
        },
        results = { { type = "item", name = "rabbasca-holmium-filter", amount = 1 } },
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
            { type = "item",  name = "rabbasca-holmium-filter", amount = 1 },
        },
        results = { 
            { type = "item", name = "rabbasca-holmium-filter", amount = 1, probability = 0.7 },
            { type = "fluid", name = "holmium-solution", amount = 10, },
        },
        category = "metallurgy"
    },
    {
        type = "recipe",
        name = "rabbasca-warp-matrix",
        enabled = false,
        main_product = "rabbasca-warp-matrix",
        energy_required = 25,
        result_is_always_fresh = true,
        preserve_products_in_machine_output = true,
        ingredients = {
            { type = "fluid", name = "fusion-plasma",  amount = 100 },
        },
        results = { { type = "item", name = "rabbasca-warp-matrix", amount = 20 } },
        category = "rabbasca-warp-stabilizer"
    },
    {
        type = "recipe",
        name = "rabbasca-coordinate-calibrations",
        enabled = false,
        energy_required = 5,
        ingredients = {
            { type = "item",  name = "rabbasca-warp-matrix", amount = 5 },
            { type = "fluid", name = "harene",  amount = 25 },
        },
        results = { { type = "item", name = "rabbasca-coordinate-calibrations", amount = 1 } },
        category = "rabbasca-warp-stabilizer"
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
        category = "rabbasca-warp-stabilizer"
    },
    {
        type = "recipe",
        name = "rabbasca-warp-core",
        enabled = false,
        main_product = "rabbasca-warp-core",
        energy_required = 25,
        ingredients = {
            { type = "item", name = "rabbasca-coordinate-calibrations", amount = 1 },
            { type = "item", name = "rabbasca-spatial-anchor",  amount = 1 },
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
    make_materialize_recipe("rabbasca-materialize-beta-carotene", data.raw["fluid"]["beta-carotene"].icon,
        { type = "fluid", name = "beta-carotene", amount = 100, },
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 5 }}),
    make_materialize_recipe("rabbasca-materialize-turbofish", data.raw["capsule"]["rabbasca-turbofish"].icon,
        { type = "item", name = "rabbasca-turbofish", amount = 1, },
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 5 }}),
    make_materialize_recipe("rabbasca-materialize-haronite", data.raw["item"]["haronite"].icon,
        { type = "item", name = "haronite", amount = 30, },
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 5 }}),
    make_materialize_recipe("rabbasca-materialize-yumako", data.raw["capsule"]["yumako"].icon,
        { type = "item", name = "yumako", amount = 15, },
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 10 }, { type = "fluid", name = "fusion-plasma", amount = 50 } }),
    make_materialize_recipe("rabbasca-materialize-coal", data.raw["item"]["coal"].icon,
        { type = "item", name = "coal", amount = 75, },
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 25 }, { type = "fluid", name = "fusion-plasma", amount = 50 } }),
    make_materialize_recipe("rabbasca-materialize-tungsten", data.raw["item"]["tungsten-ore"].icon,
        { type = "item", name = "tungsten-ore", amount = 30, },
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 25 }, { type = "fluid", name = "fusion-plasma", amount = 50 } }),
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