data:extend {
  {
    type = "item-subgroup",
    name = "unknown-with-ears-core" ,
    group = data.raw["item-group"]["rabbasca-extensions"] and "rabbasca-extensions" or "production",
    order = "zz[unknown]"
  }
}

-- set prototype.no_ears_upgrade = true or prototype.hidden = true to skip ears variant creation

for _, thing in pairs(data.raw["inserter"]) do
  if thing.energy_source.type == "electric" then
    Rabbasca.create_ears_variant(thing, "rabbasca-ears-technology-2", true)
  end
end
for _, thing in pairs(data.raw["assembling-machine"]) do
  if thing.energy_source.type == "electric" then
    Rabbasca.create_ears_variant(thing, "rabbasca-ears-technology-1")
  end
end
for _, thing in pairs(data.raw["furnace"]) do
  if thing.energy_source.type == "electric" then
    Rabbasca.create_ears_variant(thing, "rabbasca-ears-technology-1")
  end
end
for _, thing in pairs(data.raw["lab"]) do
  if thing.energy_source.type == "electric" then
    local lab = Rabbasca.create_ears_variant(thing, "rabbasca-ears-technology-2")
    if lab then
      data.raw["lab"][lab].science_pack_drain_rate_percent = math.max(1, (data.raw["lab"][lab].science_pack_drain_rate_percent or 100) * 0.85)
    end
  end
end
for _, thing in pairs(data.raw["beacon"]) do
  if thing.energy_source.type == "electric" then
    Rabbasca.create_ears_variant(thing, "rabbasca-ears-technology-2", true)
  end
end
for _, thing in pairs(data.raw["rocket-silo"]) do
  if thing.rocket_entity == "rocket-silo-rocket" then
    local silo = Rabbasca.create_ears_variant(thing, "rabbasca-ears-technology-3")
    if silo then
      local entity = data.raw["rocket-silo"][silo]
      entity.rocket_entity = "rabbasca-rocket-silo-rocket"
      entity.to_be_inserted_to_rocket_inventory_size = entity.to_be_inserted_to_rocket_inventory_size * 2
    end
  end
end