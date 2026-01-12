local mod_data = {
    type = "mod-data",
    name = "rabbasca-materialize-recipes",
    data = { }
}

local function make_materialize_recipe(name, icon, affinity, results, ingredients)
    mod_data.data[affinity] = mod_data.data[affinity] or { }
    table.insert(mod_data.data[affinity], name)
    return {
        type = "recipe",
        name = name,
        icons = {
            { icon = icon },
            { icon = "__rabbasca-assets__/graphics/by-hurricane/custom-atom-forge-icon.png", icon_size = 64, scale = 0.3, shift = {8, 8} },
        },
        energy_required = 20,
        localised_description = { "rabbasca-extra.materialize-recipe-requires", affinity },
        ingredients = ingredients,
        results = results,
        enabled = false,
        auto_recycle = false,
        category = "rabbasca-remote-affinity-"..affinity,
        subgroup = "rabbasca-remote",
        order = "f[materialized]-"..name,
    }
end

local function make_affinity_recipe(name, icon, color, ingredient)
    return {
        type = "recipe",
        name = "rabbasca-initiate-stabilizer-affinity-"..name,
        icons = {
            { icon = icon },
            { icon = "__rabbasca-assets__/graphics/by-hurricane/custom-atom-forge-icon.png", icon_size = 64, scale = 0.3, shift = {8, 8} },
        },
        energy_required = 30,
        ingredients = { { type = "item", name = ingredient, amount = 1 }, { type = "fluid", name = "fusion-plasma", amount = 200 } },
        results = { { type = "item", name = "rabbasca-change-affinity-"..name, amount = 1 } },
        enabled = false,
        auto_recycle = false,
        result_is_always_fresh = true,
        crafting_machine_tint = { primary = color },
        category = "rabbasca-warp-stabilizer",
        subgroup = "rabbasca-warp-stabilizer",
        order = "d[affinity]-"..name,
    }
end
local function create_affinity_tech(planet, icon, color, ingredient, materializers)
  local tech = {
    type = "technology",
    name = "rabbasca-warp-anchoring-"..planet,
    icon = "__rabbasca-assets__/graphics/by-openai/warp-matrix.png",
    icon_size = 246,
    prerequisites = { "rabbasca-warp-stabilizer" },
    effects = { },
    research_trigger =
    {
        type = "craft-item",
        item = "rabbasca-change-affinity-"..planet,
        count = 1
    }
  }
  for _, mat in pairs(materializers) do
    table.insert(tech.effects,       {
        type = "unlock-recipe",
        recipe = "rabbasca-materialize-"..mat
    })
  end
  local affinity_category = {
    type = "recipe-category",
    name = "rabbasca-remote-affinity-"..planet,
  }
  local item = Rabbasca.make_trigger_item({
    name = "rabbasca-change-affinity-"..planet,
    icon = icon
  }, "rabbasca_on_change_affinity")
  local affinity_recipe = make_affinity_recipe(planet, icon, color, ingredient)
  table.insert(data.raw["technology"]["rabbasca-warp-technology-analysis"].prerequisites, tech.name)
  table.insert(data.raw["technology"]["rabbasca-warp-stabilizer"].effects, { type = "unlock-recipe", recipe = affinity_recipe.name})
  table.insert(data.raw["assembling-machine"]["rabbasca-warp-pylon"].crafting_categories, "rabbasca-remote-affinity-"..planet)
  data:extend{
    tech,
    item,
    affinity_recipe,
    affinity_category
  }
end

create_affinity_tech("vulcanus", data.raw["planet"]["vulcanus"].icon, {0.8, 0.36, 0.13}, "rabbasca-warp-matrix", { "coal", "tungsten" })
create_affinity_tech("solar-system-edge", data.raw["space-location"]["solar-system-edge"].icon, {0.14, 0.2, 0.41}, "rabbasca-holmium-coating", { "metallic", "promethium"})
create_affinity_tech("gleba", data.raw["planet"]["gleba"].icon, {0.2, 0.76, 0.42}, "rabbasca-coordinate-calibrations", { "yumako", "pentapod" }, { "rabbasca-spacetime-evolutionizer" })
create_affinity_tech("rabbasca", data.raw["planet"]["rabbasca"].icon, {0.4, 0.14, 0.75}, "rabbasca-spacetime-evolutionizer", { "haronite", "beta-carotene"}, { "rabbasca-spatial-anchor" })

data:extend{
    make_materialize_recipe("rabbasca-materialize-beta-carotene", data.raw["fluid"]["beta-carotene"].icon, "rabbasca",
        {{ type = "fluid", name = "beta-carotene", amount = 100, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 5 }}),
    make_materialize_recipe("rabbasca-materialize-pentapod", data.raw["item"]["pentapod-egg"].icon, "gleba",
        {{ type = "item", name = "pentapod-egg", amount = 1, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 5 }}),
    make_materialize_recipe("rabbasca-materialize-yumako", data.raw["capsule"]["yumako"].icon, "gleba",
        {{ type = "item", name = "yumako", amount = 15, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 5 }}),
    make_materialize_recipe("rabbasca-materialize-haronite", data.raw["item"]["haronite"].icon, "rabbasca",
        {{ type = "item", name = "haronite", amount = 30, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 5 }}),
    make_materialize_recipe("rabbasca-materialize-coal", data.raw["item"]["coal"].icon, "vulcanus",
        {{ type = "item", name = "coal", amount = 12, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 3 }}),
    make_materialize_recipe("rabbasca-materialize-coal", data.raw["item"]["coal"].icon, "vulcanus",
        {{ type = "item", name = "coal", amount = 12, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 3 }}),
    make_materialize_recipe("rabbasca-materialize-tungsten", data.raw["item"]["tungsten-ore"].icon, "vulcanus",
        {{ type = "item", name = "tungsten-ore", amount = 9, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 3 }}),
    make_materialize_recipe("rabbasca-materialize-metallic", data.raw["item"]["metallic-asteroid-chunk"].icon, "solar-system-edge",
        {{ type = "item", name = "iron-ore", amount = 20, }, { type = "item", name = "copper-ore", amount = 8, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 10 }}),
    make_materialize_recipe("rabbasca-materialize-promethium", data.raw["item"]["promethium-asteroid-chunk"].icon, "solar-system-edge",
        {{ type = "item", name = "promethium-asteroid-chunk", amount = 1, }},
        {{ type = "item", name = "rabbasca-warp-matrix", amount = 10 }}),
}

data:extend{ 
    mod_data,
}