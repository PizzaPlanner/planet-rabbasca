local r = require("__planet-rabbasca__.util")

r.create_access_key_recipe("vault-protocol-haronite", {
  { type = "item", name = "vision-circuit", amount = 1 }
})
r.create_vault_recipe("vault-protocol-haronite", {
  results = {{type = "item", name = "haronite", amount = 5 }}, 
  energy_required = 120,
  main_product = "haronite"
})

r.create_access_key_recipe("vault-protocol-harene-ears-subcore", {
  { type = "item", name = "processing-unit", amount = 1 }
})
r.create_vault_recipe("vault-protocol-harene-ears-subcore",
{
  results = {{type = "item", name = "harene-ears-subcore", amount = 1 }}, 
  energy_required = 900,
  main_product = "harene-ears-subcore"
})

r.create_access_key_recipe("vault-protocol-iron-ore", {
  { type = "item", name = "electronic-circuit", amount = 1 },
  { type = "item", name = "iron-plate", amount = 1 },
})
r.create_vault_recipe("vault-protocol-iron-ore", {
  icons = {
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png"},
    {icon = data.raw["item"]["copper-ore"].icon, shift = {-6, 6}},
  },
  results = {
    {type = "item", name = "iron-ore", amount = 75 },
  }, 
  energy_required = 25,
  maximum_productivity = 9,
  allow_productivity = true,
})
r.create_access_key_recipe("vault-protocol-copper-ore", {
  { type = "item", name = "electronic-circuit", amount = 1 },
  { type = "item", name = "copper-plate", amount = 1 },
})
r.create_vault_recipe("vault-protocol-copper-ore", {
  icons = {
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png"},
    {icon = data.raw["item"]["copper-ore"].icon, shift = {-6, 6}},
  },
  results = {
    {type = "item", name = "copper-ore", amount = 60 },
  }, 
  energy_required = 25,
  maximum_productivity = 9,
  allow_productivity = true,
})

r.create_access_key_recipe("vault-protocol-catalysts", {
  { type = "item", name = "vision-circuit", amount = 1 },
})
r.create_vault_recipe("vault-protocol-catalysts", {
  icons = {
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png"},
    {icon = data.raw["item"]["sulfur"].icon, shift = {-6, 6}},
    {icon = data.raw["item"]["calcite"].icon, shift = {6, 6}},
  },
  results = {
    {type = "item", name = "calcite", amount = 10 },
    {type = "item", name = "sulfur", amount = 7 },
  }, 
  energy_required = 20,
  maximum_productivity = 9,
  allow_productivity = true,
})