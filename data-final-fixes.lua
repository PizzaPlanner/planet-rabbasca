
local bunnyhop_engine = data.raw["item"]["bunnyhop-engine-equipment"]
local warp_pylon = data.raw["assembling-machine"]["rabbasca-warp-pylon"]
for _, quality in pairs(data.raw["quality"]) do
  local multiplier = quality.default_multiplier or (1 + 0.3 * quality.level)
  warp_pylon.crafting_speed_quality_multiplier[quality.name] = 1
  bunnyhop_engine.custom_tooltip_fields[1].quality_values[quality.name] = {"tooltip-value.bunnyhop-engine-weight-multiplier", tostring(multiplier * 100)}
  warp_pylon.custom_tooltip_fields[1].quality_values[quality.name] = {"tooltip-value.rabbasca-warp-pylon-range", tostring(Rabbasca.get_warp_radius(quality) * 2)}
end

local vault_core = data.raw["unit-spawner"]["rabbasca-vault-meltdown"]
for _, damage in pairs(data.raw["damage-type"]) do
  table.insert(vault_core.resistances, { type = damage.name, percent = 100 })
end

data.raw["recipe"]["rabbasca-warp-pylon-recycling"].hidden = false
data.raw["recipe"]["rabbasca-warp-pylon-recycling"].hidden_in_factoriopedia = false
data.raw["recipe"]["rabbasca-warp-pylon-recycling"].hide_from_player_crafting = true

local console = data.raw["assembling-machine"]["rabbasca-vault-console"]
for _, res in pairs(console.resistances) do
  if res.type == "physical" then
    local console_res_flat = res.decrease or 0
    local console_res_perc = (res.percent or 100) / 100
    console.production_health_effect = {
      producing = console.production_health_effect.producing * console_res_perc - console_res_flat,
      not_producing = console.production_health_effect.not_producing * console_res_perc - console_res_flat
    }
  end
end


local biochamber = data.raw["assembling-machine"]["biochamber"]
biochamber.energy_source.burnt_inventory_size = biochamber.energy_source.burnt_inventory_size or 1

require("scripts.create-ears-variants")
require("scripts.warp.pylon-radar-dummies-final-fixes")

require("__planet-rabbasca__.compatibility.muluna-final-fixes")
require("__planet-rabbasca__.compatibility.pelagos-final-fixes")
require("__planet-rabbasca__.compatibility.adjustable-quality-final-fixes")