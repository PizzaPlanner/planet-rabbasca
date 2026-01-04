if not mods["multi_surface_promethium_plate_recipe"] then return end

data:extend({
    util.merge {
        data.raw["item"]["msppr-nauvis"],
        {
            name = "msppr-rabbasca",
            icons = {{
                icon = "__multi_surface_promethium_plate_recipe__/graphics/msppr-nauvis.png",
                tint = { 0.2, 0.15, 1 }
            }},
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
            { type = "item", name = "rabbasca-hyperfuel", amount = 1 },
            { type = "item", name = "rabbasca-warp-core", amount = 1 },
            { type = "item", name = "haronite", amount = 3 },
        },
        energy_required = 75,
        msppr = {
            result = { type = "item", name = "msppr-rabbasca", amount = 5 },
            recipe_chain_order = "rabbasca",
        },
        results = { { type = "item", name = "msppr-rabbasca", amount = 5 } },
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