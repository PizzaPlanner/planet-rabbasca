require("prototypes.entities")
require("prototypes.resources")
require("prototypes.theplanet")
require("prototypes.recipes")
require("prototypes.items")
require("prototypes.map-gen")
require("prototypes.tiles")
require("prototypes.technologies")

if mods["any-planet-start"] then
    APS.add_planet{name = "rabbasca" , filename = "__planet-rabbasca__/any-planet-start"} --, technology = "planet-discovery-rabbasca"}
end