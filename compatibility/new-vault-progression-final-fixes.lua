local vault = data.raw["assembling-machine"]["rabbasca-vault-crafter"]
local spawner = data.raw["unit-spawner"]["rabbasca-vault-spawner"]
vault.resistances = { }
spawner.resistances = { }
for _, damage in pairs(data.raw["damage-type"]) do
  table.insert(vault.resistances, { type = damage.name, percent = 100 })
  if damage.name == "electric" then
    -- https://forums.factorio.com/viewtopic.php?p=693026
    -- health can up to 10x at max. evolution, and must scale with quality
    table.insert(spawner.resistances, { type = damage.name, decrease = 900000 }) 
  else
    table.insert(spawner.resistances, { type = damage.name, percent = 100 })
  end
end
vault.is_military_target = false

Rabbasca.create_vault_recipe("rabbasca-core-extraction-protocol", {
  icons = Rabbasca.icons({
      { icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64 },
      { proto = data.raw["virtual-signal"]["signal-explosion"], scale = 0.75, shift = { 6, 6 } }
    }),
  ingredients = {
      { type = "item", name = "vault-security-key", amount = 100 },
      { type = "item",  name = "rabbasca-warp-core", amount = 10 },
      { type = "item",  name = "explosives", amount = 250 },
  },
  raise_on_crafted = true,
  energy_required = 60,
  allow_productivity = false,
  order = "z[effects]-z[bye]"
})

table.insert(data.raw["technology"]["rabbasca-quality-assurance"].effects, { type = "unlock-recipe", recipe = "rabbasca-core-extraction-protocol" })
data.raw["technology"]["rabbasca-unhealthy-fluids"].localised_description = { "technology-description.rabbasca-unhealthy-fluids-alt" }
table.insert(data.raw["technology"]["rabbasca-unhealthy-fluids"].prerequisites, "rabbasca-quality-assurance")
data.raw["fluid"]["harenic-lava"].localised_description = { "" }
data.raw["tile"]["harenic-lava"].localised_description = { "" }