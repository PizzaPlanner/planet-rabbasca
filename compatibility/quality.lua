if not mods["quality"] then return end
table.insert(data.raw["technology"]["rabbasca-quality-assurance"].effects, 
{
    type = "unlock-recipe",
    recipe = "rabbasca-quality-assurance",
})

data:extend{
    Rabbasca.make_trigger_item({
    name = "rabbasca-quality-assurance",
    categories = { "rabbasca-security" },
    order = "b[vault-access-key]",
    icons = {
        {icon = "__Krastorio2Assets__/icons/cards/advanced-tech-card.png", icon_size = 64, shift = {-8,  0}, scale = 0.4 },
        {icon = data.raw["virtual-signal"]["signal-any-quality"].icon,   icon_size = 64, shift = { 8, 8}, scale = 0.4 },
    },
    },"rabbasca_on_modulate_vault_security")
}

Rabbasca.create_vault_recipe("rabbasca-quality-assurance", {
  icons = Rabbasca.icons({
    {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
    {proto = data.raw["virtual-signal"]["signal-any-quality"], shift = {6, 6}, scale = 0.75 },
  }),
  ingredients = {
      { type = "item", name = "vault-security-key", amount = 10 },
      { type = "item",  name = "rabbasca-warp-core", amount = 3 },
  },
  results = { 
      { type = "item", name = "rabbasca-quality-assurance", amount = 1, always_fresh = true, show_details_in_recipe_tooltip = false },
  },
  energy_required = 60,
  allow_productivity = false,
  order = "z[effects]-q[quality]"
})