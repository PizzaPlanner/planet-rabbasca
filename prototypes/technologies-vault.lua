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
    unit = {
        count = 100,
        time = 10,
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
    unit = {
        count = 100,
        time = 10,
        ingredients = {{"rabbascan-encrypted-vault-data", 1}}
    }
},
{
    type = "technology",
    name = "rabbasca-copy-technology",
    icon = "__Krastorio2Assets__/icons/cards/matter-research-data.png",
    icon_size = 256,
    prerequisites = { "rabbascan-lost-technologies" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-offering-harene-copy-core"
      },
    },
    ignore_tech_cost_multiplier = true,
    unit = {
        count = 10,
        time = 5,
        ingredients = {{"rabbascan-encrypted-vault-data", 1}}
    }
},
{
    type = "technology",
    name = "rabbascan-security-key-p",
    icon = "__Krastorio2Assets__/icons/cards/production-tech-card.png",
    icon_size = 256,
    prerequisites = { "rabbascan-lost-technologies" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbascan-security-key-p"
      },
    },
    ignore_tech_cost_multiplier = true,
    unit = {
        count = 20,
        time = 5,
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
    name = "rabbasca-global-chest",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "rabbasca-glob-technology" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "moonstone-chest"
      },
    },
    unit = {
      count = 30,
      time = 15,
      ingredients = {{"rabbascan-encrypted-vault-data", 1}}
    }
},
{
    type = "technology",
    name = "item-duplication-1",
    icon = "__space-age__/graphics/technology/metallurgic-science-pack.png",
    icon_size = 256,
    prerequisites = { "rabbasca-copy-technology" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-iron-plate-duplication",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-electronic-circuit-duplication",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-rabbasca-carotene-powder-duplication",
      },
    },
  ignore_multiplier = true,
  unit = {
    count = 25,
    time = 5,
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
        recipe = "rabbasca-steel-plate-duplication",
      },
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