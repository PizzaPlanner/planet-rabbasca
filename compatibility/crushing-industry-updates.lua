if not mods["crushing-industry"] then return end

CrushingIndustry.concrete_recipes["rabbasca-energetic-concrete"] = { ignore = true }

local recipe = data.raw["recipe"]["rabbasca-energetic-concrete"]
local mix  = data.raw["fluid"]["concrete-mix"]
local residue = data.raw["fluid"]["energetic-residue"]
if not mix then return end
if not recipe then return end
if not residue then return end

local new_ingredients = { { type = "fluid", name = "rabbasca-energetic-concrete-mix", amount = 200} }
for i, input in ipairs(recipe.ingredients) do
    if not (input.name == "concrete" or input.name == "concrete-mix" or input.name == "energetic-residue") then
        table.insert(new_ingredients, input)
    end
end
recipe.ingredients = new_ingredients

if data.raw["technology"]["energetic-residue"] then
    table.insert(data.raw["technology"]["energetic-residue"].effects,
    {
        type = "unlock-recipe",
        recipe = "rabbasca-energetic-concrete-mix",
    })
end

data:extend {
    util.merge {
        mix,
        {
            name = "rabbasca-energetic-concrete-mix",
            fuel_value = "80kJ",
            icons = {{ icon = mix.icon, icon_size = mix.icon_size, tint = { 0.66, 0.3, 1 } }},
            localised_name = {"rabbasca-extra.energized", mix.localised_name or { "fluid-name.concrete-mix" } },
            order = mix.order.."-e[energized]"
        }
    },
    {
        type = "recipe",
        name = "rabbasca-energetic-concrete-mix",
        category = "chemistry",
        main_product = "rabbasca-energetic-concrete-mix",
        hide_from_player_crafting = true,
        enabled = false,
        energy_required = 5,
        results = {{type = "fluid", name = "rabbasca-energetic-concrete-mix", amount = 100}},
        ingredients = {
            { type = "fluid", name = "energetic-residue", amount = 20 },
            { type = "fluid", name = "concrete-mix", amount = 80 },
        },
    }

}