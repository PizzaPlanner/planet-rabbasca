local carotene_barrel = data.raw["item"]["beta-carotene-barrel"]
local carotene_barrel_2 = data.raw["item"]["beta-carotene-titanium-barrel"]

if carotene_barrel and carotene_barel_2 then
    carotene_barrel_2.fuel_category = carotene_barrel.fuel_category
    carotene_barrel_2.fuel_value = carotene_barrel.fuel_value
end