require("api")

require("prototypes.items")
require("prototypes.units-vault")
require("prototypes.entities")
require("prototypes.entities-vault")
require("prototypes.resources")
require("prototypes.surfaces")
require("prototypes.map-gen")
require("prototypes.tiles")
require("prototypes.remote")
require("prototypes.recipes")
require("prototypes.technologies")
require("prototypes.equipment")
require("prototypes.trains")
require("prototypes.tips-and-tricks")

if mods["any-planet-start"] then
    APS.add_planet{
        name = "rabbasca" , 
        filename = "__planet-rabbasca__/compatibility/any-planet-start", 
        fixes_filename = "__planet-rabbasca__/compatibility/any-planet-start-final-fixes", 
        technology = "planet-discovery-rabbasca"
    }
end
require("compatibility.canal-excavator")