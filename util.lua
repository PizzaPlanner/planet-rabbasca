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
      name = reward.name,
      icon = reward.icon,
      icons = reward.icons,
      preserve_products_in_machine_output = false,
      enabled = has_no_prequisite,
      hide_from_player_crafting = true,
      allow_decomposition = false,
      always_show_products = true,
      energy_required = cost,
    --   ingredients = { { type = "item", name = "vault-access-key", amount = 1 } },
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
    local icons = { { icon = data.raw["item"]["harene-copy-core"].icon } }
    if data.raw["item"][item].icon then
        table.insert(icons, { icon = data.raw["item"][item].icon, scale = 0.3 })
    elseif data.raw["item"][item].icons then
        for _, icon in pairs(table.deepcopy(data.raw["item"][item].icons)) do
            icon.scale = (icon.scale or 1) * 0.3
            table.insert(icons, icon)
        end
    end
    data:extend {
    {
        type = "item",
        name = "rabbasca-"..item.."-duplicate",
        icons = icons,
        spoil_ticks = 30 * second,
        spoil_result = item,
        stack_size = data.raw["item"][item].stack_size,
        subgroup = "rabbasca-matter-printer",
    },
    {
        type = "recipe",
        name = "rabbasca-"..item.."-duplicate",
        enabled = false,
        energy_required = 20,
        ingredients = {
            { type = "item", name = "harene-copy-core", amount = 1 },
            { type = "item", name = item, amount = input},
        },
        results = { 
            { type = "item",  name = "rabbasca-"..item.."-duplicate", amount = output, ignored_by_productivity = 1 },
            { type = "fluid", name = "rabbasca-copyslop", amount = 198, ignored_by_productivity = 198 }
        },
        main_product = "rabbasca-"..item.."-duplicate",
        category = "crafting-with-fluid",
        reset_freshness_on_craft = false,
        result_is_always_fresh = true,
        allow_quality = true,
        auto_recycle = false,
        hide_from_player_crafting = true
    },
}
end

function create_infused_thing_with_effect(original, needed_core)
    if original.no_ears_upgrade then return nil end 
    local item = data.raw["item"][original.name]
    if not item then return nil end
    local new_name = "harene-infused-"..original.name
    local new = table.deepcopy(original)
    local icons = {}
    if item.icon then
        table.insert(icons, { icon = item.icon })
    elseif item.icons then
        for _, icon in pairs(table.deepcopy(item.icons)) do
            table.insert(icons, icon)
        end
    end
    table.insert(icons, { icon = data.raw["item"]["harene-ears-core"].icon, scale = 0.3, shift = {0, 12} })
    local new_item = table.deepcopy(item)
    new_item.name = new_name
    new_item.hidden_in_factoriopedia = true
    -- new_item.hidden = true
    new_item.icons = icons
    new_item.place_result = new_name
    new_item.subgroup = new_item.subgroup .. "-with-ears-core" 
    new_item.factoriopedia_alternative = original.name

    new.name = new_name
    new.localised_name = {"", {"entity-name." .. original.name}, " [with E.A.R.S.]"}
    new.factoriopedia_alternative = original.name
    new.hidden_in_factoriopedia = true
    new.hidden = true
    new.icons = icons
    new.no_ears_upgrade = true
    new.next_upgrade = nil
    new.placeable_by = { item = new_name, count = 1 }
    new.minable.result = new_name
    new.factoriopedia_alternative = original.name
    new.tile_buildability_rules = { output.restrict_to_harene_pool(new.collision_box) }
    new.energy_source = util.merge{
        original.energy_source,
        -- rutil.harene_burner()
        { type = "void" }
    }

    if not data.raw["item-subgroup"][new_item.subgroup] then
        data:extend { util.merge {
            table.deepcopy(data.raw["item-subgroup"][item.subgroup]),
            { 
                name = new_item.subgroup,
                group = "rabbasca-extensions" 
            }
        } }
    end
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
            { type = "fluid", name = "harene-gas", amount = needed_core == "harene-ears-core" and 50 or 3 },
            { type = "item", name = original.name, amount = 1},
        },
        results = { { type = "item", name = new_name, amount = 1 } },
        main_product = new_name,
        hide_from_player_crafting = true,
        category = "install-ears-core",
        maximum_productivity = 1
      }
    }
    return new_name
end

-- should be called in data-updates or later to ensure crafter item exists
-- add no_ears_upgrade = true to prototypes to prevent them being added
function output.create_ears_variant(thing, tech, is_small)
    local new_thing = create_infused_thing_with_effect(thing, (is_small and "harene-ears-subcore") or "harene-ears-core")
    if new_thing and data.raw["technology"][tech] then
        local unlocks = data.raw["technology"][tech].effects
        table.insert(unlocks,       
        {
            type = "unlock-recipe",
            recipe = new_thing
        })
    end

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