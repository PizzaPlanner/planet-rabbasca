
local bunnyhop_engine = data.raw["item"]["bunnyhop-engine-equipment"]
local warp_pylon = data.raw["assembling-machine"]["rabbasca-warp-pylon"]
local console = data.raw["furnace"]["rabbasca-vault-console"]
console.result_inventory_size = 0 -- castra compatibility; not required but looks nicer
console.crafting_speed_quality_multiplier = { }
for _, quality in pairs(data.raw["quality"]) do
  local multiplier = quality.default_multiplier or 1 + 0.3 * quality.level
  local big_multiplier = quality.default_multiplier or 1 + 0.5 * quality.level
  console.crafting_speed_quality_multiplier[quality.name] = 1
  bunnyhop_engine.custom_tooltip_fields[1].quality_values[quality.name] = {"tooltip-value.bunnyhop-engine-weight-multiplier", tostring(multiplier * 100)}
  warp_pylon.custom_tooltip_fields[1].quality_values[quality.name] = {"tooltip-value.rabbasca-warp-pylon-range", tostring(big_multiplier * Rabbasca.warp_radius)}
end

local vault_core = data.raw["unit-spawner"]["rabbasca-vault-meltdown"]
for _, damage in pairs(data.raw["damage-type"]) do
  table.insert(vault_core.resistances, { type = damage.name, percent = 100 })
end

require("__planet-rabbasca__.compatibility.muluna-final-fixes")
require("__planet-rabbasca__.compatibility.pelagos-final-fixes")