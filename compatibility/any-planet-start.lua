local utils = require("__any-planet-start__.utils")

utils.ignore_multiplier("gun-turret")
utils.ignore_multiplier("military")
utils.set_trigger("oil-processing", {
    type = "mine-entity",
    entity = "harene-vent"
})
utils.remove_packs("planet-discovery-gleba", {"space-science-pack"})
