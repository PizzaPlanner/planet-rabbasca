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
    local lab = rutil.create_ears_variant(thing, "rabbasca-ears-technology-2")
    data.raw["lab"][lab].science_pack_drain_rate_percent = math.max(1, (data.raw["lab"][lab].science_pack_drain_rate_percent or 100) * 0.85)
  end
end
for _, thing in pairs(data.raw["beacon"]) do
  if thing.energy_source.type == "electric" then
    rutil.create_ears_variant(thing, "rabbasca-ears-technology-2", true)
  end
end
for _, thing in pairs(data.raw["rocket-silo"]) do
  if thing.rocket_entity == "rocket-silo-rocket" then
    local silo = rutil.create_ears_variant(thing, "rabbasca-ears-technology-3")
    data.raw["rocket-silo"][silo].rocket_entity = "rabbasca-rocket-silo-rocket"
    data.raw["rocket-silo"][silo].rocket_parts_required = 1
    data.raw["rocket-silo"][silo].fixed_recipe = "rocket-part-from-turbofuel"
    data.raw["rocket-silo"][silo].surface_conditions = {{property = "harenic-energy-signatures", min = 50}, {property = "pressure", min = 1}}
  end
end