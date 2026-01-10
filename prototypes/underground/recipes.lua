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
}

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
      { type = "item", name = "harene-infused-small-lamp", amount = 4 },
  },
  results = { 
      { type = "item", name = "rabbasca-packaged-pylon", amount = 1 },
  },
  energy_required = 40,
  allow_productivity = false,
})