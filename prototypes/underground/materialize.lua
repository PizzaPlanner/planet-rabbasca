local mod_data = {
    type = "mod-data",
    name = "rabbasca-attunement-techs",
    data = { }
}

local function make_materialize_recipe(name, type, affinity, results, ingredients)

    table.insert(data.raw["technology"]["rabbasca-warp-anchoring-"..affinity].effects, { type = "unlock-recipe", recipe = "rabbasca-attuned-materialize-"..name })
    return {
        type = "recipe",
        name = "rabbasca-attuned-materialize-"..name,
        icons = {
            { icon = data.raw[type][name].icon, icon_size = 64, scale = 1, shift = {4, 4} },
            { icon = data.raw["tool"]["rabbasca-warp-matrix"].icon, icon_size = 246, scale = 0.15, shift = {-10, -10} },
        },
        energy_required = 10,
        localised_name = { "recipe-name.rabbasca-attuned-materialize", { type == "fluid" and "fluid-name."..name or "item-name."..name } },
        localised_description = { "recipe-description.rabbasca-attuned-materialize", affinity },
        ingredients = ingredients,
        results = results,
        enabled = false,
        auto_recycle = false,
        surface_conditions = { Rabbasca.only_underground(true) },
        category = "rabbasca-remote-affinity-"..affinity,
        subgroup = "rabbasca-remote",
        order = "f[planet]-"..affinity.."-b[materialized]-"..name,
    }
end

local function make_affinity_recipe(name, icon, color)
    return {
        type = "recipe",
        name = "rabbasca-change-affinity-"..name,
        icons = {
            { icon = icon },
            { icon = "__rabbasca-assets__/graphics/by-hurricane/custom-atom-forge-icon.png", icon_size = 64, scale = 0.3, shift = {8, 8} },
        },
        energy_required = 30,
        localised_name = { "recipe-name.rabbasca-change-affinity", { "space-location-name."..name } },
        localised_description = { "recipe-description.rabbasca-change-affinity" },
        ingredients = { { type = "item", name = "rabbasca-warp-matrix", amount = 1 }, { type = "fluid", name = "fusion-plasma", amount = 200 } },
        results = { { type = "item", name = "rabbasca-change-affinity-"..name, amount = 1 } },
        enabled = false,
        auto_recycle = false,
        result_is_always_fresh = true,
        crafting_machine_tint = { primary = color },
        category = "rabbasca-warp-stabilizer",
        subgroup = "rabbasca-remote",
        order = "f[planet]-"..name.."-a",
    }
end
local function create_affinity_tech(planet, icon, color, matrix_count, unlocked_part)
  local tech_pre = {
    type = "technology",
    name = "rabbasca-warp-prep-"..planet,
    icon = "__rabbasca-assets__/graphics/by-openai/warp-matrix.png",
    icon_size = 246,
    prerequisites = { "rabbasca-warp-stabilizer" },
    effects = {
        { 
            type = "unlock-recipe",
            recipe = "rabbasca-change-affinity-"..planet,
        },
        { 
            type = "unlock-recipe",
            recipe = unlocked_part,
        },
    },
    order = "r[warp-tech]-"..matrix_count,
    research_trigger =
    {
        type = "craft-item",
        item = "rabbasca-warp-matrix",
        count = matrix_count
    }
  }
  local tech_flex = {
    type = "technology",
    name = "rabbasca-warp-anchoring-"..planet,
    icon = "__rabbasca-assets__/graphics/by-openai/warp-matrix.png",
    icon_size = 246,
    hidden = true,
    prerequisites = { "rabbasca-warp-prep-"..planet },
    effects = { },
    localised_name = { "technology-name.rabbasca-warp-anchoring", planet },
    localised_description = { "technology-description.rabbasca-warp-anchoring", planet },
    research_trigger =
    {
        type = "scripted",
        trigger_description = { "rabbasca-extra.trigger-set-affinity", planet }
    }
  }
  local affinity_category = {
    type = "recipe-category",
    name = "rabbasca-remote-affinity-"..planet,
  }
  local item = Rabbasca.make_trigger_item({
    name = "rabbasca-change-affinity-"..planet,
    icon = icon,
    localised_name = "item-name.rabbasca-change-affinity",
    subgroup = "rabbasca-warp-stabilizer"
  }, "rabbasca_on_change_affinity")
  local affinity_recipe = make_affinity_recipe(planet, icon, color)
  mod_data.data[tech_flex.name] = planet
  table.insert(data.raw["assembling-machine"]["rabbasca-warp-pylon"].crafting_categories, "rabbasca-remote-affinity-"..planet)
  data:extend{
    tech_pre,
    tech_flex,
    item,
    affinity_recipe,
    affinity_category
  }
end

create_affinity_tech("vulcanus", data.raw["planet"]["vulcanus"].icon, {0.8, 0.36, 0.13}, 10, "rabbasca-holmium-coating")
create_affinity_tech("solar-system-edge", data.raw["space-location"]["solar-system-edge"].icon, {0.14, 0.2, 0.41}, 50, "rabbasca-coordinate-calibrations")
create_affinity_tech("gleba", data.raw["planet"]["gleba"].icon, {0.2, 0.76, 0.42}, 100, "rabbasca-spacetime-evolutionizer")
create_affinity_tech("rabbasca", data.raw["planet"]["rabbasca"].icon, {0.4, 0.14, 0.75}, 150, "rabbasca-spatial-anchor")

data:extend{
    make_materialize_recipe("beta-carotene", "fluid", "rabbasca",
        {{ type = "fluid", name = "beta-carotene", amount = 100, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 1 }}),
    make_materialize_recipe("haronite", "item", "rabbasca",
        {{ type = "item", name = "haronite", amount = 30, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 1 }}),
    make_materialize_recipe("pentapod-egg", "item", "gleba",
        {{ type = "item", name = "pentapod-egg", amount = 1, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 1 }}),
    make_materialize_recipe("yumako", "capsule", "gleba",
        {{ type = "item", name = "yumako", amount = 15, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 1 }}),
    make_materialize_recipe("coal", "item", "vulcanus",
        {{ type = "item", name = "coal", amount = 12, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 1 }}),
    make_materialize_recipe("tungsten-ore", "item", "vulcanus",
        {{ type = "item", name = "tungsten-ore", amount = 9, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 1 }}),
    make_materialize_recipe("metallic-asteroid-chunk", "item", "solar-system-edge",
        {{ type = "item", name = "iron-ore", amount = 20, }, { type = "item", name = "copper-ore", amount = 8, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 1 }}),
    make_materialize_recipe("promethium-asteroid-chunk", "item", "solar-system-edge",
        {{ type = "item", name = "promethium-asteroid-chunk", amount = 1, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 1 }}),
}

data:extend{ 
    mod_data,
}