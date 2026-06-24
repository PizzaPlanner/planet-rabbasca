if not settings.startup["rabbasca-enable-new-vault-progression"].value then return end

local vault = data.raw["assembling-machine"]["rabbasca-vault-crafter"]
local spawner = data.raw["unit-spawner"]["rabbasca-vault-spawner"]
vault.resistances = { }
spawner.resistances = { }
for _, damage in pairs(data.raw["damage-type"]) do
  table.insert(vault.resistances, { type = damage.name, percent = 100 })
  if damage.name == "electric" then
    -- https://forums.factorio.com/viewtopic.php?p=693026
    table.insert(spawner.resistances, { type = damage.name, decrease = 1000000 - spawner.max_health * 10 * (1 + spawner.overkill_fraction) })
  else
    table.insert(spawner.resistances, { type = damage.name, percent = 100 })
  end
end

Rabbasca.create_vault_recipe("rabbasca-core-extraction-protocol", {
  icons = Rabbasca.icons({
    { icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64 },
    { proto = data.raw["virtual-signal"]["signal-explosion"], scale = 0.3, shift = { 8, 8 } }
  }),
  ingredients = {
      { type = "item", name = "vault-security-key", amount = 100 },
      { type = "item",  name = "rabbasca-warp-core", amount = 10 },
  },
  results = { 
      { type = "item", name = "rabbasca-core-extraction-protocol", amount = 1 },
  },
  energy_required = 60,
  allow_productivity = false,
  order = "z[effects]-z[bye]"
})
data:extend({
    Rabbasca.make_trigger_item({
      name = "rabbasca-core-extraction-protocol",
      subgroup = "rabbasca-vault-extraction",
      hidden = false,
      order = "z[bye]",
      icons = Rabbasca.icons({
        { icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64 },
        { proto = data.raw["virtual-signal"]["signal-explosion"], scale = 0.3, shift = { 8, 8 } }
      })
    },"rabbasca_on_modulate_vault_security")
})

table.insert(data.raw["technology"]["rabbasca-quality-assurance"].effects, { type = "unlock-recipe", recipe = "rabbasca-core-extraction-protocol" })
data.raw["technology"]["rabbasca-unhealthy-fluids"].localised_description = { "technology-description.rabbasca-unhealthy-fluids-alt" }
table.insert(data.raw["technology"]["rabbasca-unhealthy-fluids"].prerequisites, "rabbasca-quality-assurance")
data.raw["fluid"]["harenic-lava"].localised_description = { "" }
data.raw["tile"]["harenic-lava"].localised_description = { "" }