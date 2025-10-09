local rutil = require("__planet-rabbasca__.util")

-- No electric poles on rabbasca. TODO? Does not apply to moshine rail connectors
for _, pole in pairs(data.raw["electric-pole"]) do 
  rutil.not_on_harenic_surface(pole)
end
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

for _, lab in pairs(data.raw["lab"]) do 
  if lab.inputs[1] == "automation-science-pack" then
    table.insert(lab.inputs, "ultranutritious-science-pack")
  end
end

for _, thing in pairs(data.raw["inserter"]) do
  if thing.name ~= "burner-inserter" then
    rutil.create_infused_mini(thing)
  end
end

rutil.create_infused_crafter("assembling-machine-2")
rutil.create_infused_crafter("assembling-machine-3")
rutil.create_infused_crafter("chemical-plant")
rutil.create_infused_crafter("oil-refinery")
rutil.create_infused_crafter("foundry")
rutil.create_infused_crafter("electromagnetic-plant")
rutil.create_infused_crafter("cryogenic-plant")
rutil.create_infused_crafter("lab")
rutil.create_infused_crafter("biolab")
rutil.create_infused_crafter("machining-assembler")

