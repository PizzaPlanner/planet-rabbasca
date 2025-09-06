local recycling = require("__quality__.prototypes.recycling")

function create_vault_recipe(reward, amount, cost, has_no_prequisite)
data:extend{
  {
      type = "recipe",
      name = "rabbasca-offering-"..reward,
      preserve_products_in_machine_output = false,
      enabled = has_no_prequisite,
      hide_from_player_crafting = true,
      allow_decomposition = false,
      always_show_products = true,
      energy_required = cost,
      results = { { type = "item", name = reward, amount = amount, percent_spoiled = 0 } },
      reset_freshness_on_craft = true,
      result_is_always_fresh = true,
      main_product = reward,
      category = "rabbasca-vault-extraction",
      auto_recycle = false,
      overload_multiplier = 1,
  }
}
end

function recycle_core(name, retrieved_name)
  local rec  = data.raw["recipe"][name]
  if rec then
    rec.auto_recycle = false
    rec.allow_as_intermediate = false
  end 
  local item  = data.raw["item"][name]
  if not item then return end
  recycling.generate_self_recycling_recipe(item)
  local recipe = data.raw["recipe"][item.name.."-recycling"]
  recipe.hidden = false
  recipe.enabled = false
  recipe.category = "recycling-or-hand-crafting"
  recipe.results = {{type = "item", name = retrieved_name, amount = 1, probability = 1, ignored_by_stats = 1}}
  recipe.energy_required = (data.raw.recipe[item.name] and data.raw.recipe[item.name].energy_required or 0.5 )/2
end

data:extend {
    {
        type = "item-subgroup",
        name = "rabbasca",
        group = "production"
    },
    {
        type = "recipe-category",
        name = "harene-transmutation"
    },
    {
        type = "recipe-category",
        name = "harene-synthesis"
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
        name = "harene-transmute-copper",
        enabled = false,
        energy_required = 10.0,
        results = { { type = "item", name = "copper-plate", amount = 100 } },
        main_product = "copper-plate",
        category = "harene-transmutation",
    },
    {
        type = "recipe",
        name = "harene-transmute-iron",
        enabled = false,
        energy_required = 10.0,
        results = { { type = "item", name = "iron-plate", amount = 100 } },
        main_product = "iron-plate",
        category = "harene-transmutation",
    },
    {
        type = "recipe",
        name = "smart-solution",
        enabled = false,
        energy_required = 10.0,
        ingredients = { 
            {type = "fluid", name = "beta-carotene", amount = 50 },
            {type = "item", name = "protein-powder", amount = 3 },
        },
        results = { { type = "item", name = "smart-solution", amount = 5 } },
        main_product = "smart-solution",
        category = "organic-or-chemistry",
    },
    {
        type = "recipe",
        name = "energetic-residue",
        energy_required = 5.0,
        ingredients = { 
            {type = "item", name = "harene-infused-moonstone", amount = 1 },
        },
        results = { 
            { type = "fluid", name = "energetic-residue", amount = 50 },
            { type = "item", name = "rabbasca-moonstone", amount = 1 } 
        },
        hide_from_player_crafting = true,
        main_product = "energetic-residue",
        category = "organic-or-chemistry",
    },
    {
        type = "recipe",
        name = "beta-carotene",
        energy_required = 5.0,
        ingredients = { 
            {type = "fluid", name = "energetic-residue", amount = 10 },
            {type = "item", name = "rabbasca-carotene-powder", amount = 200 },
        },
        results = { { type = "fluid", name = "beta-carotene", amount = 200 } },
        main_product = "beta-carotene",
        hide_from_player_crafting = true,
        category = "organic-or-chemistry",
    },
    {
        type = "recipe",
        name = "harene-infused-moonstone",
        enabled = false,
        energy_required = 44,
        ingredients = { 
            {type = "item", name = "rabbasca-moonstone", amount = 1 },
            {type = "fluid", name = "harene", amount = 10 },
        },
        results = { { type = "item", name = "harene-infused-moonstone", amount = 1 } },
        main_product = "harene-infused-moonstone",
        category = "harene-transmutation",
    },
    {
        type = "recipe",
        name = "haronite",
        enabled = false,
        energy_required = 5.5,
        ingredients = { 
            {type = "item", name = "rabbasca-moonstone", amount = 1 },
            {type = "item", name = "rabbasca-carotene-powder", amount = 200 },
            {type = "fluid", name = "energetic-residue", amount = 30 },
        },
        results = { 
            { type = "item", name = "haronite", amount = 20  },
        },
        main_product = "haronite",
        category = "organic-or-chemistry",
    },
    {
        type = "recipe",
        name = "infused-haronite-plate",
        enabled = false,
        energy_required = 4.7,
        ingredients = { 
            {type = "item", name = "haronite", amount = 75 },
            {type = "fluid", name = "harene", amount = 100 },
        },
        results = { 
            { type = "item", name = "infused-haronite-plate", amount = 50  },
        },
        main_product = "infused-haronite-plate",
        category = "harene-transmutation",
    },
    {
        type = "recipe",
        name = "harene-thruster",
        enabled = false,
        energy_required = 20.0,
        ingredients = { 
            {type = "item", name = "infused-haronite-plate", amount = 10 },
            {type = "fluid", name = "lubricant", amount = 200 },
            -- {type = "item", name = "harene-engine", amount = 1 },
        },
        results = { { type = "item", name = "harene-thruster", amount = 1 } },
        main_product = "harene-thruster",
        category = "crafting-with-fluid",
    },
    {
        type = "recipe",
        name = "carotene-inserter",
        enabled = false,
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
    {
        type = "recipe",
        name = "harene-transmuter",
        enabled = false,
        energy_required = 10,
        ingredients = { 
            {type = "item", name = "harene-ears-core", amount = 1 },
        },
        results = { 
            { type = "item", name = "harene-transmuter", amount = 1 },
        },
        main_product = "harene-transmuter",
        category = "crafting"
    },
    {
        type = "recipe",
        name = "harene-extractor",
        enabled = false,
        energy_required = 10,
        ingredients = { 
            {type = "item", name = "harene-ears-core", amount = 1 },
            {type = "item", name = "haronite",   amount = 10 },
        },
        results = { 
            { type = "item", name = "harene-extractor", amount = 1 },
        },
        main_product = "harene-extractor",
        category = "crafting"
    }, 
    {
        type = "recipe",
        name = "harenic-chemical-plant",
        enabled = false,
        energy_required = 10,
        ingredients = { 
            {type = "item", name = "harene-ears-core", amount = 1 },
        },
        results = { 
            { type = "item", name = "harenic-chemical-plant", amount = 1 },
        },
        main_product = "harenic-chemical-plant",
        category = "crafting"
    },
    {
        type = "recipe",
        name = "moonstone-pipe",
        enabled = false,
        energy_required = 5,
        ingredients = { 
            {type = "item", name = "harene-infused-moonstone", amount = 1 },
            {type = "item", name = "rabbasca-carotene-powder",   amount = 200 },
        },
        results = { 
            { type = "item", name = "moonstone-pipe", amount = 20 },
        },
        main_product = "moonstone-pipe",
        category = "crafting",
    },
    {
        type = "recipe",
        name = "harene-infused-foundation",
        energy_required = 60,
        enabled = false,
        ingredients = { 
            {type = "item", name = "rabbasca-carotene-powder", amount = 100 },
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
        energy_required = 10,
        ingredients = { 
            {type = "item", name = "rabbasca-moonstone", amount = 5 },
            {type = "item", name = "harene-infused-foundation", amount = 1 },
            {type = "item", name = "low-density-structure", amount = 20 },
            {type = "fluid", name = "fluorine", amount = 50 },
        },
        results = { 
            { type = "item", name = "harene-infused-space-platform", amount = 10 },
        },
        main_product = "harene-infused-space-platform",
        category = "crafting-with-fluid",
    },
    {
        type = "recipe",
        name = "supercharged-jellynut-seed",
        enabled = false,
        energy_required = 5,
        ingredients = { 
            {type = "item", name = "jellynut-seed", amount = 5 },
            {type = "fluid", name = "energetic-residue", amount = 100 },
        },
        results = { 
            { type = "item", name = "supercharged-jellynut-seed", amount = 5 },
        },
        main_product = "supercharged-jellynut-seed",
        category = "organic",
    },
    {
        type = "recipe",
        name = "bunnyhop-engine",
        enabled = false,
        energy_required = 15,
        ingredients = { 
            {type = "item", name = "harene-ears-core", amount = 1 },
            {type = "item", name = "harene-glob-core", amount = 1 },
            {type = "item", name = "smart-solution", amount = 20 },
            {type = "item", name = "infused-haronite-plate", amount = 20 },
            {type = "item", name = "rabbasca-turbofin", amount = 100 },
        },
        results = { 
            { type = "item", name = "bunnyhop-engine", amount = 1 },
        },
        main_product = "bunnyhop-engine",
        category = "crafting",
    },
    {
        type = "recipe",
        name = "rabbasca-turbofish",
        enabled = false,
        energy_required = 5,
        ingredients = { 
            {type = "item", name = "raw-fish", amount = 10 },
            {type = "fluid", name = "harene", amount = 1 },
            {type = "fluid", name = "beta-carotene", amount = 50 },
        },
        results = { 
            { type = "item", name = "rabbasca-turbofish", amount = 10 },
        },
        main_product = "rabbasca-turbofish",
        category = "organic-or-chemistry",
    },
    {
        type = "recipe",
        name = "ultranutritious-science-pack",
        enabled = false,
        energy_required = 17,
        ingredients = { 
            {type = "item", name = "smart-solution", amount = 2 },
            {type = "item", name = "infused-haronite-plate", amount = 1 },
        },
        results = { 
            { type = "item", name = "ultranutritious-science-pack", amount = 6 },
        },
        main_product = "ultranutritious-science-pack",
        category = "crafting",
    },
    {
        type = "recipe",
        name = "moonstone-chest",
        enabled = false,
        energy_required = 2,
        ingredients = { 
            {type = "item", name = "harene-glob-core", amount = 1 },
            {type = "item", name = "infused-haronite-plate", amount = 5 },
        },
        results = { 
            { type = "item", name = "moonstone-chest", amount = 1 },
        },
        main_product = "moonstone-chest",
        category = "crafting",
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
            { type = "item", name = "protein-powder", amount = 20 },
        },
        main_product = "protein-powder",
        category = "crafting",
    },
    {
        type = "recipe",
        name = "rabbasca-turbofin",
        enabled = false,
        energy_required = 1,
        ingredients = { 
            {type = "item", name = "rabbasca-turbofish", amount = 1 },
        },
        results = { {type = "item", name = "rabbasca-turbofin", amount = 2} },
        main_product = "rabbasca-turbofin",
        category = "crafting",
    },
    {
        type = "recipe",
        name = "rabbascan-security-key-a",
        enabled = false,
        energy_required = 0.5,
        ingredients = { 
            {type = "item", name = "infused-haronite-plate", amount = 1 },
            {type = "item", name = "rabbasca-turbofin", amount = 2 },
        },
        results = { {type = "item", name = "rabbascan-security-key-a", amount = 3} },
        main_product = "rabbascan-security-key-a",
        category = "crafting",
    },
    {
        type = "recipe",
        name = "rabbascan-security-key-e",
        enabled = false,
        energy_required = 5,
        ingredients = { 
            {type = "item", name = "infused-haronite-plate", amount = 1 },
            {type = "item", name = "rabbasca-turbofin", amount = 1 },
            {type = "item", name = "rabbasca-carotene-powder", amount = 20 },
        },
        results = { {type = "item", name = "rabbascan-security-key-e", amount = 3} },
        main_product = "rabbascan-security-key-e",
        category = "crafting",
    }
    -- {
    --     type = "recipe",
    --     name = "harene-ears-core",
    --     enabled = false,
    --     energy_required = 30,
    --     ingredients = { 
    --         { type = "item", name = "harene-engine", amount = 1 },
    --         { type = "item", name = "harene-cubic-core", amount = 3 },
    --     },
    --     results = { 
    --         { type = "item", name = "harene-ears-core", amount = 1 },
    --         { type = "item", name = "harene-cubic-core", amount = 1 },
    --     },
    --     main_product = "harene-ears-core",
    --     category = "crafting",
    -- },
    -- {
    --     type = "recipe",
    --     name = "harene-glob-core",
    --     enabled = false,
    --     energy_required = 30,
    --     ingredients = { 
    --         { type = "item", name = "harene-infused-moonstone", amount = 4 },
    --         { type = "item", name = "harene-cubic-core", amount = 3 },
    --     },
    --     results = { 
    --         { type = "item", name = "harene-glob-core", amount = 1 },
    --         { type = "item", name = "harene-cubic-core", amount = 1 },
    --     },
    --     main_product = "harene-glob-core",
    --     category = "crafting",
    -- },
}

recycle_core("harenic-chemical-plant", "harene-ears-core")
recycle_core("bunnyhop-engine", "harene-ears-core")
recycle_core("harene-transmuter", "harene-ears-core")
recycle_core("harene-extractor", "harene-ears-core")
recycle_core("moonstone-chest", "harene-glob-core")
recycle_core("small-harenide-collider", "harene-cubic-core")


create_vault_recipe("harene-ears-core",  1, 8,  false)
create_vault_recipe("harene-glob-core",  3, 5,  false)
create_vault_recipe("harene-cubic-core", 1, 10, false)
create_vault_recipe("rabbascan-encrypted-vault-data", 5, 3, true)
-- create_vault_recipe("harene-cubic-core", 1, 10, false)

data:extend {
    {
        type = "recipe",
        name = "hack-rabbascan-vault-extraction",
        icon = "__Krastorio2Assets__/icons/cards/utility-tech-card.png",
        -- enabled = false,
        -- hidden = true,
        energy_required = 5,
        ingredients = { 
            {type = "item", name = "rabbascan-security-key-e", amount = 1 },
        },
        results = { 
            { type = "item", name = "rabbasca-vault-access-protocol", amount = 1  },
        },
        category = "rabbasca-vault-hacking",
        auto_recycle = false,
        reset_freshness_on_craft = true,
        result_is_always_fresh = true,
        overload_multiplier = 1,
        allow_inserter_overload = false,
        hide_from_player_crafting = true
    },
    {
        type = "recipe",
        name = "hack-rabbascan-vault-research",
        icon = "__Krastorio2Assets__/icons/cards/matter-tech-card.png",
        -- enabled = false,
        -- hidden = true,
        energy_required = 5,
        ingredients = { 
            {type = "item", name = "rabbascan-security-key-a", amount = 1 },
        },
        results = { 
            { type = "item", name = "rabbasca-vault-access-protocol", amount = 1  },
        },
        category = "rabbasca-vault-hacking",
        auto_recycle = false,
        reset_freshness_on_craft = true,
        result_is_always_fresh = true,
        overload_multiplier = 1,
        allow_inserter_overload = false,
        hide_from_player_crafting = true
    },
    {
        type = "recipe",
        name = "rabbasca-sabotage-console",
        -- enabled = false,
        -- hidden = true,
        energy_required = 7,
        ingredients = { 
            {type = "item", name = "rabbasca-moonstone", amount = 1 },
        },
        results = { 
            { type = "item", name = "rabbasca-vault-access-protocol", amount = 1  },
            { type = "item", name = "rabbasca-console-scrap", amount = 35  },
            { type = "item", name = "infused-haronite-plate", amount = 3  },
        },
        main_product = "rabbasca-console-scrap",
        category = "rabbasca-vault-hacking",
        auto_recycle = false,
        reset_freshness_on_craft = true,
        result_is_always_fresh = true,
        overload_multiplier = 1,
        allow_inserter_overload = false,
        hide_from_player_crafting = true
    },
}