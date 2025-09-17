

data:extend { 
{
    type = "technology",
    name = "planet-discovery-rabbasca",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "planet-discovery-gleba" },
    unit = {
        count = 1000,
        time = 60,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"space-science-pack", 1},
        }
    }
},
{
    type = "technology",
    name = "leg-day-everyday",
    icon = "__space-age__/graphics/technology/fish-breeding.png",
    icon_size = 256,
    prerequisites = { "planet-discovery-rabbasca" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-turbofin"
      },
      {
        type = "unlock-recipe",
        recipe = "protein-powder"
      },
      {
        type = "unlock-recipe",
        recipe = "harenic-sludge-skimming-fine"
      },
      {
        type = "unlock-recipe",
        recipe = "harenic-sludge-skimming-rough"
      },
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "rabbasca-turbofish",
    }
},
{
    type = "technology",
    name = "rabbasca-kickstart",
    icon = "__Krastorio2Assets__/icons/cards/utility-tech-card.png",
    icon_size = 256,
    prerequisites = { "planet-discovery-rabbasca" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-console-scrap-recycling"
      }
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "rabbascan-scrap"
    }
},
{
    type = "technology",
    name = "rabbascan-vault-accessibility",
    icon = "__Krastorio2Assets__/icons/cards/utility-tech-card.png",
    icon_size = 256,
    prerequisites = { "rabbasca-kickstart" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harene-copy-core"
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "blank-vault-key"
    }
},
{
    type = "technology",
    name = "harene-gas-processing",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "oil-gathering", "planet-discovery-rabbasca" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "chemical-plant"
      },
      {
        type = "unlock-recipe",
        recipe = "harene-enrichment-center"
      },
      {
        type = "unlock-recipe",
        recipe = "harenic-sludge-filtration"
      },
    },
    research_trigger =
    {
        type = "mine-entity",
        entity = "harene-vent"
    }
},
{
    type = "technology",
    name = "rabbasca-healthy-fluids",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "harene-gas-processing" },
    effects =
    {
      {
          type = "unlock-recipe",
          recipe = "beta-carotene"
      },
      {
        type = "unlock-recipe",
        recipe = "power-solution"
      },
    },
    research_trigger =
    {
      type = "craft-fluid",
      fluid = "energetic-residue",
      count = 10
    }
},
{
    type = "technology",
    name = "blank-vault-key",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "rabbascan-vault-accessibility", "rabbasca-healthy-fluids" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "blank-vault-key"
      }
    },
    research_trigger =
    {
      type = "craft-fluid",
      fluid = "beta-carotene",
      count = 10
    }
},
{
    type = "technology",
    name = "rabbasca-vault-core-extraction",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "blank-vault-key", "concrete" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harene-ears-core-protocol"
      }
    },
    research_trigger =
    {
      type = "craft-item",
      item = "rabbasca-energetic-concrete",
      count = 50
    }
},
{
    type = "technology",
    name = "rabbasca-ears-technology",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "rabbasca-vault-core-extraction" },
    effects =
    {

    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "harene-ears-core-capsule"
    }
},
{
    type = "technology",
    name = "ultranutritious-science-pack",
    icon = "__Krastorio2Assets__/icons/cards/matter-research-data.png",
    icon_size = 256,
    prerequisites = { "harene-gas-processing", "rabbasca-ears-technology" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "smart-solution"
      },
      {
        type = "unlock-recipe",
        recipe = "ultranutritious-science-pack"
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "power-solution"
    }
},
{
    type = "technology",
    name = "haronite-catalyst",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "ultranutritious-science-pack", "beta-carotene" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "haronite-catalyst"
      }
    },
    research_trigger =
    {
      type = "craft-item",
      item = "smart-solution"
    }
},
{
    type = "technology",
    name = "beta-carotene",
    icon = "__base__/graphics/technology/automation-science-pack.png",
    icon_size = 256,
    prerequisites = { "planet-discovery-rabbasca" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "beta-carotene",
      }
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "carotenoid"
    }
},
{
    type = "technology",
    name = "harene-infused-foundations",
    icon = "__space-age__/graphics/technology/foundation.png",
    icon_size = 256,
    prerequisites = { "foundation", "harene-synthesis" },
    unit = {
        count = 2000,
        time = 60,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"space-science-pack", 1},
        }
    },
    effects =
    {
    {
        type = "unlock-recipe",
        recipe = "harene-infused-foundation"
    },
      {
        type = "unlock-recipe",
        recipe = "harene-infused-space-platform"
      },
    },
},
}