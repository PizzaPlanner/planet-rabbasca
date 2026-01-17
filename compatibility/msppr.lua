if not mods["multi_surface_promethium_plate_recipe"] then return end

data:extend({
    util.merge {
        data.raw["item"]["msppr-nauvis"],
        {
            name = "msppr-rabbasca",
            icon = "__rabbasca-assets__/graphics/recolor/icons/msppr.png",
            order = "d[promethium]-r[rabbasca]",
        },
    },
    {
        type = "recipe",
        name = "msppr-rabbasca",
        subgroup = "science-pack",
        category = "rabbasca-vault-extraction",
        surface_conditions = { Rabbasca.above_harenic_threshold() },
        enabled = false,
        ingredients = {
            { type = "item", name = "rabbasca-turbofuel", amount = 1 },
            { type = "item", name = "haronite", amount = 3 },
        },
        energy_required = 75,
        msppr = {
            result = { type = "item", name = "msppr-rabbasca", amount = 1 },
            recipe_chain_order = "rabbasca",
        },
        results = { { type = "item", name = "msppr-rabbasca", amount = 1 } },
        allow_productivity = false,
        auto_recycle = false,
    },
})

for _, ingred in pairs(data.raw["recipe"]["rabbasca-hyperfuel"].ingredients) do
    if ingred.name == "promethium-asteroid-chunk" then
        ingred.name = "msppr-crushed-promethium"
    end
end
for _, ingred in pairs(data.raw["recipe"]["omega-carotene"].ingredients) do
    if ingred.name == "promethium-asteroid-chunk" then
        ingred.name = "msppr-crushed-promethium"
    end
end