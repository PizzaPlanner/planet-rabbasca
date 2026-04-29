if not settings.startup["rabbasca-enable-new-vault-progression"].value then return end

local vault = data.raw["assembling-machine"]["rabbasca-vault-crafter"]
vault.resistances = { }
for _, damage in pairs(data.raw["damage-type"]) do
  table.insert(vault.resistances, { type = damage.name, percent = 100 })
end

data.raw["unit-spawner"]["rabbasca-vault-spawner"].dying_trigger_effect = {
  {
    type = "create-entity",
    as_enemy = true,
    entity_name = "rabbasca-vault-spawner",
    ignore_no_enemies_mode = true,
    protected = true,
  },
}

Rabbasca.create_vault_recipe("rabbasca-core-extraction-protocol", {
  icons = {
    { icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64 },
    { icon = data.raw["virtual-signal"]["signal-explosion"].icon, icon_size = 64, scale = 0.3, shift = { 8, 8 } }
  },
  ingredients = {
      { type = "item", name = "vault-security-key", amount = 100 },
      { type = "item",  name = "haronite-plate", amount = 5 },
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
      category = "rabbasca-security",
      hidden = true,
      order = "z[bye]",
      icons = {
        { icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64 },
        { icon = data.raw["virtual-signal"]["signal-explosion"].icon, icon_size = 64, scale = 0.3, shift = { 8, 8 } }
      }
    },"rabbasca_on_modulate_vault_security")
})

table.insert(data.raw["technology"]["rabbasca-security-modulation"].effects, { type = "unlock-recipe", recipe = "rabbasca-core-extraction-protocol" })
data.raw["technology"]["rabbasca-unhealthy-fluids"].localised_description = { "technology-description.rabbasca-unhealthy-fluids-alt" }
data.raw["fluid"]["harenic-lava"].localised_description = { "" }
data.raw["tile"]["harenic-lava"].localised_description = { "" }