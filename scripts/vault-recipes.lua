local r = require("__planet-rabbasca__.util")

r.create_vault_recipe(data.raw["item"]["vault-access-key-e"], {{type = "item", name = "harene-ears-subcore", amount = 1 }}, 900,  false)
r.create_access_key_recipe(data.raw["item"]["vault-access-key-e"], {{ type = "item", name = "power-solution", amount = 2 }, { type = "item", name = "vision-circuit", amount = 1 }})


r.create_vault_recipe(data.raw["item"]["vault-access-key-u"], {
  {type = "item", name = "copper-ore", amount_min = 25, amount_max  = 28 },
  {type = "item", name = "iron-ore", amount_min = 20, amount_max  = 24 },
  {type = "item", name = "sulfur", amount_min = 10, amount_max  = 11 },
  {type = "item", name = "uranium-ore", amount_min = 8, amount_max  = 12 },
}, 20, false)
r.create_access_key_recipe(data.raw["item"]["vault-access-key-u"], {{type = "item", name = "rabbasca-carotene-powder", amount = 10}})

r.create_vault_recipe(data.raw["item"]["vault-access-key-b"], {
    {type = "item", name = "inserter", amount_min = 5, amount_max  = 7, probability = 0.23 },
    {type = "item", name = "transport-belt", amount_min = 20, amount_max  = 30, probability = 0.5 },
    {type = "item", name = "recycler", amount = 1, probability = 0.37 },
}, 300, false)
r.create_access_key_recipe(data.raw["item"]["vault-access-key-b"], {{type = "item", name = "blueprint", amount = 1}})