data:extend{
{
    type = "technology",
    name = "harene-synthesis",
    icon = "__space-age__/graphics/technology/steel-plate-productivity.png",
    icon_size = 256,
    prerequisites = { "haronite-catalyst", "foundry" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harene"
      },
      {
        type = "unlock-recipe",
        recipe = "infused-haronite-plate"
      },
    },
    unit = {
        count = 100,
        time = 10,
        ingredients = {{"automation-science-pack", 1}}
    }
},
{
    type = "technology",
    name = "rabbasca-glob-technology",
    icon = "__Krastorio2Assets__/icons/cards/matter-research-data.png",
    icon_size = 256,
    prerequisites = { "ultranutritious-science-pack" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harene-glob-core"
      },
    },
    unit = {
        count = 1000,
        time = 30,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"space-science-pack", 1},
          {"metallurgic-science-pack", 1},
          {"agricultural-science-pack", 1},
          {"electromagnetic-science-pack", 1},
          {"ultranutritious-science-pack", 1},
        }
    }
},
{
    type = "technology",
    name = "rabbasca-copy-technology",
    icon = "__Krastorio2Assets__/icons/cards/matter-research-data.png",
    icon_size = 256,
    prerequisites = { "rabbascan-vault-accessibility" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harene-copy-core"
      },
    },
    ignore_tech_cost_multiplier = true,
    unit = {
        count = 10,
        time = 5,
        ingredients = {{"automation-science-pack", 1}}
    }
},
{
  type = "technology",
  name = "bunnyhop-engine",
  icon = "__base__/graphics/technology/engine.png",
  icon_size = 256,
  prerequisites = { "rabbasca-ears-technology", "chemical-science-pack" },
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "bunnyhop-engine",
    },
    {
      type = "unlock-recipe",
      recipe = "space-science-pack",
    },
  },
  unit = {
    count = 500,
    time = 30,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    }
  }
},
{
    type = "technology",
    name = "rabbasca-global-chest",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "ultranutritious-science-pack", "space-science-pack" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "moonstone-chest"
      },
    },
    unit = {
      count = 2000,
      time = 30,
      ingredients = {
        {"space-science-pack", 1},
        {"ultranutritious-science-pack", 1},
      }
    }
},
{
    type = "technology",
    name = "item-duplication-1",
    icon = "__space-age__/graphics/technology/metallurgic-science-pack.png",
    icon_size = 256,
    prerequisites = { "rabbascan-vault-accessibility" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-iron-plate-duplicate",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-electronic-circuit-duplicate",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-rabbasca-carotene-powder-duplicate",
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "harene-copy-core",
      count = 1,
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
        recipe = "rabbasca-steel-plate-duplicate",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-advanced-circuit-duplicate",
      },
    },
      research_trigger =
    {
      type = "craft-item",
      item = "harene-copy-core",
      count = 50,
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
--         recipe = "iron-plate"
--       },
--       {
--         type = "unlock-recipe",
--         recipe = "copper-plate"
--       },
--     },
--     ignore_tech_cost_multiplier = true,
--     unit = {
--         count = 5,
--         time = 10,
--         ingredients = {{"automation-science-pack", 1}}
--     }
-- },
}