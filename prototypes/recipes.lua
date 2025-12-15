require("__planet-rabbasca__.scripts.vault-recipes")

if settings.startup["rabbasca-no-extra-category"].value == false then
data:extend {
    {
        type = "item-group",
        name = "rabbasca-extensions",
        icons = {{
            icon = data.raw["item"]["harene-ears-core"].icon,
            icon_size = 64,
            scale = 0.7
        }},
        order = "fr"
    },
}
end

data:extend {
    {
        type = "item-subgroup",
        name = "rabbasca-processes",
        group = "intermediate-products",
        order = data.raw["item-subgroup"]["fulgora-processes"].name .."-b"
    },
    {
        type = "item-subgroup",
        name = "rabbasca-security",
        group = "combat",
        order = "x"
    },
    {
        type = "item-subgroup",
        name = "rabbasca-vault-extraction",
        group = data.raw["item-group"]["rabbasca-extensions"] and "rabbasca-extensions" or "combat",
        order = "a"
    },
    {
        type = "recipe-category",
        name = "complex-machinery",
    },
    {
        type = "recipe-category",
        name = "install-ears-core",
    },
    {
        type = "recipe-category",
        name = "rabbasca-vault-extraction",
    },
    {
        type = "recipe-category",
        name = "rabbasca-vault-hacking",
    },
    {
        type = "recipe",
        name = "carbon-from-carotenoid",
        icons = {
            { icon = data.raw["item"]["carbon"].icon, icon_size = 64, scale = 0.8, shift = {6, 4} },
            { icon = data.raw["item"]["carotenoid-ore"].icon, icon_size = 64, scale = 0.5, shift = {-6, -4} },
        },
        energy_required = 7.0,
        enabled = false,
        ingredients = { 
            {type = "item", name = "carotenoid-ore", amount = 1 },
        },
        results = { { type = "item", name = "carbon", amount = 10 } },
        main_product = "carbon",
        hide_from_player_crafting = true,
        category = "smelting",
        allow_productivity = true,
        auto_recycle = false,
    },
    {
        type = "recipe",
        name = "beta-carotene",
        energy_required = 5.0,
        enabled = false,
        ingredients = { 
            {type = "fluid", name = "harene-gas", amount = 5 },
            {type = "fluid", name = "water", amount = 10 },
            {type = "item", name = "carotenoid-ore", amount = 20 },
        },
        results = { { type = "fluid", name = "beta-carotene", amount = 60 } },
        main_product = "beta-carotene",
        hide_from_player_crafting = true,
        category = "organic-or-chemistry",
        allow_productivity = true,
        auto_recycle = false,
    },
    {
        type = "recipe",
        name = "harene",
        enabled = false,
        energy_required = 10,
        ingredients = { 
            {type = "item",  name = "harenic-stabilizer", amount = 10 },
            {type = "item",  name = "harene-cryo-container-filled", amount = 1 },
            {type = "fluid",  name = "harene-gas", amount = 50 },
            {type = "fluid",  name = "fluoroketone-cold", amount = 1000 },
        },
        results = { 
            { type = "fluid", name = "harene", amount = 25 },
            {type = "fluid",  name = "fluoroketone-hot", amount = 1000, ignored_by_productivity = 1000 },
            {type = "item",  name = "harene-cryo-container-empty", amount = 1, probability = 0.2, ignored_by_productivity = 1 },
        },
        allow_productivity = true,
        main_product = "harene",
        hide_from_player_crafting = true,
        category = "cryogenics",
        surface_conditions = { { property = "magnetic-field", min = 99 } },
    },
    {
        type = "recipe",
        name = "harene-cryo-container-empty",
        enabled = false,
        energy_required = 10,
        ingredients = { 
            {type = "item",  name = "tungsten-plate", amount = 15 },
            {type = "item",  name = "holmium-plate", amount = 20 },
            {type = "item",  name = "low-density-structure", amount = 4 },
            {type = "item",  name = "carbon-fiber", amount = 5 },
        },
        results = { 
            {type = "item",  name = "harene-cryo-container-empty", amount = 1 },
        },
        main_product = "harene-cryo-container-empty",
        surface_conditions = table.deepcopy(data.raw["recipe"]["cryogenic-plant"].surface_conditions),
        allow_productivity = true,
        hide_from_player_crafting = true,
        category = "crafting",
    },
    {
        type = "recipe",
        name = "harene-cryo-container-filled",
        enabled = false,
        energy_required = 10,
        ingredients = { 
            {type = "item",  name = "harenic-stabilizer", amount = 10 },
            {type = "item",  name = "harene-cryo-container-empty", amount = 1 },
            {type = "fluid", name = "harenic-lava", amount = 500 },
        },
        results = { 
            {type = "item",  name = "harene-cryo-container-filled", amount = 1, probability = 0.75 },
        },
        allow_productivity = false,
        main_product = "harene-cryo-container-filled",
        hide_from_player_crafting = true,
        category = "metallurgy",
        spoil_ticks = 30 * second,
        spoil_result = "harene-cryo-container-empty",
        surface_conditions = { Rabbasca.above_harenic_threshold() },
    },
    {
        type = "recipe",
        name = "haronite-plate",
        enabled = false,
        energy_required = 8,
        ingredients = { 
            {type = "item",  name = "steel-plate",    amount = 20 },
            {type = "item",  name = "tungsten-plate", amount = 5  },
            {type = "fluid", name = "harenic-lava", amount = 500 },
            {type = "fluid", name = "harene", amount = 5 },
        },
        results = { 
            { type = "item", name = "haronite-plate", amount = 10  },
            { type = "item", name = "tungsten-carbide", amount = 2 },
            { type = "fluid", name = "molten-iron", amount = 20 },
        },
        main_product = "haronite-plate",
        category = "metallurgy",
        surface_conditions = { Rabbasca.above_harenic_threshold() },
    },
    {
        type = "recipe",
        name = "haronite-rocket-frame",
        enabled = false,
        energy_required = 10,
        ingredients = { 
            {type = "item",  name = "haronite-plate",    amount = 1 },
            {type = "item",  name = "low-density-structure", amount = 10  },
        },
        results = { 
            { type = "item", name = "haronite-rocket-frame", amount = 15  },
        },
        main_product = "haronite-rocket-frame",
        category = "metallurgy",
        surface_conditions = { Rabbasca.above_harenic_threshold() },
    },
    {
        type = "recipe",
        name = "machining-assembler",
        enabled = false,
        energy_required = 20.0,
        ingredients = { 
            {type = "item", name = "steel-plate", amount = 200 },
            {type = "item", name = "iron-gear-wheel", amount = 69 },
            {type = "item", name = "rabbasca-energetic-concrete", amount = 50 },
            {type = "item", name = "advanced-circuit", amount = 50 },
            {type = "fluid", name = "lubricant", amount = 200 },
        },
        results = { { type = "item", name = "machining-assembler", amount = 1 } },
        surface_conditions = { Rabbasca.above_harenic_threshold() },
        main_product = "machining-assembler",
        category = "crafting-with-fluid",
    },
    {
        type = "recipe",
        name = "solid-fuel-from-energetic-residue",
        category = "chemistry",
        energy_required = 3,
        ingredients =
        {
            {type = "fluid", name = "energetic-residue", amount = 20 },
        },
        results =
        {
            { type = "item", name = "solid-fuel", amount = 1 }
        },
        allow_productivity = true,
        icons = {
            { icon = "__base__/graphics/icons/solid-fuel.png", icon_size = 64, scale = 0.8 },
            { icon = data.raw["fluid"]["energetic-residue"].icon, icon_size = 64, scale = 0.35, shift = { -8, -8 } }
        },
        subgroup = "fluid-recipes",
        enabled = false,
        order = "b[fluid-chemistry]-d[solid-fuel-from-energetic-residue]",
        crafting_machine_tint =
        {
            primary = {r = 0.710, g = 0.633, b = 0.482, a = 1.000},
            secondary = {r = 0.745, g = 0.672, b = 0.527, a = 1.000},
            tertiary = {r = 0.894, g = 0.773, b = 0.596, a = 1.000},
            quaternary = {r = 0.812, g = 0.583, b = 0.202, a = 1.000},
        }
    },
    {
        type = "recipe",
        name = "ears-subcore-reactor-equipment",
        enabled = false,
        energy_required = 10,
        ingredients = { 
            {type = "item", name = "harene-ears-subcore", amount = 1 },
            {type = "item", name = "electric-engine-unit", amount = 1 },
            {type = "item", name = "advanced-circuit", amount = 5 },
        },
        results = { 
            { type = "item", name = "ears-subcore-reactor-equipment", amount = 1 },
        },
        main_product = "ears-subcore-reactor-equipment",
        category = "crafting",
    },
    {
        type = "recipe",
        name = "bunnyhop-engine-equipment",
        enabled = false,
        energy_required = 40,
        ingredients = { 
            {type = "item", name = "ears-subcore-reactor-equipment", amount = 2 },
            {type = "item", name = "rabbasca-turbofuel", amount = 400 },
            {type = "item", name = "rabbasca-energetic-concrete", amount = 100 },
            {type = "item", name = "electric-engine-unit", amount = 50 },
            {type = "item", name = "processing-unit", amount = 200 }
        },
        results = { 
            { type = "item", name = "bunnyhop-engine-equipment", amount = 1 },
        },
        -- hide_from_player_crafting = true,
        main_product = "bunnyhop-engine-equipment",
        category = "crafting",
    },
    {
        type = "recipe",
        name = "rabbasca-turbofuel",
        enabled = false,
        energy_required = 10,
        ingredients = {
            { type = "item", name = "rabbasca-turbofish", amount = 1 },
            { type = "fluid", name = "harene-gas", amount = 15 },
            { type = "item", name = "solid-fuel", amount = 10 },
        },
        results = { 
            { type = "item", name = "rabbasca-turbofuel", amount = 1 },
        },
        enabled = false,
        allow_productivity = true,
        category = "chemistry",
        crafting_machine_tint =
        {
            primary = {r = 0.710, g = 0.633, b = 0.482, a = 1.000},
            secondary = {r = 0.745, g = 0.672, b = 0.527, a = 1.000},
            tertiary = {r = 0.894, g = 0.773, b = 0.596, a = 1.000},
            quaternary = {r = 0.812, g = 0.583, b = 0.202, a = 1.000},
        }
    },
    {
        type = "recipe",
        name = "rabbasca-turbofish-breeding",
        enabled = false,
        energy_required = 15,
        ingredients = { 
            {type = "item",  name = "rabbasca-turbofish", amount = 2 },
            {type = "item",  name = "rabbasca-protein-shake", amount = 1  },
            {type = "fluid", name = "harene-gas", amount = 10 },
        },
        results = { 
            { type = "item", name = "rabbasca-turbofish", amount = 3, ignored_by_productivity = 2 },
        },
        main_product = "rabbasca-turbofish",
        category = "organic-or-chemistry",
        allow_productivity = true,
        result_is_always_fresh = true,
        subgroup = "nauvis-agriculture",
        order = "b[nauvis-agriculture]-b[turbofish-breeding]",
        auto_recycle = false,
    },
    {
        type = "recipe",
        name = "protein-powder",
        enabled = false,
        energy_required = 1,
        ingredients = { 
            {type = "item", name = "rabbasca-turbofish", amount = 1 },
        },
        results = { 
            { type = "item", name = "protein-powder", amount = 5 },
        },
        main_product = "protein-powder",
        category = "crafting",
        allow_productivity = true,
        auto_recycle = false
    },
    {
        type = "recipe",
        name = "harene-ears-core",
        enabled = false,
        energy_required = 4,
        ingredients = { 
            {type = "item", name = "harene-ears-subcore", amount = 10 },
        },
        results = { {type = "item", name = "harene-ears-core", amount = 1 } },
        main_product = "harene-ears-core",
        category = "crafting",
    },
    {
        type = "recipe",
        name = "lubricant-from-energetic-residue",
        icons = { 
            { icon = data.raw["fluid"]["lubricant"].icon, icon_size = 64, },
            { icon = data.raw["fluid"]["energetic-residue"].icon, scale = 0.3, icon_size = 64,shift = { -8, -8 } },
        },
        enabled = false,
        energy_required = 3.5,
        hide_from_player_crafting = true,
        ingredients = { 
            {type = "fluid", name = "energetic-residue", amount = 10 },
        },
        results = { { type = "fluid", name = "lubricant", amount = 10 } },
        main_product = "lubricant",
        category = "chemistry",
        subgroup = "rabbasca-processes",
        order = "r[alternate-uses]-[lubricant]"

    },
    {
        type = "recipe",
        name = "rabbasca-protein-shake",
        enabled = false,
        energy_required = 7,
        ingredients = {
            { type = "item", name = "plastic-bottle", amount = 2 },
            { type = "item", name = "calcite", amount = 1 },
            { type = "item", name = "protein-powder", amount = 8 },
            { type = "fluid", name = "beta-carotene", amount = 15 },
        },
        results = {
            { type = "item", name = "rabbasca-protein-shake", amount = 2 }
        },
        category = "organic-or-chemistry",
    },
    {
        type = "recipe",
        name = "plastic-bottle",
        enabled = false,
        energy_required = 2,
        ingredients = {
            { type = "item", name = "plastic-bar", amount = 2 },
        },
        results = {
            { type = "item", name = "plastic-bottle", amount = 3 }
        },
        category = "crafting",
    },
    {
        type = "recipe",
        name = "rabbasca-residue-skimming",
        icons = {
            { icon = data.raw["fluid"]["energetic-residue"].icon, scale = 0.7, shift = {0, -8}, icon_size = 64 },
            { icon = data.raw["item"]["plastic-bottle"].icon, icon_size = 64, scale = 0.5, shift = {-12, 12} },
            { icon = data.raw["item"]["spoilage"].icon, icon_size = 64, scale = 0.5, shift = {12, 12} },
            { icon = data.raw["item"]["advanced-circuit"].icon, icon_size = 64, scale = 0.5, shift = {0, 12} },
        },
        enabled = false,
        energy_required = 1.5,
        ingredients = {
            { type = "fluid", name = "energetic-residue", amount = 100 },
        },
        results = {
            { type = "fluid", name = "energetic-residue", amount = 90 },
            { type = "item", name = "spoilage", amount = 1, probability = 0.06 },
            { type = "item", name = "advanced-circuit", amount = 1, probability = 0.05 },
            { type = "item", name = "electronic-circuit", amount = 1, probability = 0.04 },
            { type = "item", name = "plastic-bottle", amount = 1, probability = 0.03 },
        },
        allow_quality = false,
        hide_from_player_crafting = true,
        subgroup = "rabbasca-processes",
        category = "crafting-with-fluid",
        order = "r[alternate-uses]-[skimming]"
    },
    {
        type = "recipe",
        name = "athletic-science-pack",
        enabled = false,
        energy_required = 23,
        ingredients = {
            { type = "item", name = "rabbasca-energetic-concrete", amount = 2 },
            { type = "item", name = "rabbasca-protein-shake", amount = 2 },
            { type = "item", name = "fast-transport-belt", amount = 1 },
            { type = "fluid", name = "harene-gas", amount = 16 },
        },
        results = {
            { type = "item", name = "athletic-science-pack", amount = 5 }
        },
        category = "crafting-with-fluid",
        allow_productivity = true
    },
    {
        type = "recipe",
        name = "vault-access-key",
        enabled = false,
        energy_required = 3,
        ingredients = { 
            {type = "item", name = "advanced-circuit", amount = 8 },
            {type = "item", name = "rabbasca-turbofish", amount = 1 },
            {type = "fluid", name = "beta-carotene", amount = 20 },
        },
        results = { {type = "item", name = "vault-access-key", amount = 2} },
        main_product = "vault-access-key",
        category = "crafting-with-fluid",
        allow_productivity = true,
    },
    {
        type = "recipe",
        name = "vault-security-key",
        enabled = false,
        energy_required = 15,
        ingredients = { 
            {type = "item", name = "vault-access-key", amount = 2 },
            {type = "item", name = "rabbasca-protein-shake", amount = 3 },
            {type = "fluid", name = "harene-gas", amount = 5 },
        },
        results = { {type = "item", name = "vault-security-key", amount = 1} },
        main_product = "vault-security-key",
        category = "crafting-with-fluid",
        allow_productivity = true,
    },
}

data:extend {
    {
        type = "recipe",
        name = "harenic-stabilizer",
        main_product = "harenic-stabilizer",
        category = "chemistry",
        hide_from_player_crafting = true,
        energy_required = 7,
        results = {{type = "item", name = "harenic-stabilizer", amount = 1 }},
        ingredients = {
            { type = "item", name = "calcite", amount = 6 },
            { type = "fluid", name = "beta-carotene", amount = 120 },
        },
        allow_productivity = true,
    },
    {
        type = "recipe",
        name = "rabbasca-energetic-concrete",
        enabled = false,
        main_product = "rabbasca-energetic-concrete",
        category = "crafting-with-fluid",
        hide_from_player_crafting = true,
        energy_required = 5,
        results = {{type = "item", name = "rabbasca-energetic-concrete", amount = 10 }},
        ingredients = {
            { type = "item", name = "harenic-stabilizer", amount = 1 },
            { type = "item", name = "haronite", amount = 5 },
            { type = "item", name = "concrete", amount = 10 },
            { type = "fluid", name = "energetic-residue", amount = 20 },
        },
    },
    {
        type = "recipe",
        name = "haronite-decomposition",
        enabled = false,
        icons = {
            { icon = "__rabbasca-assets__/graphics/recolor/icons/haronite.png", icon_size = 64, scale = 0.4, shift = {0, -12} },
            { icon = "__base__/graphics/icons/stone.png", icon_size = 64, scale = 0.3, shift = {-12, 12} },
            { icon = "__space-age__/graphics/icons/calcite.png", icon_size = 64, scale = 0.3, shift = {12, 12} },
            { icon = "__rabbasca-assets__/graphics/recolor/icons/harene-gas.png", icon_size = 64, scale = 0.3, shift = {0, 12} },
        },
        category = "chemistry",
        hide_from_player_crafting = true,
        energy_required = 3,
        results = {
            {type = "item", name = "stone", amount = 10 },
            {type = "item", name = "calcite", amount = 6 },
            {type = "fluid", name = "harene-gas", amount = 25 },
        },
        ingredients = {
            { type = "item", name = "haronite", amount = 1 },
            { type = "fluid", name = "sulfuric-acid", amount = 15 },
        },
        allow_productivity = true,
        subgroup = "rabbasca-processes",
        order = "r[alternate-uses]-a[haronite]"
    }
}

data:extend {
    {
        type = "recipe",
        name = "rabbasca-hyperfuel",
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "item", name = "rabbasca-turbofuel", amount = 5 },
            { type = "item", name = "promethium-asteroid-chunk", amount = 5 },
            { type = "fluid", name = "harene", amount = 10 },
        },
        results = { 
            { type = "item", name = "rabbasca-hyperfuel", amount = 1 },
        },
        enabled = false,
        allow_productivity = false,
        category = "chemistry-or-cryogenics",
        crafting_machine_tint =
        {
            primary = {r = 0.710, g = 0.633, b = 0.482, a = 1.000},
            secondary = {r = 0.745, g = 0.672, b = 0.527, a = 1.000},
            tertiary = {r = 0.894, g = 0.773, b = 0.596, a = 1.000},
            quaternary = {r = 0.812, g = 0.583, b = 0.202, a = 1.000},
        }
    },
    {
        type = "recipe",
        name = "omega-carotene",
        enabled = false,
        energy_required = 15,
        ingredients = {
            { type = "fluid", name = "beta-carotene", amount = 95 },
            { type = "fluid", name = "harene", amount = 5 },
            { type = "item",  name = "promethium-asteroid-chunk", amount = 5 },
        },
        results = { 
            { type = "fluid", name = "omega-carotene", amount = 100 },
        },
        enabled = false,
        allow_productivity = false,
        category = "chemistry-or-cryogenics",
        crafting_machine_tint =
        {
            primary = {r = 0.710, g = 0.633, b = 0.482, a = 1.000},
            secondary = {r = 0.745, g = 0.672, b = 0.527, a = 1.000},
            tertiary = {r = 0.894, g = 0.773, b = 0.596, a = 1.000},
            quaternary = {r = 0.812, g = 0.583, b = 0.202, a = 1.000},
        }
    },
}

local rocket_part = table.deepcopy(data.raw["recipe"]["rocket-part"])
rocket_part.name = "rocket-part-from-turbofuel"
rocket_part.surface_conditions = { Rabbasca.above_harenic_threshold() }
rocket_part.ingredients = {
    { type = "item", name = "rabbasca-turbofuel", amount = 1 },
    { type = "item", name = "haronite-rocket-frame", amount = 1 },
    { type = "item", name = "processing-unit", amount = 1 },
}

data:extend { rocket_part }
PlanetsLib.assign_rocket_part_recipe("rabbasca", "rocket-part-from-turbofuel")