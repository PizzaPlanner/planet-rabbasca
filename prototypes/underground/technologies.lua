data:extend{
{
    type = "technology",
    name = "rabbasca-underground-preparations",
    icon = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-icon.png",
    icon_size = 640,
    prerequisites = { "interplanetary-construction-2", "rabbasca-ears-technology-2", "fusion-reactor", "harene-synthesis" },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-locate-stabilizer"
      },
      {
        type = "unlock-space-location",
        space_location = "rabbasca-underground",
        use_icon_overlay_constant = true
      },
    },
    unit = {
      time = 60,
      count = 100,
      ingredients = {
        {"metallurgic-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"athletic-science-pack", 1},
        {"cryogenic-science-pack", 1},
      }
    }
},
{
    type = "technology",
    name = "rabbasca-underground",
    icon = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-icon.png",
    icon_size = 640,
    prerequisites = { "rabbasca-underground-preparations" },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-perfluorosulfonic-acid-from-atmosphere"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-petroleum-gas-from-atmosphere"
      },
    },
    research_trigger =
    {
      type = "scripted",
      trigger_description = { "rabbasca-extra.trigger-locate-underground" }
    }
},
{
    type = "technology",
    name = "rabbasca-perfluorosulfonic-acid",
    icon = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-icon.png",
    icon_size = 640,
    prerequisites = { "rabbasca-underground" },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-decompose-perfluorosulfonic-acid"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-iron-from-harenic-lava"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-copper-from-harenic-lava"
      },
    },
    research_trigger =
    {
      type = "craft-fluid",
      fluid = "rabbasca-perfluorosulfonic-acid",
      count = 100,
    }
},
{
    type = "technology",
    name = "rabbasca-lithium-amide",
    icon = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-icon.png",
    icon_size = 640,
    prerequisites = { "rabbasca-underground" },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-lithium-amide-fission"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-perfluorosulfonic-filter"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-holmium-from-harenic-lava"
      },
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "rabbasca-lithium-amide",
    }
},
{
    type = "technology",
    name = "rabbasca-warp-stabilizer",
    icon = "__rabbasca-assets__/graphics/by-openai/warp-matrix.png",
    icon_size = 246,
    prerequisites = { "rabbasca-perfluorosulfonic-acid", "rabbasca-lithium-amide" },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-warp-matrix"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-warp-tech-analyzer"
      },
    },
    research_trigger =
    {
        type = "craft-item",
        item = "rabbasca-reboot-stabilizer",
        count = 1
    }
},
{
    type = "technology",
    name = "rabbasca-warp-technology-analysis",
    icon = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-icon.png",
    icon_size = 640,
    prerequisites = { "rabbasca-warp-stabilizer" },
    effects = {

    },
    ignore_tech_cost_multiplier = true,
    order = "r[warp-tech]-0[analysis]",
    unit = {
      time = 10,
      count = 100,
      ingredients = {
        { "rabbasca-warp-matrix", 1 },
        { "rabbasca-spatial-anchor", 1 },
        { "rabbasca-coordinate-calibrations", 1 },
        { "rabbasca-spacetime-evolutionizer", 1 },
      }
    }
},
{
    type = "technology",
    name = "rabbasca-self-made-warp-pylon",
    icon = "__rabbasca-assets__/graphics/by-hurricane/conduit-icon-big.png",
    icon_size = 640,
    prerequisites = { "rabbasca-warp-technology-analysis" },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-warp-core"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-warp-pylon"
      },
    },
    ignore_tech_cost_multiplier = true,
    unit = {
      time = 10,
      count = 1000,
      ingredients = {
        { "rabbasca-warp-matrix", 1 },
        { "rabbasca-spatial-anchor", 1 },
        { "rabbasca-coordinate-calibrations", 1 },
        { "rabbasca-spacetime-evolutionizer", 1 },
      }
    }
},
{
    type = "technology",
    name = "interplanetary-construction-3",
    icon = "__rabbasca-assets__/graphics/by-hurricane/conduit-icon-big.png",
    icon_size = 640,
    prerequisites = { "rabbasca-self-made-warp-pylon" },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-warp-sequence-module",
      },
      {
        type = "nothing", -- needed as the recipe must be hidden to prevent manual selection
        icons = data.raw["recipe"]["rabbasca-warp-sequence-module"].icons,
        effect_description = { "recipe-description.rabbasca-warp-sequence-module" }
      },
    },
    ignore_tech_cost_multiplier = true,
    level = 3,
    unit = {
      time = 10,
      count = 3000,
      ingredients = {
        { "rabbasca-warp-matrix", 1 },
        { "rabbasca-spatial-anchor", 1 },
        { "rabbasca-coordinate-calibrations", 1 },
        { "rabbasca-spacetime-evolutionizer", 1 },
      }
    }
},
{
    type = "technology",
    name = "rabbasca-unrestricted-warp-pad",
    icon = data.raw["technology"]["space-platform"].icon,
    icon_size = data.raw["technology"]["space-platform"].icon_size,
    prerequisites = { "rabbasca-warp-technology-analysis" },
    effects = {
    },
    ignore_tech_cost_multiplier = true,
    unit = {
      time = 10,
      count = 1000,
      ingredients = {
        { "rabbasca-warp-matrix", 1 },
        { "rabbasca-spatial-anchor", 1 },
        { "rabbasca-coordinate-calibrations", 1 },
        { "rabbasca-spacetime-evolutionizer", 1 },
      }
    }
},
}