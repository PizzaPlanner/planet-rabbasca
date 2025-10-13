local rutil = require("__planet-rabbasca__.util")

-- for _, pole in pairs(data.raw["electric-pole"]) do 
--   rutil.not_on_harenic_surface(pole)
-- end
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

-- Add complex machinery to machining-assembler
for _, thing in pairs(data.raw["assembling-machine"]) do
  rutil.make_complex_machinery(thing)
end
for _, thing in pairs(data.raw["furnace"]) do
  rutil.make_complex_machinery(thing)
end
for _, thing in pairs(data.raw["lab"]) do
  rutil.make_complex_machinery(thing)
end
for _, thing in pairs(data.raw["rocket-silo"]) do
  rutil.make_complex_machinery(thing)
end
for _, thing in pairs(data.raw["roboport"]) do
  rutil.make_complex_machinery(thing)
end
for _, thing in pairs(data.raw["inserter"]) do
  rutil.make_complex_machinery(thing)
end
for _, thing in pairs(data.raw["mining-drill"]) do
  rutil.make_complex_machinery(thing)
end
for _, thing in pairs(data.raw["cargo-bay"]) do
  rutil.make_complex_machinery(thing)
end
for _, thing in pairs(data.raw["cargo-landing-pad"]) do
  rutil.make_complex_machinery(thing)
end
for _, thing in pairs(data.raw["asteroid-collector"]) do
  rutil.make_complex_machinery(thing)
end
for _, thing in pairs(data.raw["thruster"]) do
  rutil.make_complex_machinery(thing)
end
for _, thing in pairs(data.raw["space-platform-starter-pack"]) do
  rutil.make_complex_machinery(thing)
end
rutil.make_complex_machinery(data.raw["item"]["space-platform-foundation"])

require("scripts.create-ears-variants")

require("compat.se-space-trains")