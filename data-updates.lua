local rutil = require("__planet-rabbasca__.util")

for _, thing in pairs(data.raw["solar-panel"]) do 
  rutil.not_on_harenic_surface(thing)
end
for _, thing in pairs(data.raw["burner-generator"]) do 
  rutil.not_on_harenic_surface(thing)
end
for _, thing in pairs(data.raw["generator"]) do 
  rutil.not_on_harenic_surface(thing)
end
for _, thing in pairs(data.raw["fusion-generator"]) do 
  rutil.not_on_harenic_surface(thing)
end
for _, thing in pairs(data.raw["accumulator"]) do 
  rutil.not_on_harenic_surface(thing)
end
for _, thing in pairs(data.raw["rocket-silo"]) do 
  rutil.not_on_harenic_surface(thing)
end

require("scripts.machine-assembly")
require("scripts.create-ears-variants")

require("compatibility.se-space-trains")
require("scripts.vanilla-changes")