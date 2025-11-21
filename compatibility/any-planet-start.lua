local utils = require("__any-planet-start__.utils")

utils.ignore_multiplier("gun-turret")
utils.ignore_multiplier("military")
utils.ignore_multiplier("electric-mining-drill")
utils.set_trigger("oil-processing", {
    type = "mine-entity",
    entity = "harene-vent"
})
utils.set_prerequisites("chemical-science-pack", { "engine", "rabbascan-vault-access", "energetic-residue" })
utils.add_prerequisites("rabbasca-healthy-fluids", { "oil-processing" })
utils.add_prerequisites("energetic-residue", { "oil-processing" })
utils.add_prerequisites("advanced-oil-processing", { "oil-processing" })
utils.add_prerequisites("machining-assembler", { "concrete" })
utils.add_prerequisites("rabbasca-haronite-processing", { "sulfur-processing" })

data:extend {
{
  type = "technology",
  name = "rabbasca-vault-early-hacking-efficiency-1",
  icon = "__Krastorio2Assets__/technologies/optimization-tech-card.png",
  icon_size = 256,
  prerequisites = { "logistic-science-pack", "rabbascan-vault-access" },
  effects = {
    {
      type = "change-recipe-productivity",
      recipe = "vault-protocol-iron-ore",
      change = 0.25
    },
    {
      type = "change-recipe-productivity",
      recipe = "vault-protocol-copper-ore",
      change = 0.25
    },
    {
      type = "change-recipe-productivity",
      recipe = "vault-protocol-sulfur",
      change = 0.25
    },
  },
  level = 1,
  unit = {
    time = 30,
    count_formula = "200",
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    }
  }
},
{
  type = "technology",
  name = "rabbasca-vault-early-hacking-efficiency-2",
  icon = "__Krastorio2Assets__/technologies/optimization-tech-card.png",
  icon_size = 256,
  prerequisites = { "chemical-science-pack", "rabbasca-vault-early-hacking-efficiency-1" },
  effects = {
    {
      type = "change-recipe-productivity",
      recipe = "vault-protocol-iron-ore",
      change = 0.25
    },
    {
      type = "change-recipe-productivity",
      recipe = "vault-protocol-copper-ore",
      change = 0.25
    },
    {
      type = "change-recipe-productivity",
      recipe = "vault-protocol-sulfur",
      change = 0.25
    }
  },
  level = 2,
  unit = {
    time = 30,
    count_formula = "400",
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    }
  }
},
}

utils.add_prerequisites("rabbasca-vault-hacking-efficiency", { "rabbasca-vault-early-hacking-efficiency-2" })
