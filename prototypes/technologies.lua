

data:extend { 
{
    type = "technology",
    name = "planet-discovery-rabbasca",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "planet-discovery-gleba" },
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
        recipe = "rabbasca-turbofin"
      },
      {
        type = "unlock-recipe",
        recipe = "protein-powder"
      }
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "rabbasca-turbofish",
    }
},
{
    type = "technology",
    name = "rabbascan-vault-access",
    icon = "__Krastorio2Assets__/icons/cards/utility-tech-card.png",
    icon_size = 256,
    prerequisites = { "planet-discovery-rabbasca" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harene-copy-core"
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-copyslop"
      },
      {
        type = "unlock-recipe",
        recipe = "lubricant-from-copyslop"
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "blank-vault-key"
    }
},
{
    type = "technology",
    name = "harene-gas-processing",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "oil-gathering", "rabbasca-healthy-fluids" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "power-solution"
      },
      {
        type = "unlock-recipe",
        recipe = "haronite"
      },
    },
    research_trigger =
    {
        type = "mine-entity",
        entity = "harene-vent"
    }
},
{
    type = "technology",
    name = "rabbasca-healthy-fluids",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "planet-discovery-rabbasca" },
    effects =
    {
      {
          type = "unlock-recipe",
          recipe = "beta-carotene"
      },
      {
        type = "unlock-recipe",
        recipe = "vision-circuit",
      },
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "carotenoid",
    }
},
{
    type = "technology",
    name = "rabbasca-vault-core-extraction",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "machining-assembler" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harene-ears-core-capsule"
      }
    },
    research_trigger =
    {
      type = "craft-item",
      item = "machining-assembler"
    }
},
{
    type = "technology",
    name = "rabbasca-ears-technology",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "rabbasca-vault-core-extraction" },
    effects =
    {
      -- added later
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "harene-ears-core-capsule"
    }
},
{
    type = "technology",
    name = "harenic-stabilizer",
    icon = "__space-age__/graphics/technology/gleba.png",
    icon_size = 256,
    prerequisites = { "planet-discovery-rabbasca" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harenic-stabilizer"
      },
    },
    research_trigger =
    {
      type = "mine-entity",
      entity = "moonstone-rock"
    }
},
{
    type = "technology",
    name = "machining-assembler",
    icon = "__space-age__/graphics/technology/foundry.png",
    icon_size = 256,
    prerequisites = { "harenic-stabilizer", "harene-gas-processing", "leg-day-everyday", "item-duplication-2" },
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
      item = "haronite-brick"
    }
},
{
    type = "technology",
    name = "harene-infused-foundations",
    icon = "__space-age__/graphics/technology/foundation.png",
    icon_size = 256,
    prerequisites = { "foundation", "harene-synthesis" },
    unit = {
        count = 2000,
        time = 60,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"space-science-pack", 1},
        }
    },
    effects =
    {
    {
        type = "unlock-recipe",
        recipe = "harene-infused-foundation"
    },
      {
        type = "unlock-recipe",
        recipe = "harene-infused-space-platform"
      },
    },
},
{
    type = "technology",
    name = "harene-synthesis",
    icon = "__space-age__/graphics/technology/steel-plate-productivity.png",
    icon_size = 256,
    prerequisites = { "harene-ears-core", "metallurgic-science-pack", "cryogenic-science-pack" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "harene"
      },
      {
        type = "unlock-recipe",
        recipe = "infused-haronite-plate"
      },
    },
    unit = {
        count = 2000,
        time = 60,
        ingredients = {
          { "metallurgic-science-pack", 1},
          { "cryogenic-science-pack", 1}
        }
    }
},
{
  type = "technology",
  name = "interplanetary-construction",
  icon = "__base__/graphics/technology/radar.png",
  icon_size = 256,
  prerequisites = { "rabbasca-ears-technology", "construction-robotics" },
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "rabbasca-remote-builder",
    },
    {
      type = "unlock-recipe",
      recipe = "rabbasca-remote-receiver",
    },
  },
  unit = {
    count = 1000,
    time = 60,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"space-science-pack", 1},
      {"utility-science-pack", 1},
    }
  }
},
{
  type = "technology",
  name = "bunnyhop-engine",
  icon = "__base__/graphics/technology/engine.png",
  icon_size = 256,
  prerequisites = { "rabbasca-ears-technology", "chemical-science-pack" },
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "bunnyhop-engine",
    },
  },
  unit = {
    count = 400,
    time = 30,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    }
  }
},
{
  type = "technology",
  name = "bunnyhop-engine-range-1",
  icon = "__base__/graphics/technology/engine.png",
  icon_size = 256,
  prerequisites = { "bunnyhop-engine" },
  effects = {

  },
  unit = {
    count = 400,
    time = 60,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"space-science-pack", 1}
    }
  }
},
{
  type = "technology",
  name = "bunnyhop-engine-range-2",
  icon = "__base__/graphics/technology/engine.png",
  icon_size = 256,
  prerequisites = { "bunnyhop-engine-range-1" },
  level = 2,
  max_level = "infinite",
  effects = {

  },
  unit = {
    time = 60,
    count_formula = "1000+300*L",
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"space-science-pack", 1}
    }
  }
},
{
    type = "technology",
    name = "item-duplication-1",
    icon = "__space-age__/graphics/technology/metallurgic-science-pack.png",
    icon_size = 256,
    prerequisites = { "rabbascan-vault-access" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-copy-unpacker",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-iron-plate-duplicate",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-electronic-circuit-duplicate",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-rabbasca-carotene-powder-duplicate",
      },
    },
    research_trigger =
    {
      type = "craft-item",
      item = "harene-copy-core",
      count = 1,
    }
},
{
    type = "technology",
    name = "item-duplication-2",
    icon = "__space-age__/graphics/technology/metallurgic-science-pack.png",
    icon_size = 256,
    prerequisites = { "item-duplication-1" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rabbasca-steel-plate-duplicate",
      },
      {
        type = "unlock-recipe",
        recipe = "rabbasca-advanced-circuit-duplicate",
      },
    },
      research_trigger =
    {
      type = "craft-item",
      item = "harene-copy-core",
      count = 15,
    }
},
{
    type = "technology",
    name = "self-replicating-firearm-magazine",
    icon = "__base__/graphics/technology/military.png",
    icon_size = 256,
    prerequisites = { "harene-ears-core", "military-3" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "self-replicating-firearm-magazine",
      },
    },
    unit = {
      time = 30,
      count = 200,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
        {"space-science-pack", 1}
      }
    }
},
}