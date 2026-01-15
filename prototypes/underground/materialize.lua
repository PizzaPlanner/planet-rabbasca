local mod_data = {
    type = "mod-data",
    name = "rabbasca-stabilizer-config",
    data = { planets = { }, water_tiles = { }, stabilization_required = 100 }
}

local function add_planet(name, fluid, entities, lut)
    mod_data.data.planets[name] = {
        water = fluid,
        autoplace_entities = { },
        lut = lut,
        tech = nil,
        tech_prep = nil,
        lut_index = nil
    }
    if entities then
        for _, e in pairs(entities) do 
            mod_data.data.planets[name].autoplace_entities[e] = { }
        end    
    end
end

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

local function create_affinity_tech(planet, unlocked_part, fluid, entities, lut)
  add_planet(planet, fluid, entities, lut)
  local icon = data.raw["planet"][planet].icon
  local tech_pre = {
    type = "technology",
    name = "rabbasca-warp-prep-"..planet,
    icon = "__rabbasca-assets__/graphics/by-openai/warp-matrix.png",
    icon_size = 246,
    prerequisites = { "rabbasca-warp-stabilizer" },
    effects = {
        { 
            type = "nothing",
            icon = icon,
            effect_description = { "rabbasca-extra.stabilizer-recipes-unknown", planet }
        },
        { 
            type = "unlock-recipe",
            recipe = unlocked_part,
        },
    },
    order = "r[warp-tech]-"..planet,
    research_trigger =
    {
        type = "scripted",
        trigger_description = { "technology-description.rabbasca-warp-prep", planet }
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
  mod_data.data.planets[planet].tech = tech_flex.name
  mod_data.data.planets[planet].tech_prep = tech_pre.name
  table.insert(data.raw["assembling-machine"]["rabbasca-warp-pylon"].crafting_categories, "rabbasca-remote-affinity-"..planet)
  data:extend{
    tech_pre,
    tech_flex,
    item,
    affinity_category
  }
end

create_affinity_tech("rabbasca", "rabbasca-spatial-anchor", "harenic-lava", { "rabbasca-lithium-amide", "rabbasca-energy-source" }, "__rabbasca-assets__/graphics/recolor/textures/lut-underground.png")
create_affinity_tech("vulcanus", "rabbasca-holmium-coating", "lava-hot", { "calcite" }, "__rabbasca-assets__/graphics/recolor/textures/lut-underground-vulcanus.png")
create_affinity_tech("gleba", "rabbasca-spacetime-evolutionizer", "water", nil, "__rabbasca-assets__/graphics/recolor/textures/lut-underground-gleba.png")
create_affinity_tech("fulgora", "rabbasca-coordinate-calibrations", "fulgoran-sand", nil, "__rabbasca-assets__/graphics/recolor/textures/lut-underground-gleba.png")

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
}

data:extend{ 
    mod_data,
}