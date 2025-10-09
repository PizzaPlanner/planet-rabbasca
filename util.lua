local output = {}

function output.restrict_to_harene_pool(bbox)
    return 
    { 
        area = bbox, 
        required_tiles = { layers = { harene = true } },
        colliding_tiles = { layers = { is_object = true } }, -- must not be empty??
        remove_on_collision = true 
    }
end

function output.harene_burner()
    return 
    {  
        type = "burner",
        fuel_inventory_size = 1,
        burnt_inventory_size = 1,
        fuel_categories = {"rabbasca-infused-core-fuel"},
        initial_fuel = "rabbasca-infused-haronite-core",
        initial_fuel_percent = 1,
    } 
end


function output.create_vault_recipe(reward, cost, has_no_prequisite)
data:extend{
  {
      type = "recipe",
      name = reward,
      preserve_products_in_machine_output = false,
      enabled = has_no_prequisite,
      hide_from_player_crafting = true,
      allow_decomposition = false,
      always_show_products = true,
      energy_required = cost,
    --   ingredients = { { type = "item", name = "blank-vault-key", amount = 1 } },
      results = { { type = "item", name = "rabbasca-vault-core-extraction-protocol", amount = 1, percent_spoiled = 0 } },
      reset_freshness_on_craft = true,
      result_is_always_fresh = true,
    --   main_product = reward,
      category = "rabbasca-vault-extraction",
      subgroup = "rabbasca-vault-extraction",
      auto_recycle = false, 
      overload_multiplier = 1,
  }
}
end

function output.create_duplication_recipe(item, input, output)
    if not data.raw["item"][item] then return end
    local icons = {{icon = data.raw["item"]["harene-copy-core"].icon, scale = 0.7 }}
    if data.raw["item"][item].icon then
        table.insert(icons, { icon = data.raw["item"][item].icon, scale = 0.5 })
    elseif data.raw["item"][item].icons then
        for _, icon in pairs(table.deepcopy(data.raw["item"][item].icons)) do
            icon.scale = (icon.scale or 1) * 0.5
            table.insert(icons, icon)
        end
    end
    local icons_unpack = table.deepcopy(icons)
    icons_unpack[1].shift = {-8, -8}
    for i, entry in ipairs(icons_unpack) do
        if i > 1 then
            entry.shift = {8, 8}
        end
    end
    data:extend {
    {
        type = "item",
        name = "rabbasca-"..item.."-duplicate",
        icons = icons,
        spoil_ticks = 3 * minute,
        spoil_result = "harene-copy-core",
        stack_size = data.raw["item"][item].stack_size / output,
        subgroup = "rabbasca-matter-printer",
    },
    {
        type = "recipe",
        name = "rabbasca-"..item.."-duplicate",
        enabled = false,
        energy_required = 30,
        ingredients = {
            { type = "item", name = "harene-copy-core", amount = 1 },
            { type = "item", name = item, amount = input},
        },
        results = { 
            { type = "item", name = "rabbasca-"..item.."-duplicate", amount = 1, ignored_by_productivity = 1 } 
        },
        main_product = "rabbasca-"..item.."-duplicate",
        category = "crafting",
        reset_freshness_on_craft = true,
        result_is_always_fresh = true,
        allow_quality = false,
        auto_recycle = false,
        hide_from_player_crafting = true
    },
    {
        type = "recipe",
        name = "rabbasca-"..item.."-deduplicate",
        enabled = true,
        icons = icons_unpack,
        energy_required = 5,
        ingredients = {
            { type = "item", name = "rabbasca-"..item.."-duplicate", amount = 1 },
        },
        results = { 
            { type = "item", name = item, amount = output },
            { type = "item", name = "harene-copy-core-recharging", amount = 1, ignored_by_productivity = 1 },
         },
        -- main_product = item,
        subgroup = "rabbasca-matter-printer-unpack",
        category = "rabbasca-matter-printer-unpack",
        reset_freshness_on_craft = true,
        result_is_always_fresh = true,
        auto_recycle = false,
        hide_from_player_crafting = true
    },
}
end

function get_type(crafter)
    for _, type in pairs({"assembling-machine", "lab", "rocket-silo", "furnace", "inserter"}) do
        if data.raw[type][crafter] then return type end
    end
    return nil
end

function create_infused_thing_with_effect(crafter, effect, add_effect_amount)
    local type = get_type(crafter) -- TODO: how to raise error?
    local original = data.raw[type][crafter]
    local new_name = effect and "harene-infused-"..original.name.."-"..effect or "harene-infused-"..original.name
    local new = table.deepcopy(original)
    local icons = {}
    if data.raw["item"][crafter].icon then
        table.insert(icons, { icon = data.raw["item"][crafter].icon, scale = 0.8 })
    elseif data.raw["item"][crafter].icons then
        for _, icon in pairs(table.deepcopy(data.raw["item"][crafter].icons)) do
            icon.scale = (icon.scale or 1) * 0.8
            table.insert(icons, icon)
        end
    end
    local needed_core = type == "inserter" and "harene-ears-subcore" or "harene-ears-core"
    table.insert(icons, { icon = data.raw["item"][needed_core].icon, scale = 0.5, shift = {0, 12} })
    if effect then
        local effect_icon = "efficiency-module-3"
        if effect == "speed" then effect_icon = "speed-module-3"
        elseif effect == "quality" then effect_icon = "quality-module-3"
        elseif effect == "productivity" then effect_icon = "productivity-module-3"
        end
        if data.raw["module"][effect_icon] then
            table.insert(icons, { icon = data.raw["module"][effect_icon].icon, scale = 0.3, shift = {12, -12} })
        end
    end
    local new_item = table.deepcopy(data.raw["item"][crafter])
    new_item.name = new_name
    new_item.hidden_in_factoriopedia = true
    new_item.hidden = true
    new_item.icons = icons
    new_item.place_result = new_name
    new_item.subgroup = type == inserter and "inserter-infused" or "production-machine-infused" 
    new_item.factoriopedia_alternative = original.name

    new.name = new_name
    new.factoriopedia_alternative = original.name
    new.hidden_in_factoriopedia = true
    new.hidden = true
    new.icons = icons
    new.next_upgrade = nil
    if effect then 
        new.effect_receiver = new.effect_receiver or { base_effect = { } }
        local prev_effect = new.effect_receiver.base_effect[effect] or 0
        new.effect_receiver.base_effect[effect] = prev_effect + add_effect_amount
    end
    new.placeable_by = { item = new_name, count = 1 }
    new.minable.result = new_name
    new.factoriopedia_alternative = crafter
    new.tile_buildability_rules = { output.restrict_to_harene_pool(new.collision_box) }
    new.energy_source = util.merge{
        original.energy_source,
        -- rutil.harene_burner()
        { type = "void" }
    }

    data:extend {
      new,
      new_item,
      {
        type = "recipe",
        name = new_name,
        enabled = false,
        energy_required = 30,
        ingredients = {
            { type = "item", name = needed_core, amount = 1 },
            { type = "fluid", name = "harene-gas", amount = needed_core == "harene_ears_core" and 50 or 3 },
            { type = "item", name = original.name, amount = 1},
        },
        results = { { type = "item", name = new_name, amount = 1 } },
        main_product = new_name,
        category = "install-ears-core",
        maximum_productivity = 0
      }
    }
    local unlocks = data.raw["technology"]["rabbasca-ears-technology"].effects
    table.insert(unlocks,       
    {
        type = "unlock-recipe",
        recipe = new_name
    })
end

-- should be called in data-updates or later to ensure crafter item exists
function output.create_infused_crafter(crafter)
    -- create_infused_crafter_with_effect(crafter, "speed", 0.5)
    -- create_infused_crafter_with_effect(crafter, "quality", 5)
    -- create_infused_crafter_with_effect(crafter, "productivity", 0.5)
    create_infused_thing_with_effect(crafter, nil, 0)
end
function output.create_infused_mini(thing)
    create_infused_thing_with_effect(thing, nil, 0)
end

function output.create_duplication_recipe_triggered(item)
    local item = data.raw["item"][item]
    if not item then return end
    data:extend{{
        type = "technology",
        name = item.name.."-duplication",
        icon = item.icon,
        icons = item.icons,
        icon_size = 256,
        prerequisites = { "item-duplication-2" },
        effects =
        {
        {
            type = "unlock-recipe",
            recipe = "rabbasca-"..item.name.."-duplicate",
        },
        },
        research_trigger =
        {
            type = "craft-item",
            item = item.name,
            quality = "legendary",
            comparator = "=",
            count = 5,
        }
    }}
end

function output.not_on_harenic_surface(proto)
  proto.surface_conditions = proto.surface_conditions or { }
  table.insert(proto.surface_conditions, {property = "harenic-energy-signatures", max = 50})
end

function output.make_complex_machinery(proto)
  local recipe = data.raw["recipe"][proto.name]
  if not recipe then return end
  recipe.additional_categories = recipe.additional_categories or { }
  table.insert(recipe.additional_categories, "complex-machinery")
end

return output