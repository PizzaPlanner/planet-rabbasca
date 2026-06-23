Rabbasca.create_vault_recipe("vault-protocol-haronite", {
  icons = Rabbasca.icons({
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {proto = data.raw["item"]["haronite"], shift = {8, 8}, scale = 0.4},
  }),
  results = {{type = "item", name = "haronite", amount = 5 }}, 
  energy_required = 45,
  main_product = "haronite",
  maximum_productivity = 9,
  allow_productivity = true,
})
Rabbasca.create_vault_recipe("vault-protocol-harene-ears-subcore",
{
  icons = Rabbasca.icons({
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {proto = data.raw["item"]["harene-ears-core"], shift = {8, 8}, scale = 0.4},
  }),
  results = {{type = "item", name = "harene-ears-subcore", amount = 1 }}, 
  energy_required = settings.startup["rabbasca-ears-local-only"].value and 90 or 300,
  main_product = "harene-ears-subcore",
  maximum_productivity = 9,
  allow_productivity = true,
})
Rabbasca.create_vault_recipe("vault-protocol-iron-ore", {
  icons = Rabbasca.icons({
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {proto = data.raw["item"]["iron-ore"], shift = {8, 8}, scale = 0.4},
  }),
  results = {
    {type = "item", name = "iron-ore", amount = 100 },
  }, 
  energy_required = 20,
  maximum_productivity = 9,
  allow_productivity = true,
})
Rabbasca.create_vault_recipe("vault-protocol-copper-ore", {
  icons = Rabbasca.icons({
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {proto = data.raw["item"]["copper-ore"], shift = {8, 8}, scale = 0.4},
  }),
  results = {
    {type = "item", name = "copper-ore", amount = 90 },
  }, 
  energy_required = 25,
  maximum_productivity = 9,
  allow_productivity = true,
})
Rabbasca.create_vault_recipe("vault-protocol-water", {
  icons = Rabbasca.icons({
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {proto = data.raw["fluid"]["water"], shift = {8, 8}, scale = 0.4},
  }),
  results = {
    {type = "item", name = "water-barrel", amount = 10 },
  }, 
  energy_required = 40,
  maximum_productivity = 9,
  allow_productivity = true,
})
Rabbasca.create_vault_recipe("vault-protocol-sulfur", {
  icons = Rabbasca.icons({
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {proto = data.raw["item"]["sulfur"], shift = {8, 8}, scale = 0.4},
  }),
  results = {
    {type = "item", name = "sulfur", amount = 8 },
  }, 
  energy_required = 20,
  maximum_productivity = 9,
  allow_productivity = true,
})
Rabbasca.create_vault_recipe("rabbasca-security-modulation-up", {
  icons = Rabbasca.icons({
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {proto = data.raw["unit"]["vault-defender-heavy"], shift = {-8, 8}, scale = 0.4 },
    {proto = data.raw["virtual-signal"]["up-arrow"], shift = { 8, 8}, scale = 0.4, tint = {1, 0, 0} },
  }),
  ingredients = {
      { type = "item", name = "vault-security-key", amount = 5 },
      { type = "item",  name = "haronite-plate", amount = 1 },
  },
  results = { 
      { type = "item", name = "rabbasca-security-modulator", amount = 1 },
  },
  energy_required = 60,
  allow_productivity = false,
  order = "z[effects]-m[up]"
})
Rabbasca.create_vault_recipe("rabbasca-security-modulation-down", {
  icons = Rabbasca.icons({
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {proto = data.raw["unit"]["vault-defender-heavy"], shift = {-8, 8}, scale = 0.4 },
    {proto = data.raw["virtual-signal"]["down-arrow"], shift = { 8, 8}, scale = 0.4, tint = {0, 1, 0} },
  }),
  ingredients = {
      { type = "item", name = "vault-security-key", amount = 5 },
      { type = "item",  name = "haronite-plate", amount = 1 },
  },
  results = { 
      { type = "item", name = "rabbasca-security-modulator", amount = 1 },
  },
  energy_required = 60,
  allow_productivity = false,
  order = "z[effects]-m[down]"
})
Rabbasca.create_vault_recipe("rabbasca-quality-assurance", {
  icons = Rabbasca.icons({
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {proto = data.raw["virtual-signal"]["signal-any-quality"], shift = {8, 8}, scale = 0.4 },
  }),
  ingredients = {
      { type = "item", name = "vault-security-key", amount = 10 },
      { type = "item",  name = "rabbasca-warp-core", amount = 3 },
  },
  results = { 
      { type = "item", name = "rabbasca-quality-assurance", amount = 1 },
  },
  energy_required = 60,
  allow_productivity = false,
  order = "z[effects]-q[quality]"
})

data:extend {
    {
        type = "recipe",
        name = "rabbasca-extend-hack-vault-security-key",
        localised_name = {"recipe-name.rabbasca-extend-hack"},
        localised_description = {"recipe-description.rabbasca-extend-hack"},
        subgroup = "rabbasca-security",
        order = "h[hack-extension]-b",
        icons = Rabbasca.icons({
          { proto = data.raw["virtual-signal"]["signal-hourglass"] },
          { proto = data.raw["ammo"]["vault-security-key"], scale = 0.4, shift = { 8, 8 } }
        }),
        enabled = true,
        categories = { "rabbasca-vault-hacking" },
        hide_from_player_crafting = true,
        energy_required = 15,
        ingredients = {{ type = "item", name = "vault-security-key", amount = 1 }},
        auto_recycle = false,
        overload_multiplier = 1
    },
}