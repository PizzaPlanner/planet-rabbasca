table.insert(data.raw["technology"]["interplanetary-construction-2"].effects, {
  type = "unlock-recipe",
  recipe = "rabbasca-locate-stabilizer"
})

data:extend{
{
    type = "technology",
    name = "rabbasca-underground",
    icon = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-icon.png",
    icon_size = 640,
    prerequisites = { "interplanetary-construction-2", "fusion-reactor" },
    effects = {
      {
        type = "unlock-space-location",
        space_location = "rabbasca-underground",
        use_icon_overlay_constant = true
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-perfluorosulfonic-acid-from-atmosphere"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-petroleum-gas-from-atmosphere"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-decompose-perfluorosulfonic-acid"
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
        recipe = "rabbasca-lithium-amide-fission"
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
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "rabbasca-lithium-amide",
    }
},
{
    type = "technology",
    name = "rabbasca-resource-materialization-1",
    icon = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-icon.png",
    icon_size = 640,
    prerequisites = { "rabbasca-perfluorosulfonic-acid", "rabbasca-lithium-amide" },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-warp-matrix"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-materialize-haronite"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-materialize-beta-carotene"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-materialize-turbofish"
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
    name = "rabbasca-resource-materialization-2",
    icon = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-icon.png",
    icon_size = 640,
    prerequisites = { "rabbasca-resource-materialization-1" },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-materialize-coal"
      },

      {
        type = "unlock-recipe",
        recipe = "rabbasca-materialize-yumako"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-materialize-holmium"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-materialize-tungsten"
      },
    },
    research_trigger =
    {
        type = "craft-item",
        item = "rabbasca-warp-matrix",
        count = 100
    }
},
}