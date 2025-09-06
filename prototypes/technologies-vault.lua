data:extend{
{
    type = "technology",
    name = "rabbasca-ears-technology",
    icon = "__Krastorio2Assets__/icons/cards/matter-research-data.png",
    icon_size = 256,
    prerequisites = { "rabbasca-glob-technology" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-offering-harene-ears-core"
      },
    },
    ignore_tech_cost_multiplier = true,
    unit = {
        count = 100,
        time = 30,
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
        count = 50,
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
        time = 10,
        ingredients = {{"rabbascan-encrypted-vault-data", 1}}
    }
},
{
  type = "technology",
  name = "bunnyhop-engine",
  icon = "__base__/graphics/technology/engine.png",
  icon_size = 256,
  prerequisites = { "rabbasca-glob-technology", "rabbasca-ears-technology" },
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "bunnyhop-engine",
    },
    {
      type = "unlock-space-location",
      space_location = "nauvis",
      use_icon_overlay_constant = true
    }
  },
  unit = {
    count = 100,
    time = 30,
    ingredients = {{"rabbascan-encrypted-vault-data", 1}}
  }
},
{
    type = "technology",
    name = "item-duplication-1",
    icon = "__space-age__/graphics/technology/metallurgic-science-pack.png",
    icon_size = 256,
    prerequisites = { "rabbasca-glob-technology" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-iron-plate-duplication",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-steel-plate-duplication",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-electronic-circuit-duplication",
      },
    },
  unit = {
    count = 40,
    time = 10,
    ingredients = {{"rabbascan-encrypted-vault-data", 1}}
  }
},
{
    type = "technology",
    name = "item-duplication-2",
    icon = "__space-age__/graphics/technology/metallurgic-science-pack.png",
    icon_size = 256,
    prerequisites = { "item-duplication-1" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-infused-haronite-plate-duplication",
      },
    },
  unit = {
    count = 200,
    time = 30,
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