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