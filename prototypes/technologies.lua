

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
    name = "harene-processing",
    icon = "__space-age__/graphics/technology/steel-plate-productivity.png",
    icon_size = 256,
    prerequisites = { "transmutation-technology", "leg-day-everyday" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "infused-haronite-plate"
      },
      {
        type = "unlock-recipe",
        recipe = "harene-infused-moonstone"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-turbofish"
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "smart-solution",
      amount = "50"
    }
},
{
    type = "technology",
    name = "ears-core-technology",
    icon = "__space-age__/graphics/technology/fusion-reactor.png",
    icon_size = 256,
    prerequisites = { "rabbascan-lost-technologies" },
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
      {
        type = "unlock-recipe",
        recipe = "energetic-residue"
      },
      {
        type = "unlock-recipe",
        recipe = "beta-carotene"
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "harene-ears-core",
      count = 2
    }
},
{
    type = "technology",
    name = "infused-haronite-plate",
    icon = "__space-age__/graphics/technology/steel-plate-productivity.png",
    icon_size = 256,
    prerequisites = { "harene-processing" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harene-extractor-recycling"
      },
      {
        type = "unlock-recipe",
        recipe = "harene-extractor"
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "infused-haronite-plate",
      amount = "50"
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
        recipe = "rabbascan-security-key"
      },
      {
        type = "unlock-recipe",
        recipe = "protein-powder"
      },
      {
        type = "unlock-recipe",
        recipe = "smart-solution"
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
    name = "ultranutritious-science-pack",
    icon = "__space-age__/graphics/technology/metallurgic-science-pack.png",
    icon_size = 256,
    prerequisites = { "harene-processing" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "ultranutritious-science-pack"
      }
    },
    research_trigger =
    {
      type = "craft-item",
      item = "infused-haronite-plate"
    }
},
{
    type = "technology",
    name = "prison-break",
    icon = "__space-age__/graphics/technology/metallurgic-science-pack.png",
    icon_size = 256,
    prerequisites = { "ultranutritious-science-pack", "infused-haronite-plate" },
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
    research_trigger =
    {
      type = "craft-item",
      item = "ultranutritious-science-pack",
      amount = "100"
    }
},
{
    type = "technology",
    name = "rabbascan-vault-accessibility",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "planet-discovery-rabbasca" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbascan-security-key"
      },
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "rabbasca-infused-moonstone-rock"
    }
},
{
    type = "technology",
    name = "rabbascan-lost-technologies",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "rabbascan-vault-accessibility" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-offering-harene-ears-core"
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "rabbascan-security-key"
    }
},
{
    type = "technology",
    name = "energetic-enrichment",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "ears-core-technology" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "haronite"
      }
    },
    research_trigger =
    {
      type = "craft-fluid",
      fluid = "beta-carotene"
    }
},
{
    type = "technology",
    name = "transmutation-technology",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "ears-core-technology" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harene-transmuter-recycling"
      },
      {
        type = "unlock-recipe",
        recipe = "harene-transmuter"
      },
      -- {
      --   type = "unlock-recipe",
      --   recipe = "haronite-plate"
      -- },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "moonstone-pipe"
    }
},
{
    type = "technology",
    name = "moonstone-glob-technology",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "planet-discovery-rabbasca" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "moonstone-chest"
      },
      {
        type = "unlock-recipe",
        recipe = "moonstone-chest-recycling"
      },
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "moonstone-chest"
    }
},
{
    type = "technology",
    name = "harene-infused-foundations",
    icon = "__space-age__/graphics/technology/foundation.png",
    icon_size = 256,
    prerequisites = { "foundation", "planet-discovery-rabbasca" },
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
}
}