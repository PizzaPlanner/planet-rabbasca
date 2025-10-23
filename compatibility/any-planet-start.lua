local utils = require("__any-planet-start__.utils")

data:extend {
    {
        type = "recipe",
        name = "rabbasca-automation-science-pack",
        icons = {
            { icon = "__space-age__/graphics/icons/bioflux.png", scale = 0.4, shift = { 12, -12 } },
            { icon = "__base__/graphics/icons/automation-science-pack.png", scale = 0.5 },
        },
        enabled = false,
        energy_required = 10,
        ingredients = { 
            {type = "item", name = "rabbasca-carotene-powder", amount = 10 },
            {type = "item", name = "iron-gear-wheel", amount = 1 },
        },
        results = { { type = "item", name = "automation-science-pack", amount = 2 } },
        main_product = "automation-science-pack",
        category = "crafting",
        subgroup = data.raw["tool"]["automation-science-pack"].subgroup,
        order = "z[any-planet-start]-r[rabbasca-automation-science-pack]",
    },
    {
        type = "recipe",
        name = "rabbasca-chemical-science-pack",
        enabled = false,
        energy_required = 12,
        icons = {
            { icon = "__space-age__/graphics/icons/bioflux.png", scale = 0.4, shift = { 12, -12 } },
            { icon = "__base__/graphics/icons/chemical-science-pack.png", scale = 0.5 },
        },
        enabled = false,
        ingredients = { 
            { type = "item", name = "power-solution", amount = 1 },
            { type = "item", name = "vision-circuit", amount = 2 }, 
            { type = "item", name = "engine-unit", amount = 1 }, 
        },
        results = { { type = "item", name = "chemical-science-pack", amount = 1 } },
        category = "crafting",
        subgroup = data.raw["tool"]["chemical-science-pack"].subgroup,
        order = "z[any-planet-start]-r[rabbasca-chemical-science-pack]",
    },
}

-- earlier/easier
-- utils.add_recipes("steam-power", { "inserter", "lab" })
-- utils.set_prerequisites("automation-science-pack", {"steam-power"})
utils.set_trigger("electronics", {
    type = "craft-item",
    item = "electronic-circuit",
    count = 20
})
utils.set_prerequisites("chemical-science-pack", {"harene-gas-processing", "engine", "item-duplication-2"})
utils.add_recipes("automation-science-pack", { "rabbasca-automation-science-pack" })
utils.add_recipes("chemical-science-pack", { "rabbasca-chemical-science-pack" })
-- utils.remove_tech("automation-2", false, true)
-- utils.add_recipes("automation", { "assembling-machine-2" })
utils.set_prerequisites("oil-gathering", {"steel-processing", "logistic-science-pack"})
utils.ignore_multiplier("oil-gathering")
utils.ignore_multiplier("steel-processing")
utils.ignore_multiplier("logistic-science-pack")
utils.ignore_multiplier("gun-turret")
utils.ignore_multiplier("military")
utils.set_trigger("oil-processing", {
    type = "mine-entity",
    entity = "harene-vent"
})
utils.remove_packs("planet-discovery-gleba", {"space-science-pack"})

-- delayed/unavailable
utils.add_prerequisites("oil-processing", {"fluid-handling"})
-- utils.add_prerequisites("solar-energy", {"planet-discovery-gleba"})
-- utils.add_prerequisites("electric-energy-distribution-1", {"planet-discovery-gleba"})
log("applied any-planet-start changes")