local rutil = require("__planet-rabbasca__.util")
for _, thing in pairs(data.raw["inserter"]) do
  if thing.energy_source.type == "electric" then
    rutil.create_ears_variant(thing, "rabbasca-ears-technology-1", true)
  end
end
for _, thing in pairs(data.raw["assembling-machine"]) do
  if thing.energy_source.type == "electric" then
    rutil.create_ears_variant(thing, "rabbasca-ears-technology-1")
  end
end
for _, thing in pairs(data.raw["furnace"]) do
  if thing.energy_source.type == "electric" then
    rutil.create_ears_variant(thing, "rabbasca-ears-technology-1")
  end
end
for _, thing in pairs(data.raw["lab"]) do
  if thing.energy_source.type == "electric" then
    rutil.create_ears_variant(thing, "rabbasca-ears-technology-labs-2")
  end
end
for _, thing in pairs(data.raw["beacon"]) do
  if thing.energy_source.type == "electric" then
    rutil.create_ears_variant(thing, "rabbasca-ears-technology-labs-2", true)
  end
end