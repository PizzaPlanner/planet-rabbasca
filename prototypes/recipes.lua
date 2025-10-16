local recycling = require("__quality__.prototypes.recycling")
local r = require("__planet-rabbasca__.util")

data:extend {
    {
        type = "item-subgroup",
        name = "rabbasca-processes",
        group = "intermediate-products",
        order = data.raw["item-subgroup"]["fulgora-processes"].name .."-b"
    },
    {
        type = "item-subgroup",
        name = "rabbasca-vault-access",
        group = "rabbasca-extensions",
        order = "z"
    },
    {
        type = "item-subgroup",
        name = "rabbasca-vault-extraction",
        group = "rabbasca-extensions",
        order = "a"
    },
    {
        type = "item-subgroup",
        name = "rabbasca-matter-printer",
        group = "intermediate-products",
        order = "r[rabbasca]-a[duplication]"
    },
    {
        type = "item-group",
        name = "rabbasca-extensions",
        icon = data.raw["item"]["harene-ears-core"].icon,
        icon_size = 64,
        order = "fr"
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
        name = "power-solution",
        energy_required = 5.0,
        enabled = false,
        ingredients = { 
            {type = "fluid", name = "harene-gas",    amount = 5 },
            {type = "fluid", name = "beta-carotene", amount = 40 },
            {type = "item", name = "iron-plate",     amount = 1 },
        },
        results = { 
            { type = "item", name = "power-solution", amount = 3 },
        },
        hide_from_player_crafting = true,
        main_product = "power-solution",
        category = "organic-or-chemistry",
        allow_productivity = true,
    },
    {
        type = "recipe",
        name = "beta-carotene",
        energy_required = 5.0,
        enabled = false,
        ingredients = { 
            {type = "fluid", name = "energetic-residue", amount = 30 },
            {type = "item", name = "rabbasca-carotene-powder", amount = 100 },
        },
        results = { { type = "fluid", name = "beta-carotene", amount = 60 } },
        main_product = "beta-carotene",
        hide_from_player_crafting = true,
        category = "organic-or-chemistry",
        allow_productivity = true,
    },
    {
        type = "recipe",
        name = "haronite",
        -- enabled = false,
        energy_required = 20,
        ingredients = { 
            {type = "fluid", name = "harene-gas", amount = 100 },
            {type = "item",  name = "stone", amount = 5 },
            {type = "item",  name = "power-solution", amount = 1 },
        },
        results = { 
            { type = "item", name = "haronite", amount = 5  },
        },
        main_product = "haronite",
        category = "chemistry",
        hide_from_player_crafting = true,
        result_is_always_fresh = true,
        reset_freshness_on_craft = true,
        preserve_products_in_machine_output = true,
        allow_productivity = true,
    },
    {
        type = "recipe",
        name = "harene",
        enabled = false,
        energy_required = 80,
        ingredients = { 
            {type = "item",  name = "harenic-stabilizer", amount = 5 },
            {type = "item",  name = "haronite", amount = 10 },
            {type = "fluid",  name = "ammonia", amount = 50 },
        },
        results = { 
            { type = "fluid", name = "harene", amount = 15 },
        },
        main_product = "harene",
        category = "cryogenics",
    },
    {
        type = "recipe",
        name = "infused-haronite-plate",
        enabled = false,
        energy_required = 8,
        ingredients = { 
            {type = "item",  name = "steel-plate",    amount = 20 },
            {type = "item",  name = "tungsten-plate", amount = 5  },
            {type = "fluid", name = "harene", amount = 5 },
        },
        results = { 
            { type = "item", name = "infused-haronite-plate", amount = 10  },
            { type = "item", name = "tungsten-carbide", amount = 2 },
            { type = "fluid", name = "molten-iron", amount = 20 },
        },
        main_product = "infused-haronite-plate",
        category = "metallurgy",
    },
    {
        type = "recipe",
        name = "machining-assembler",
        enabled = false,
        energy_required = 20.0,
        ingredients = { 
            -- {type = "item", name = "infused-haronite-plate", amount = 10 },
            {type = "item", name = "steel-plate", amount = 200 },
            {type = "item", name = "tungsten-plate", amount = 10 },
            {type = "item", name = "iron-gear-wheel", amount = 69 },
            {type = "item", name = "rabbasca-energetic-concrete", amount = 50 },
            {type = "item", name = "advanced-circuit", amount = 50 },
            {type = "fluid", name = "lubricant", amount = 200 },
        },
        results = { { type = "item", name = "machining-assembler", amount = 1 } },
        surface_conditions = {{property = "harenic-energy-signatures", min = 50 }},
        main_product = "machining-assembler",
        category = "crafting-with-fluid",
    },
    {
        type = "recipe",
        name = "rabbasca-remote-receiver",
        enabled = false,
        energy_required = 5,
        ingredients = { 
            {type = "item", name = "harene-ears-core", amount = 1 },
            {type = "item", name = "vision-circuit",  amount = 20 },
            {type = "item", name = "iron-gear-wheel",   amount = 30 },
            {type = "item", name = "tungsten-plate",   amount = 2 },
            {type = "item", name = "radar",   amount = 1 },
        },
        results = { 
            { type = "item", name = "rabbasca-remote-receiver", amount = 1 },
        },
        surface_conditions = {{property = "harenic-energy-signatures", min = 50}},
        main_product = "rabbasca-remote-receiver",
        category = "crafting"
    },
        {
        type = "recipe",
        name = "rabbasca-remote-builder",
        enabled = false,
        energy_required = 5,
        ingredients = { 
            {type = "item", name = "vision-circuit",  amount = 20 },
            {type = "item", name = "iron-gear-wheel",   amount = 30 },
            {type = "item", name = "superconductor",   amount = 5 },
        },
        results = { 
            { type = "item", name = "rabbasca-remote-builder", amount = 1 },
        },
        surface_conditions = {{property = "harenic-energy-signatures", min = 50}},
        main_product = "rabbasca-remote-builder",
        category = "crafting"
    },
    {
        type = "recipe",
        name = "solid-fuel-from-energetic-residue",
        category = "chemistry",
        energy_required = 1,
        ingredients =
        {
            {type = "fluid", name = "energetic-residue", amount = 20 },
            {type = "item", name = "ice", amount = 5 },
        },
        results =
        {
            { type = "item", name = "solid-fuel", amount = 5 }
        },
        allow_productivity = true,
        icon = "__base__/graphics/icons/solid-fuel-from-light-oil.png",
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
        name = "rocket-fuel-from-energetic-residue",
        category = "chemistry",
        energy_required = 30,
        ingredients =
        {
            {type = "fluid", name = "energetic-residue", amount = 10 },
            { type = "item", name = "solid-fuel", amount = 50 }
        },
        results =
        {
            { type = "item", name = "rocket-fuel", amount = 5 }
        },
        allow_productivity = true,
        icon = "__base__/graphics/icons/solid-fuel-from-light-oil.png",
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
        name = "vision-circuit",
        enabled = false,
        energy_required = 7,
        ingredients = {
            {type = "item", name = "electronic-circuit", amount = 5 }, 
            {type = "item", name = "advanced-circuit", amount = 1 },
            {type = "fluid", name = "beta-carotene", amount = 10  },

        },
        results = { 
            { type = "item", name = "vision-circuit", amount = 1 },
        },
        main_product = "vision-circuit",
        category = "electronics-with-fluid",
        allow_productivity = true,
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
            -- {type = "item", name = "harene-glob-core", amount = 1 },
            {type = "item", name = "power-solution", amount = 500 },
            {type = "item", name = "rabbasca-energetic-concrete", amount = 100 },
            {type = "item", name = "electric-engine-unit", amount = 50 },
            {type = "item", name = "rabbasca-turbofin", amount = 100 },
            {type = "item", name = "vision-circuit", amount = 200 }
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
        name = "rabbasca-turbofish-breeding",
        enabled = false,
        energy_required = 15,
        ingredients = { 
            {type = "item",  name = "rabbasca-turbofish", amount = 2 },
            {type = "item",  name = "protein-powder", amount = 5  },
            {type = "fluid", name = "beta-carotene", amount = 50 },
        },
        results = { 
            { type = "item", name = "rabbasca-turbofish", amount = 3, ignored_by_productivity = 2 },
        },
        main_product = "rabbasca-turbofish",
        category = "organic",
        allow_productivity = true,
        subgroup = "nauvis-agriculture",
        order = "b[nauvis-agriculture]-b[turbofish-breeding]"
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
    },
    {
        type = "recipe",
        name = "rabbasca-turbofin",
        enabled = false,
        energy_required = 1,
        ingredients = { 
            {type = "item", name = "rabbasca-turbofish", amount = 1 },
        },
        results = { {type = "item", name = "rabbasca-turbofin", amount = 2 } },
        main_product = "rabbasca-turbofin",
        category = "crafting",
    },
    {
        type = "recipe",
        name = "harene-ears-subcore",
        enabled = false,
        energy_required = 4,
        ingredients = { 
            {type = "item", name = "harene-ears-core", amount = 1 },
        },
        results = { {type = "item", name = "harene-ears-subcore", amount = 20 } },
        main_product = "harene-ears-subcore",
        category = "crafting",

    },
    {
        type = "recipe",
        name = "harene-copy-core",
        enabled = false,
        energy_required = 8,
        ingredients = { 
            { type = "fluid", name = "rabbasca-copyslop", amount = 200 },
            { type = "fluid", name = "energetic-residue", amount = 5 },
        },
        results = { {type = "item", name = "harene-copy-core", amount = 1, ignored_by_productivity = 1} },
        main_product = "harene-copy-core",
        category = "chemistry-or-cryogenics",
        hide_from_player_crafting = true,
        subgroup = "rabbasca-matter-printer",
        order = "a[copy-core]"
    },
    {
        type = "recipe",
        name = "lubricant-from-copyslop",
        icons = { 
            { icon = data.raw["fluid"]["rabbasca-copyslop"].icon, scale = 0.4, shift = { -8, -8 } },
            { icon = data.raw["fluid"]["lubricant"].icon },
        },
        enabled = false,
        energy_required = 5.0,
        hide_from_player_crafting = true,
        ingredients = { 
            {type = "fluid", name = "rabbasca-copyslop", amount = 10 },
        },
        results = { { type = "fluid", name = "lubricant", amount = 100 } },
        main_product = "lubricant",
        category = "crafting-with-fluid",
        subgroup = "rabbasca-matter-printer",
        order = "r[alternate-uses]"

    },
    {
        type = "recipe",
        name = "self-replicating-firearm-magazine",
        enabled = false,
        energy_required = 12,
        ingredients = {
            { type = "item", name = "harene-copy-core", amount = 1 },
            { type = "item", name = "firearm-magazine", amount = 100 },
        },
        results = { { type = "item", name = "self-replicating-firearm-magazine", amount = 1 } },
        category = "crafting",
        subgroup = "ammo",
        order = "a[basic-clips-extended]-a[self-replicating-firearm-magazine]"
    },
    {
        type = "recipe",
        name = "rabbasca-cargo-wagon",
        enabled = false,
        energy_required = 3,
        ingredients = {
            { type = "item", name = "cargo-wagon", amount = 1 },
            { type = "item", name = "modular-armor", amount = 1 },
        },
        results = { { type = "item", name = "rabbasca-cargo-wagon", amount = 1 } },
        category = "crafting"
    },
    {
        type = "recipe",
        name = "vault-access-key",
        enabled = false,
        energy_required = 3,
        ingredients = { 
            {type = "item", name = "advanced-circuit", amount = 20 },
            {type = "item", name = "vision-circuit", amount = 5 },
            {type = "item", name = "rabbasca-turbofin", amount = 1 },
            {type = "fluid", name = "beta-carotene", amount = 20 },
        },
        results = { {type = "item", name = "vault-access-key", amount = 1} },
        main_product = "vault-access-key",
        category = "crafting-with-fluid",
        allow_productivity = true,
    },
    {
        type = "recipe",
        name = "harene-powered-space-platform-starter-pack",
        enabled = false,
        energy_required = 30,
        ingredients = { 
            {type = "item", name = "harene-ears-core", amount = 1 },
            {type = "item", name = "space-platform-starter-pack", amount = 1 },
        },
        results = { {type = "item", name = "harene-powered-space-platform-starter-pack", amount = 1} },
        main_product = "harene-powered-space-platform-starter-pack",
        category = "crafting",
    }
}

-- r.create_vault_recipe("harene-glob-core",  3, 35,  false)
r.create_vault_recipe(data.raw["simple-entity"]["harene-ears-core-capsule"], 60,  false)
r.create_vault_recipe(data.raw["simple-entity"]["harene-copy-core-capsule"], 30,   true)
-- r.create_vault_recipe("harenic-stabilizer",    1, 2.5, false)
-- create_vault_recipe("rabbascan-encrypted-vault-data", 10, 3, true)
-- create_vault_recipe("harene-cubic-core", 1, 10, false)

r.create_duplication_recipe("iron-plate", 1, 100)
r.create_duplication_recipe("steel-plate", 1, 20)
r.create_duplication_recipe("rabbasca-carotene-powder", 1, 200)
r.create_duplication_recipe("electronic-circuit", 1, 150)
r.create_duplication_recipe("advanced-circuit",   1, 25)
-- create_duplication_recipe("vault-access-key",    1, 2)

-- r.create_duplication_recipe_triggered("uranium-rounds-magazine")
-- r.create_duplication_recipe("uranium-rounds-magazine", 1, 10)
-- r.create_duplication_recipe_triggered("plastic")
-- r.create_duplication_recipe("plastic", 1, 35)
-- r.create_duplication_recipe_triggered("explosives")
-- r.create_duplication_recipe("explosives", 1, 10)

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
            { type = "item", name = "rabbasca-carotene-powder", amount = 15 },
            { type = "fluid", name = "water", amount = 120 },
        },
        allow_productivity = true,
    },
    {
        type = "recipe",
        name = "haronite-brick",
        main_product = "haronite-brick",
        category = "smelting",
        reset_freshness_on_craft = true,
        result_is_always_fresh = true,
        hide_from_player_crafting = true,
        energy_required = 10,
        results = {{type = "item", name = "haronite-brick", amount = 1 }},
        ingredients = {
            { type = "item", name = "haronite", amount = 1 },
        },
        allow_productivity = true,
    },
    {
        type = "recipe",
        name = "rabbasca-energetic-concrete",
        main_product = "rabbasca-energetic-concrete",
        category = "crafting-with-fluid",
        hide_from_player_crafting = true,
        energy_required = 5,
        results = {{type = "item", name = "rabbasca-energetic-concrete", amount = 10 }},
        ingredients = {
            { type = "item", name = "harenic-stabilizer", amount = 1 },
            { type = "item", name = "haronite-brick", amount = 5 },
            { type = "item", name = "rabbasca-turbofin", amount = 5 },
            { type = "item", name = "iron-stick", amount = 16 },
            { type = "fluid", name = "energetic-residue", amount = 20 },
        },
    },
    {
        type = "recipe",
        name = "harene-infused-foundation",
        energy_required = 20,
        enabled = false,
        ingredients = { 
            -- {type = "item", name = "harene-glob-core", amount = 1 },
            {type = "item", name = "infused-haronite-plate", amount = 4 },
            {type = "item", name = "foundation", amount = 1 },
        },
        results = { 
            { type = "item", name = "harene-infused-foundation", amount = 1 },
        },
        main_product = "harene-infused-foundation",
        category = "crafting",
    },
    {
        type = "recipe",
        name = "harene-infused-space-platform",
        enabled = false,
        energy_required = 20,
        ingredients = { 
            -- {type = "item", name = "harene-glob-core", amount = 1 },
            {type = "item", name = "infused-haronite-plate", amount = 4 },
            {type = "item", name = "space-platform-foundation", amount = 1 },
        },
        results = { 
            { type = "item", name = "harene-infused-space-platform", amount = 1 },
        },
        main_product = "harene-infused-space-platform",
        category = "crafting-with-fluid",
    },
}

data:extend {
    {
        type = "recipe",
        name = "rabbasca-vault-activate",
        enabled = true,
        hidden = true,
        hidden_in_factoriopedia = true,
        energy_required = 3,
        ingredients = {{ type = "item", name = "vault-access-key", amount = 1 }},
        results = {{ type = "item", name = "rabbasca-vault-access-protocol", amount = 1 }},
        main_product = "rabbasca-vault-access-protocol",
        category = "rabbasca-vault-hacking",
        subgroup = "rabbasca-vault-access",
        auto_recycle = false,
        overload_multiplier = 1,
        result_is_always_fresh = true,
        allow_inserter_overload = false,
        hide_from_player_crafting = true
    },
    {
        type = "recipe",
        name = "rabbasca-vault-deactivate",
        hidden_in_factoriopedia = true,
        energy_required = 3,
        ingredients = { },
        results = {{ type = "item", name = "rabbasca-vault-access-protocol", amount = 1 }},
        main_product = "rabbasca-vault-access-protocol",
        category = "rabbasca-vault-hacking",
        subgroup = "rabbasca-vault-access",
        order = "z[vault]-z[shutdown]",
        auto_recycle = false,
        overload_multiplier = 1,
        result_is_always_fresh = true,
        allow_inserter_overload = false,
        hide_from_player_crafting = true
    },
    {
        type = "recipe",
        name = "rabbasca-vault-regenerate-core",
        icon = data.raw["virtual-signal"]["signal-hourglass"].icon,
        enabled = true,
        hidden = true,
        energy_required = 3600,
        ingredients = { },
        results = { {type = "item", name = "rabbasca-vault-access-protocol", amount = 1} },
        category = "rabbasca-vault-hacking",
        subgroup = "rabbasca-vault-access",
        auto_recycle = false,
        overload_multiplier = 1,
        result_is_always_fresh = true,
        allow_inserter_overload = false,
        hide_from_player_crafting = true
    }
}