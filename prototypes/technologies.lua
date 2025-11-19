local function bunnyhop_range(value)
return {
  type = "nothing",
  icon = "__base__/graphics/technology/engine.png",
  icon_size = 256,
  effect_description = { "modifier-description.bunnyhop-engine-range", tostring(value) }
}
end

local function bunnyhop_weight(value)
if settings.startup["rabbasca-bunnyhop-force-naked"].value then return nil end
return {
  type = "nothing",
  icon = "__base__/graphics/technology/engine.png",
  icon_size = 256,
  effect_description = { "modifier-description.bunnyhop-engine-weight", tostring(value) }
}
end

data:extend { 
{
    type = "technology",
    name = "planet-discovery-rabbasca",
    icons = PlanetsLib.technology_icon_moon("__rabbasca-assets__/graphics/recolor/technologies/rabbasca-big.png", 256),
    icon_size = 64,
    prerequisites = { "gun-turret", "power-armor" }, -- and planet discovery from parent in data-updates
    effects = {{
        type = "unlock-space-location",
        space_location = "rabbasca",
        use_icon_overlay_constant = true
    }},
    unit = {
        count = 400,
        time = 60,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"space-science-pack", 1},
        }
    }
},
{
    type = "technology",
    name = "leg-day-everyday",
    icon = "__space-age__/graphics/technology/fish-breeding.png",
    icon_size = 256,
    prerequisites = { "planet-discovery-rabbasca" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "protein-powder"
      },
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "rabbasca-turbofish",
    }
},
{
    type = "technology",
    name = "athletic-science-pack",
    icon = "__rabbasca-assets__/graphics/recolor/technologies/athletic-science-pack-big.png",
    icon_size = 256,
    prerequisites = { "bunnyhop-engine-1", "rabbasca-turbofish-breeding" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "athletic-science-pack"
      }
    },
    research_trigger =
    {
        type = "craft-item",
        item = "bunnyhop-engine-equipment"
    }
},
{
  type = "technology",
  name = "rabbasca-vault-hacking-efficiency",
  icon = "__Krastorio2Assets__/technologies/optimization-tech-card.png",
  icon_size = 256,
  prerequisites = { "athletic-science-pack", "rabbasca-document-forging-1" },
  effects = {
    {
      type = "change-recipe-productivity",
      recipe = "vault-protocol-iron-ore",
      change = 0.25
    },
    {
      type = "change-recipe-productivity",
      recipe = "vault-protocol-copper-ore",
      change = 0.25
    },
    {
      type = "change-recipe-productivity",
      recipe = "vault-protocol-sulfur",
      change = 0.25
    },
    {
      type = "change-recipe-productivity",
      recipe = "vault-protocol-haronite",
      change = 0.1
    }
  },
  max_level = "infinite",
  unit = {
    time = 60,
    count_formula = "300 * (1.5^L)",
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"military-science-pack", 1},
      {"production-science-pack", 1},
      {"athletic-science-pack", 1},
    }
  }
},
{
    type = "technology",
    name = "rabbascan-vault-access",
    icon = "__Krastorio2Assets__/technologies/optimization-tech-card.png",
    icon_size = 256,
    prerequisites = { "planet-discovery-rabbasca" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "vault-protocol-iron-ore"
      },
      {
        type = "unlock-recipe",
        recipe = "vault-protocol-copper-ore"
      },
      {
        type = "unlock-recipe",
        recipe = "vault-protocol-sulfur"
      },
      {
        type = "unlock-recipe",
        recipe = "vault-protocol-water",
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "vault-access-key"
    }
},
{
    type = "technology",
    name = "carotene",
    icon = "__rabbasca-assets__/graphics/recolor/icons/beta-carotene.png",
    icon_size = 64,
    prerequisites = { "planet-discovery-rabbasca" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "beta-carotene"
      },
      {
        type = "unlock-recipe",
        recipe = "carbon-from-carotenoid",
      },
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "carotenoid-ore",
    }
},
{
    type = "technology",
    name = "rabbasca-healthy-fluids",
    icon = "__rabbasca-assets__/graphics/recolor/icons/protein-shake.png",
    icon_size = 64,
    prerequisites = { "carotene", "leg-day-everyday" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "plastic-bottle",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-protein-shake",
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "protein-powder",
    }
},
{
    type = "technology",
    name = "rabbasca-haronite-processing",
    icon = "__rabbasca-assets__/graphics/recolor/icons/haronite.png",
    icon_size = 64,
    prerequisites = { "carotene", "energetic-residue" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "vault-protocol-haronite",
      },
      {
        type = "unlock-recipe",
        recipe = "haronite-decomposition",
      },
      {
        type = "unlock-recipe",
        recipe = "harenic-stabilizer",
      },
    },
    research_trigger =
    {
      type = "craft-fluid",
      fluid = "beta-carotene",
    }
},
{
    type = "technology",
    name = "rabbasca-ears-subcore-technology",
    icon = data.raw["item"]["harene-ears-core"].icon,
    icon_size = 64,
    prerequisites = { "machining-assembler" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "vault-protocol-harene-ears-subcore"
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "machining-assembler"
    }
},
{
    type = "technology",
    name = "rabbasca-ears-technology-1",
    icon = data.raw["item"]["harene-ears-core"].icon,
    icon_size = 64,
    prerequisites = { "athletic-science-pack" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harene-ears-core"
      }
      -- more in data-updates
    },
    unit = {
        count = 100,
        time = 30,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"athletic-science-pack", 1},
        }
    },
},
{
    type = "technology",
    name = "energetic-residue",
    icon = "__rabbasca-assets__/graphics/recolor/icons/energetic-residue.png",
    icon_size = 64,
    prerequisites = { "planet-discovery-rabbasca" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "solid-fuel-from-energetic-residue",
      },
      {
        type = "unlock-recipe",
        recipe = "lubricant-from-energetic-residue",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-residue-skimming",
      },
    },
    research_trigger =
    {
      type = "craft-fluid",
      fluid = "energetic-residue"
    }
},
{
    type = "technology",
    name = "machining-assembler",
    icon = "__rabbasca-assets__/graphics/by-hurricane/gravity-assembler-icon-big.png",
    icon_size = 640,
    prerequisites = { "rabbasca-haronite-processing", "energetic-residue", "rabbascan-vault-access" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-energetic-concrete"
      },
      {
        type = "unlock-recipe",
        recipe = "machining-assembler"
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "harenic-stabilizer"
    }
},
{
  type = "technology",
  name = "bunnyhop-engine-1",
  icon = "__base__/graphics/technology/engine.png",
  icon_size = 256,
  prerequisites = { "rabbasca-ears-subcore-technology", "power-armor" },
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "rabbasca-turbofuel",
    },
    {
      type = "unlock-recipe",
      recipe = "bunnyhop-engine-equipment",
    },
    {
      type = "unlock-recipe",
      recipe = "ears-subcore-reactor-equipment"
    },
    bunnyhop_range(1000),
    bunnyhop_weight(250)
  },
  research_trigger =
  {
    type = "craft-item",
    item = "harene-ears-subcore",
    count = 2,
  }
},
{
  type = "technology",
  name = "bunnyhop-engine-2",
  icon = "__base__/graphics/technology/engine.png",
  icon_size = 256,
  prerequisites = { "athletic-science-pack", "space-science-pack" },
  effects = {
    bunnyhop_range(2000),
    bunnyhop_weight(125)
  },
  level = 2,
  unit = {
    count = 200,
    time = 30,
    ingredients = {
      {"space-science-pack", 1},
      {"athletic-science-pack", 1},
    }
  }
},
{
  type = "technology",
  name = "bunnyhop-engine-3",
  icon = "__base__/graphics/technology/engine.png",
  icon_size = 256,
  level = 3,
  prerequisites = { "bunnyhop-engine-2" },
  effects = {
    bunnyhop_range(2000),
    bunnyhop_weight(125)
  },
  unit = {
    count = 500,
    time = 30,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"space-science-pack", 1},
      {"athletic-science-pack", 1},
    }
  }
},
{
    type = "technology",
    name = "rabbasca-turbofish-breeding",
    icon = "__space-age__/graphics/technology/fish-breeding.png",
    icon_size = 256,
    -- should also depend on biochamber, but that makes tech tree unintuitive in APS
    prerequisites = { "leg-day-everyday", "rabbasca-healthy-fluids" }, 
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-turbofish-breeding"
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "rabbasca-protein-shake",
      count = 10,
    }
},
{
    type = "technology",
    name = "harene-synthesis",
    icons = {
      { icon = "__rabbasca-assets__/graphics/recolor/icons/harene.png", icon_size = 64, scale = 0.8 },
      { icon = data.raw["item"]["haronite-plate"].icon, icon_size = 64, shift = {12, 12}, scale = 0.5 },
    },
    icon_size = 256,
    prerequisites = { "bunnyhop-engine-3", "metallurgic-science-pack", "cryogenic-science-pack" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harene"
      },
      {
        type = "unlock-recipe",
        recipe = "haronite-plate"
      },
      {
        type = "unlock-recipe",
        recipe = "rocket-part-from-turbofuel"
      },
    },
    unit = {
        count = 2000,
        time = 60,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          { "space-science-pack", 1},
          { "production-science-pack", 1},
          { "utility-science-pack", 1},
          { "metallurgic-science-pack", 1},
          { "cryogenic-science-pack", 1},
          { "athletic-science-pack", 1},
        }
    }
},
{
  type = "technology",
  name = "interplanetary-construction",
  icon = "__rabbasca-assets__/graphics/by-hurricane/conduit-icon-big.png",
  icon_size = 640,
  prerequisites = { "rabbasca-ears-technology-1", "rabbasca-document-forging-2" },
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "rabbasca-warp-cargo-pad",
    },
    {
      type = "unlock-recipe",
      recipe = "rabbasca-warp-pylon",
    },
    {
      type = "unlock-recipe",
      recipe = "rabbasca-warp-pylon-recycling",
    },
  },
  research_trigger = {
    type = "capture-spawner",
    entity = "rabbasca-vault-warp-spawner"
  }
},
{
  type = "technology",
  name = "rabbasca-document-forging-1",
  icon = "__Krastorio2Assets__/technologies/advanced-tech-card.png",
  icon_size = 256,
  prerequisites = { "rabbascan-vault-access" },
  level = 1,
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "vault-access-key",
    },
  },
  research_trigger = {
    type = "craft-item",
    item = "vault-access-key",
    count = 200
  }
},
{
  type = "technology",
  name = "rabbasca-document-forging-2",
  icon = "__Krastorio2Assets__/technologies/advanced-tech-card.png",
  icon_size = 256,
  prerequisites = { "rabbasca-document-forging-1", "space-science-pack", "production-science-pack", "military-science-pack", "athletic-science-pack" },
  level = 2,
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "vault-security-key",
    },
  },
  unit = {
    count = 400,
    time = 60,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"space-science-pack", 1},
      {"production-science-pack", 1},
      {"military-science-pack", 1},
      {"athletic-science-pack", 1},
    }
  }
},
{
  type = "technology",
  name = "rabbasca-ears-technology-2",
  icon = data.raw["item"]["harene-ears-core"].icon,
  icon_size = 64,
  prerequisites = { "rabbasca-ears-technology-1", "effect-transmission", "electromagnetic-science-pack" },
  effects =
  {
  },
  level = 2,
  localised_description = { "technology-description.rabbasca-ears-technology-labs" },
  unit = {
    count = 600,
    time = 60,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"space-science-pack", 1},
      {"production-science-pack", 1},
      {"electromagnetic-science-pack", 1},
      {"athletic-science-pack", 1},
    }
  }
},
{
  type = "technology",
  name = "rabbasca-ears-technology-3",
  icon = data.raw["item"]["harene-ears-core"].icon,
  icon_size = 64,
  prerequisites = { "rabbasca-ears-technology-2", "harene-synthesis" },
  effects =
  {
  },
  level = 3,
  localised_description = { "technology-description.rabbasca-ears-technology-silos" },
  unit = {
    count = 1200,
    time = 60,
    ingredients = util.merge { table.deepcopy(data.raw["technology"]["promethium-science-pack"].unit.ingredients), {{"athletic-science-pack", 1}} }
  }
},
}

if settings.startup["rabbasca-cap-bunnyhop-research"].value == false then
data:extend{
{
  type = "technology",
  name = "bunnyhop-engine-4",
  icon = "__base__/graphics/technology/engine.png",
  icon_size = 256,
  prerequisites = { "bunnyhop-engine-3", "utility-science-pack", "production-science-pack" },
  level = 4,
  max_level = "infinite",
  effects = {
    bunnyhop_range(5000),
    bunnyhop_weight(250)
  },
  unit = {
    time = 60,
    count_formula = "1000+300*2^(L-3)",
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"space-science-pack", 1},
      {"production-science-pack", 1},
      {"utility-science-pack", 1},
      {"athletic-science-pack", 1},
    }
  }
},
}
end