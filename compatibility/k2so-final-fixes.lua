if not mods["Krastorio2-spaced-out"] then return end

data.raw["ammo"]["vault-security-key"].icons = Rabbasca.icons({{ proto = data.raw["ammo"]["vault-security-key"], tint = { 0.4, 0.8, 0.9 } }})
data.raw["ammo"]["vault-security-key"].icon = nil
data.raw["ammo"]["vault-access-key"].icons = Rabbasca.icons({{ proto = data.raw["ammo"]["vault-access-key"], tint = { 0.8, 0.55, 1 } }})
data.raw["ammo"]["vault-access-key"].icon = nil
data.raw["item"]["haronite-plate"].icons = Rabbasca.icons({{ proto = data.raw["item"]["haronite-plate"], tint = { 0.7, 0.9, 1 } }})
data.raw["item"]["haronite-plate"].icon = nil