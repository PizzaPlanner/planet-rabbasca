if not mods["Krastorio2-spaced-out"] then return end

data.raw["ammo"]["vault-security-key"].icons = Rabbasca.icons({{ proto = data.raw["ammo"]["vault-security-key"], tint = { 0.4, 0.8, 0.9 } }})
data.raw["ammo"]["vault-security-key"].icon = nil
data.raw["ammo"]["vault-access-key"].icons = Rabbasca.icons({{ proto = data.raw["ammo"]["vault-access-key"], tint = { 0.8, 0.55, 1 } }})
data.raw["ammo"]["vault-access-key"].icon = nil
data.raw["item"]["haronite-plate"].icons = Rabbasca.icons({{ proto = data.raw["item"]["haronite-plate"], tint = { 0.7, 0.9, 1 } }})
data.raw["item"]["haronite-plate"].icon = nil

if data.raw["ammo"]["kr-rifle-magazine"] then
    table.insert(data.raw["resource"]["rabbascan-scrap"].minable.results,
        { type = "item", name = "kr-rifle-magazine", amount = 1, independent_probability = 0.12 }
    )
end

if data.raw["ammo"]["kr-anti-materiel-rifle-magazine"] then
    table.insert(data.raw["resource"]["rabbascan-scrap"].minable.results,
        { type = "item", name = "kr-anti-materiel-rifle-magazine", amount = 1, independent_probability = 0.08 }
    )
end

if data.raw["item"]["kr-coke"] then
    data:extend {
        {
            type = "recipe",
            name = "rabbasca-kr-coke-carotenoid",
            icons = Rabbasca.icons({
                { proto = data.raw["item"]["kr-coke"] },
                { proto = data.raw["item"]["carotenoid-ore"], scale = 0.5, shift = {-4, -4} },
            }),
            enabled = false,
            energy_required = 16,
            ingredients = {
                { type = "item", name = "carotenoid-ore", amount = 6 },
                { type = "item", name = "carbon", amount = 6 },
            },
            results = { 
                { type = "item", name = "kr-coke", amount = 6 },
            },
            allow_productivity = true,
            categories = { "smelting" },
            order = "b[chemistry]-g[coke]"
        }
    }
    table.insert(data.raw["technology"]["carotene"].effects, { type = "unlock-recipe", recipe = "rabbasca-kr-coke-carotenoid" })
end

if data.raw["item"]["kr-rare-metal-ore"] then
    Rabbasca.create_vault_recipe("vault-protocol-kr-rare-metal-ore", {
        icons = Rabbasca.icons({
            {icon = "__Krastorio2Assets__/icons/entities/stabilizer-charging-station.png", icon_size = 64},
            {proto = data.raw["item"]["kr-rare-metal-ore"], shift = { 4, 4 }, scale = 0.75},
        }),
        results = {
            {type = "item", name = "kr-rare-metal-ore", amount = 25 },
        }, 
        energy_required = 28,
        allow_productivity = true,
    })
    table.insert(data.raw["technology"]["rabbascan-vault-access"].effects, { type = "unlock-recipe", recipe = "vault-protocol-kr-rare-metal-ore" })
end