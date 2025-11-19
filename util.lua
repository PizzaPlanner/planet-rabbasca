local output = {
  rabbasca = {
    is_aps_planet = settings.startup["aps-planet"] and settings.startup["aps-planet"].value == "rabbasca",
    parent = settings.startup["rabbasca-orbits"].value
  }
}

function output.restrict_to_harene_pool(bbox)
    return 
    { 
        area = bbox, 
        required_tiles = { layers = { harene = true } },
        colliding_tiles = { layers = { is_object = true } }, -- must not be empty??
        remove_on_collision = true 
    }
end

function output.create_vault_recipe(input, values)
data:extend{
  util.merge {
    values,
  {
      name = input,
      type = "recipe",
      enabled = false,
      hide_from_signal_gui = false,
      hide_from_player_crafting = true,
      allow_decomposition = false,
      always_show_products = true,
      ingredients = { },
      result_is_always_fresh = true,
      category = "rabbasca-vault-extraction",
      subgroup = "rabbasca-vault-extraction",
      auto_recycle = false, 
  }
}
}
end

function create_infused_thing_with_effect(original, needed_core)
    if original.no_ears_upgrade or original.hidden then return nil end 
    local item = data.raw["item"][original.name]
    -- TODO: should no subgroup be supported? 
    if (not item) or item.hidden or not item.subgroup then return nil end
    local new_name = "harene-infused-"..original.name
    local new = table.deepcopy(original)
    local icons = {}
    if item.icon then
        table.insert(icons, { icon = item.icon, icon_size = item.icon_size or 64 })
    elseif item.icons then
        for _, icon in pairs(table.deepcopy(item.icons)) do
            table.insert(icons, icon)
        end
    end
    local ears_item = data.raw["item"]["harene-ears-core"]
    table.insert(icons, { icon = ears_item.icon, icon_size = ears_item.icon_size, scale = 0.3, shift = {0, 12} })
    local new_item = table.deepcopy(item)
    new_item.name = new_name
    new_item.hidden_in_factoriopedia = true
    new_item.icons = icons
    new_item.place_result = new_name
    new_item.subgroup = (new_item.subgroup or "unknown") .. "-with-ears-core" 
    new_item.factoriopedia_alternative = original.name

    new.name = new_name
    new.localised_name = {"", {"entity-name." .. original.name}, {"rabbasca-extra.with-ears"}}
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
    return new_thing
end


function output.not_on_harenic_surface(proto)
  proto.surface_conditions = proto.surface_conditions or { }
  table.insert(proto.surface_conditions, {property = "harenic-energy-signatures", max = 20})
end

local function is_assembled(recipe)
    local assembled_categories = data.raw["assembling-machine"]["assembling-machine-3"].crafting_categories
    for _, category in pairs(assembled_categories) do
        if not recipe.category or (recipe.category == category) then return true end
        if recipe.additional_categories then 
            for _, add in pairs(recipe.additional_categories) do
                if add == category then return true end
            end
        end
    end
    return false
end

function output.make_complex_machinery(proto, require_assembling_machine_craftable)
  if not proto then return end
  local recipe = data.raw["recipe"][proto.name]
  if not recipe then return end
  if require_assembling_machine_craftable and (not is_assembled(recipe)) then return end
  log("Add complex-machinery to additional_categories of: "..recipe.name)
  recipe.additional_categories = recipe.additional_categories or { }
  table.insert(recipe.additional_categories, "complex-machinery")
end

function output.rabbasca_set_vault_active(e, active)
  if (not e) or e.name ~= "rabbasca-vault-crafter" then return end
  e.active = true -- disabling prevents hp regeneration
  if active then
    e.force = game.forces.player
  else
    e.force = game.forces.rabbascans
  end
end

function output.update_alertness(surface, position)
  local active_vaults_count = #surface.find_entities_filtered { name = "rabbasca-vault-console", force = game.forces.player }
  local new_evo = math.min(1, active_vaults_count * settings.global["rabbasca-evolution-per-vault"].value / 100)
  game.forces.rabbascans.set_evolution_factor(new_evo, surface)
  game.forces.enemy.set_evolution_factor(new_evo, surface) -- make sure factoriopedia evolution ui shows correct value
  storage.hacked_vaults = active_vaults_count
  if not position then return end
  local new_evo_text = "Rabbasca alertness now at: [color=yellow]%.1f%%[/color]"
  for _, player in pairs(game.players) do
    player.create_local_flying_text { text = string.format(new_evo_text, game.forces.rabbascans.get_evolution_factor(surface) * 100), surface = surface, position = position }
  end
end

return output