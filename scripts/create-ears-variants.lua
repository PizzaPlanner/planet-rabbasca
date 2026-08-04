data:extend {
  {
    type = "item-subgroup",
    name = "unknown-with-ears-core" ,
    group = data.raw["item-group"]["rabbasca-extensions"] and "rabbasca-extensions" or "production",
    order = "zz[unknown]"
  }
}

local costs = {
  {
    { type = "item", name = nil, amount = 1 }, -- replaced with self
    { type = "item", name = "harene-ears-subcore", amount = 1 },
    { type = "fluid", name = "harene-gas", amount = 3 },
  },
  {
    { type = "item", name = nil, amount = 1 }, -- replaced with self
    { type = "item", name = "harene-ears-core", amount = 1 },
    { type = "fluid", name = "harene-gas", amount = 50 },
  },
  {
    { type = "item", name = nil, amount = 1 }, -- replaced with self
    { type = "item", name = "harene-ears-core", amount = 2 },
    { type = "fluid", name = "harene", amount = 5 },
  }
}

local high_energy_threshold = util.parse_energy(Rabbasca.high_energy_device_threshold())
local max_energy_threshold = util.parse_energy(Rabbasca.max_energy_device_threshold())

local devices = {["skipped"] = {}, ["too_expensive"] = {}, ["low"] = {}, ["medium"] = {}, ["high"] = {} }
local function create_variant_by_threshold(thing, low, high, max)
  if thing.energy_source.type ~= "electric" then return end
  local energy = util.parse_energy(thing.energy_usage or thing.energy_per_rotaion or thing.energy_per_movement or "100GW")
  local setting = (energy > max_energy_threshold and max and { tech = max.tech, cost = max.cost, level = "high" })
              or (energy <= max_energy_threshold and energy > high_energy_threshold and high and { tech = high.tech, cost = high.cost, level = "medium" })
              or (energy <= high_energy_threshold and low and { tech = low.tech, cost = low.cost, level = "low" })
              or { tech = nil, cost = nil, level = "too_expensive" } -- still create but hide for migration purposes
  local variant = Rabbasca.create_ears_variant(thing, setting.tech and "rabbasca-ears-technology-"..setting.tech, costs[setting.cost])
  if variant then 
    table.insert(devices[setting.level], thing.name)
    return variant
  else
    table.insert(devices["skipped"], thing.name)
  end
end

-- set prototype.no_ears_upgrade = true or prototype.hidden = true to skip ears variant creation

for _, thing in pairs(data.raw["inserter"]) do
  create_variant_by_threshold(thing, { tech = 2, cost = 1 }, { tech = 3, cost = 3 }, nil)
end
for _, thing in pairs(data.raw["assembling-machine"]) do
  create_variant_by_threshold(thing, { tech = 1, cost = 2 }, { tech = 3, cost = 3 }, nil)
end
for _, thing in pairs(data.raw["furnace"]) do
  create_variant_by_threshold(thing, { tech = 1, cost = 2 }, { tech = 3, cost = 3 }, nil)
end
for _, thing in pairs(data.raw["lab"]) do
  local lab = create_variant_by_threshold(thing, { tech = 2, cost = 2 }, { tech = 3, cost = 3 }, nil)
  if lab then
    data.raw["lab"][lab].science_pack_drain_rate_percent = math.max(1, (data.raw["lab"][lab].science_pack_drain_rate_percent or 100) * 0.85)
  end
end
for _, thing in pairs(data.raw["beacon"]) do
  create_variant_by_threshold(thing, { tech = 2, cost = 2 }, { tech = 3, cost = 3 }, nil)
end
for _, thing in pairs(data.raw["rocket-silo"]) do
  if thing.rocket_entity == "rocket-silo-rocket" then
    local silo = create_variant_by_threshold(thing, { tech = 3, cost = 3 }, { tech = 3, cost = 3 }, nil)
    if silo then
      local entity = data.raw["rocket-silo"][silo]
      entity.rocket_entity = "rabbasca-rocket-silo-rocket"
    end
  end
end

log("EARS variants: "..serpent.line(devices))
