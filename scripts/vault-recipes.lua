local r = require("__planet-rabbasca__.util")

r.create_vault_recipe("vault-protocol-haronite", {
  icons = {
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {icon = data.raw["item"]["haronite"].icon, icon_size = 64, shift = {8, 8}, scale = 0.4},
  },
  results = {{type = "item", name = "haronite", amount = 5 }}, 
  energy_required = 45,
  main_product = "haronite",
  maximum_productivity = 9,
  allow_productivity = true,
})
r.create_vault_recipe("vault-protocol-harene-ears-subcore",
{
  icons = {
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {icon = data.raw["item"]["harene-ears-core"].icon, icon_size = 64, shift = {8, 8}, scale = 0.4},
  },
  results = {{type = "item", name = "harene-ears-subcore", amount = 1 }}, 
  energy_required = 900,
  main_product = "harene-ears-subcore",
  maximum_productivity = 9,
  allow_productivity = true,
})
r.create_vault_recipe("vault-protocol-iron-ore", {
  icons = {
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {icon = data.raw["item"]["iron-ore"].icon, icon_size = 64, shift = {8, 8}, scale = 0.4},
  },
  results = {
    {type = "item", name = "iron-ore", amount = 100 },
  }, 
  energy_required = 20,
  maximum_productivity = 9,
  allow_productivity = true,
})
r.create_vault_recipe("vault-protocol-copper-ore", {
  icons = {
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {icon = data.raw["item"]["copper-ore"].icon, icon_size = 64, shift = {8, 8}, scale = 0.4},
  },
  results = {
    {type = "item", name = "copper-ore", amount = 90 },
  }, 
  energy_required = 25,
  maximum_productivity = 9,
  allow_productivity = true,
})
r.create_vault_recipe("vault-protocol-water", {
  icons = {
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {icon = data.raw["fluid"]["water"].icon, icon_size = 64, shift = {8, 8}, scale = 0.4},
  },
  results = {
    {type = "item", name = "water-barrel", amount = 10 },
  }, 
  energy_required = 40,
  maximum_productivity = 9,
  allow_productivity = true,
})
r.create_vault_recipe("vault-protocol-sulfur", {
  icons = {
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {icon = data.raw["item"]["sulfur"].icon, icon_size = 64, shift = {8, 8}, scale = 0.4},
  },
  results = {
    {type = "item", name = "sulfur", amount = 8 },
  }, 
  energy_required = 20,
  maximum_productivity = 9,
  allow_productivity = true,
})


data:extend {
    {
        type = "recipe",
        name = "rabbasca-extend-hack-vault-access-key",
        localised_name = {"recipe-name.rabbasca-extend-hack"},
        localised_description = {"recipe-description.rabbasca-extend-hack"},
        subgroup = "rabbasca-security",
        order = "h[hack-extension]-a",
        icons = { 
          { icon = data.raw["ammo"]["vault-access-key"].icon, icon_size = 64 },
          { icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png", icon_size = 64, scale = 0.3, shift = { 8, 8 } },
        },
        enabled = true,
        category = "rabbasca-vault-hacking",
        hide_from_player_crafting = true,
        energy_required = 6,
        ingredients = {{ type = "item", name = "vault-access-key", amount = 1 }},
        auto_recycle = false
    },
    {
        type = "recipe",
        name = "rabbasca-extend-hack-vault-security-key",
        localised_name = {"recipe-name.rabbasca-extend-hack"},
        localised_description = {"recipe-description.rabbasca-extend-hack"},
        subgroup = "rabbasca-security",
        order = "h[hack-extension]-b",
        icons = { 
          { icon = data.raw["ammo"]["vault-security-key"].icon, icon_size = 64 },
          { icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png", icon_size = 64, scale = 0.3, shift = { 8, 8 } },
        },
        enabled = true,
        category = "rabbasca-vault-hacking",
        hide_from_player_crafting = true,
        energy_required = 30,
        ingredients = {{ type = "item", name = "vault-security-key", amount = 1 }},
        auto_recycle = false
    },
}