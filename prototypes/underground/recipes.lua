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
    }
end
data:extend {
    {
        type = "recipe-category",
        name = "rabbasca-warp-stabilizer",
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
            { type = "fluid", name = "fluorine", amount = 80 }, 
            { type = "fluid", name = "sulfuric-acid", amount = 20 },
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
        energy_required = 8,
        ingredients = {
            { type = "item", name = "rabbasca-lithium-amide", amount = 10 },
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
        energy_required = 1, -- Very slow due to no energy available at start
        ingredients = { { type = "fluid", name = "fluoroketone-cold", amount = 1000 } },
        results = { { type = "item", name = "rabbasca-reboot-stabilizer", amount = 1 } },
        category = "rabbasca-warp-stabilizer",
        result_is_always_fresh = true,
        auto_recycle = false, 
    },
    {
        type = "recipe",
        name = "rabbasca-warp-matrix",
        enabled = false,
        main_product = "rabbasca-warp-matrix",
        energy_required = 25,
        ingredients = {
            { type = "fluid", name = "fluorine", amount = 25 },
            { type = "fluid", name = "harenic-lava", amount = 50 },
        },
        results = { { type = "item", name = "rabbasca-warp-matrix", amount = 100 } },
        category = "rabbasca-warp-stabilizer"
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
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 10 }}),
    make_materialize_recipe("rabbasca-materialize-coal", data.raw["item"]["coal"].icon,
        { type = "item", name = "coal", amount = 75, },
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 25 }}),
    make_materialize_recipe("rabbasca-materialize-holmium", data.raw["fluid"]["holmium-solution"].icon,
        { type = "fluid", name = "holmium-solution", amount = 100, },
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 25 }}),
    make_materialize_recipe("rabbasca-materialize-tungsten", data.raw["item"]["tungsten-ore"].icon,
        { type = "item", name = "tungsten-ore", amount = 30, },
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 25 }}),
    
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