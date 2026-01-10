data:extend{
{
    type = "technology",
    name = "rabbasca-underground",
    icon = "__rabbasca-assets__/graphics/recolor/technologies/rabbasca-big.png",
    icon_size = 256,
    prerequisites = { "interplanetary-construction-2", "fusion-reactor" },
    effects = {
      {
        type = "unlock-space-location",
        space_location = "rabbasca-underground",
        use_icon_overlay_constant = true
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-packaged-pylon"
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
    unit = {
        count = 1000,
        time = 60,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"athletic-science-pack", 1},
            {"metallurgic-science-pack", 1},
            {"promethium-science-pack", 1},
        }
    }
},
}