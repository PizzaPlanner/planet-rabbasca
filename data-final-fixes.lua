
local bunnyhop_engine = data.raw["item"]["bunnyhop-engine-equipment"]
local warp_pylon = data.raw["assembling-machine"]["rabbasca-warp-pylon"]
local console = data.raw["furnace"]["rabbasca-vault-console"]
console.result_inventory_size = 0 -- castra compatibility; not required but looks nicer
console.crafting_speed_quality_multiplier = { }
for _, quality in pairs(data.raw["quality"]) do
  local multiplier = quality.default_multiplier or 1 + 0.3 * quality.level
  console.crafting_speed_quality_multiplier[quality.name] = 1
  warp_pylon.crafting_speed_quality_multiplier[quality.name] = 1
  bunnyhop_engine.custom_tooltip_fields[1].quality_values[quality.name] = {"tooltip-value.bunnyhop-engine-weight-multiplier", tostring(multiplier * 100)}
  warp_pylon.custom_tooltip_fields[1].quality_values[quality.name] = {"tooltip-value.rabbasca-warp-pylon-range", tostring(Rabbasca.get_warp_radius(quality))}
end

local vault_core = data.raw["unit-spawner"]["rabbasca-vault-meltdown"]
for _, damage in pairs(data.raw["damage-type"]) do
  table.insert(vault_core.resistances, { type = damage.name, percent = 100 })
end

-- local fast_replace_group = "entity-ghost"
-- for _, ghost in pairs(data.raw["entity-ghost"]) do


require("__planet-rabbasca__.compatibility.muluna-final-fixes")
require("__planet-rabbasca__.compatibility.pelagos-final-fixes")