data:extend{
{
    type = "technology",
    name = "rabbasca-ears-technology",
    icon = "__Krastorio2Assets__/icons/cards/matter-research-data.png",
    icon_size = 256,
    prerequisites = { "rabbascan-lost-technologies" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-offering-harene-ears-core"
      },
    },
    ignore_tech_cost_multiplier = true,
    unit = {
        count = 5,
        time = 20,
        ingredients = {{"rabbascan-encrypted-vault-data", 1}}
    }
},
{
    type = "technology",
    name = "rabbasca-vault-simple-transmutation",
    icon = "__Krastorio2Assets__/icons/cards/matter-research-data.png",
    icon_size = 256,
    prerequisites = { "rabbasca-ears-technology" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harenic-chemical-plant-recycling"
      },
      {
        type = "unlock-recipe",
        recipe = "harenic-chemical-plant",
      },
    },
    ignore_tech_cost_multiplier = true,
    unit = {
        count = 5,
        time = 20,
        ingredients = {{"rabbascan-encrypted-vault-data", 1}}
    }
},
{
    type = "technology",
    name = "rabbasca-glob-technology",
    icon = "__Krastorio2Assets__/icons/cards/matter-research-data.png",
    icon_size = 256,
    prerequisites = { "rabbascan-lost-technologies" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-offering-harene-glob-core"
      },
    },
    ignore_tech_cost_multiplier = true,
    unit = {
        count = 5,
        time = 20,
        ingredients = {{"rabbascan-encrypted-vault-data", 1}}
    }
},
-- {
--     type = "technology",
--     name = "rabbasca-vault-defensive-care-package",
--     icon = "__Krastorio2Assets__/icons/cards/matter-research-data.png",
--     icon_size = 256,
--     prerequisites = { "rabbascan-lost-technologies" },
--     effects =
--     {
--       {
--         type = "unlock-recipe",
--         recipe = "rabbasca-offering-iron-plate"
--       },
--       {
--         type = "unlock-recipe",
--         recipe = "rabbasca-offering-copper-plate"
--       },
--     },
--     ignore_tech_cost_multiplier = true,
--     unit = {
--         count = 5,
--         time = 10,
--         ingredients = {{"rabbascan-encrypted-vault-data", 1}}
--     }
-- },
}