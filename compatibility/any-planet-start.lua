local utils = require("__any-planet-start__.utils")

-- earlier/easier
-- utils.add_recipes("steam-power", { "inserter", "lab" })
-- utils.set_prerequisites("automation-science-pack", {"steam-power"})
utils.set_prerequisites("chemical-science-pack", {"harene-gas-processing", "engine"})
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