require("prototypes.units-vault")
require("prototypes.entities")
require("prototypes.entities-vault")
require("prototypes.resources")
require("prototypes.theplanet")
require("prototypes.items")
require("prototypes.recipes")
require("prototypes.map-gen")
require("prototypes.tiles")
require("prototypes.technologies")
require("prototypes.technologies-vault")

if mods["any-planet-start"] then
    APS.add_planet{name = "rabbasca" , filename = "__planet-rabbasca__/any-planet-start"} --, technology = "planet-discovery-rabbasca"}
end