data:extend {
    {
        type = "recipe-category",
        name = "harene-transmutation"
    },
    {
        type = "recipe-category",
        name = "harene-synthesis"
    },
    {
        type = "recipe",
        name = "harene-transmute-copper",
        energy_required = 10.0,
        results = { { type = "item", name = "copper-plate", amount = 100 } },
        main_product = "copper-plate",
        category = "harene-transmutation",
    },
    {
        type = "recipe",
        name = "harene-transmute-iron",
        energy_required = 10.0,
        results = { { type = "item", name = "iron-plate", amount = 100 } },
        main_product = "iron-plate",
        category = "harene-transmutation",
    },

    {
        type = "recipe",
        name = "harene-engine",
        energy_required = 25.0,
        ingredients = { 
            {type = "item", name = "steel-plate", amount = 200 },
            -- {type = "item", name = "harene-ears-core", amount = 1 },
            {type = "fluid", name = "fluorine", amount = 150 },
            {type = "item", name = "crystallized-harene", amount = 120 },
        },
        results = { { type = "item", name = "harene-engine", amount = 1 } },
        main_product = "harene-engine",
        category = "smelting",
    },
    {
        type = "recipe",
        name = "crystallized-harene",
        energy_required = 17.0,
        ingredients = { 
            {type = "fluid", name = "harene", amount = 1000 },
            {type = "fluid", name = "sulfuric-acid", amount = 10 },
            {type = "item", name = "carbon-fiber", amount = 3 },
        },
        results = { { type = "item", name = "crystallized-harene", amount = 500 } },
        main_product = "crystallized-harene",
        category = "cryogenics",
    },
    {
        type = "recipe",
        name = "haronite-plate",
        energy_required = 9.0,
        ingredients = { 
            {type = "item", name = "crystallized-harene", amount = 1000 },
            {type = "item", name = "tungsten-ore", amount = 11 },
            {type = "fluid", name = "molten-copper", amount = 200 },
        },
        results = { { type = "item", name = "haronite-plate", amount = 1 } },
        main_product = "haronite-plate",
        category = "smelting",
    },
    {
        type = "recipe",
        name = "harene-thruster",
        energy_required = 20.0,
        ingredients = { 
            {type = "item", name = "haronite-plate", amount = 10 },
            {type = "fluid", name = "lubricant", amount = 200 },
            {type = "item", name = "harene-engine", amount = 1 },
        },
        results = { { type = "item", name = "harene-thruster", amount = 1 } },
        main_product = "harene-thruster",
        category = "crafting-with-fluid",
    },
    {
        type = "recipe",
        name = "harene-synthesis",
        energy_required = 30.0,
        ingredients = { 
            {type = "fluid", name = "beta-carotene", amount = 500 },
            {type = "item", name = "harene-engine", amount = 1 },
        },
        results = { 
            { type = "fluid", name = "harene", amount = 100 },
            { type = "item", name = "harene-engine", amount = 1 },
        },
        main_product = "harene",
        category = "harene-synthesis",
    },
    {
        type = "recipe",
        name = "carotene-inserter",
        energy_required = 0.5,
        ingredients = { 
            {type = "item", name = "rabbasca-carotene-powder", amount = 10 },
            {type = "item", name = "rabbasca-moonstone", amount = 5 },
            {type = "item", name = "burner-inserter", amount = 1 },
        },
        results = { 
            { type = "item", name = "carotene-inserter", amount = 1 },
        },
        main_product = "carotene-inserter",
        category = "crafting",
    },
}