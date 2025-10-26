data:extend {
util.merge {
  data.raw["item-with-entity-data"]["cargo-wagon"],
  {
    name = "rabbasca-cargo-wagon",
    stack_size = 1,
    place_result = "rabbasca-cargo-wagon"
  }
},
util.merge {
  data.raw["item-with-entity-data"]["locomotive"],
  {
    name = "rabbasca-locomotive",
    stack_size = 1,
    place_result = "rabbasca-locomotive"
  }
},
util.merge { data.raw["item"]["rocket-fuel"],
{
  name = "rabbasca-turbofuel",
  fuel_value = "220MJ",
  fuel_top_speed_multiplier = 2.142,
  subgroup = "rabbasca-processes",
  order = "f[rabbasca-turbofuel]"
}},
util.merge { data.raw["cargo-wagon"]["cargo-wagon"],
{
  name = "rabbasca-cargo-wagon",
  equipment_grid = "train-equipment-grid",
  mineable = { result = "rabbasca-cargo-wagon" },
  placeable_by = { item = "rabbasca-cargo-wagon", count = 1 },
  quality_affects_inventory_size = true,
  allow_robot_dispatch_in_automatic_mode = true,
}},
util.merge { data.raw["locomotive"]["locomotive"],
{
  name = "rabbasca-locomotive",
  equipment_grid = "train-equipment-grid",
  mineable = { result = "rabbasca-locomotive" },
  placeable_by = { item = "rabbasca-locomotive", count = 1 },
  energy_sourcy = { type = "void" }
}},
{
    type = "recipe",
    name = "rabbasca-cargo-wagon",
    enabled = false,
    energy_required = 3,
    ingredients = {
        { type = "item", name = "cargo-wagon", amount = 1 },
        { type = "item", name = "modular-armor", amount = 1 },
    },
    results = { { type = "item", name = "rabbasca-cargo-wagon", amount = 1 } },
    category = "crafting"
},
{
    type = "recipe",
    name = "rabbasca-locomotive",
    enabled = false,
    energy_required = 3,
    ingredients = {
        { type = "item", name = "locomotive", amount = 1 },
        { type = "item", name = "modular-armor", amount = 1 },
    },
    results = { { type = "item", name = "rabbasca-locomotive", amount = 1 } },
    category = "crafting"
},
{
    type = "recipe",
    name = "rabbasca-turbofuel",
    enabled = false,
    energy_required = 10,
    ingredients = {
        { type = "item", name = "rabbasca-turbofish", amount = 1 },
        { type = "fluid", name = "harene-gas", amount = 10 },
        { type = "item", name = "solid-fuel", amount = 2 },
    },
    results = { 
        { type = "item", name = "rabbasca-turbofuel", amount = 1 },
    },
    enabled = false,
    category = "chemistry",
    crafting_machine_tint =
    {
        primary = {r = 0.710, g = 0.633, b = 0.482, a = 1.000},
        secondary = {r = 0.745, g = 0.672, b = 0.527, a = 1.000},
        tertiary = {r = 0.894, g = 0.773, b = 0.596, a = 1.000},
        quaternary = {r = 0.812, g = 0.583, b = 0.202, a = 1.000},
    }
},
{
  type = "technology",
  name = "rabbasca-railway",
  icon = data.raw["technology"]["railway"].icon,
  icon_size = 256,
  prerequisites = { "bunnyhop-engine", "railway" },
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "rabbasca-cargo-wagon"
    },
    {
      type = "unlock-recipe",
      recipe = "rabbasca-locomotive"
    },
    {
      type = "unlock-recipe",
      recipe = "rabbasca-turbofuel"
    },
  },
  unit = {
    count = 150,
    time = 30,
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"space-science-pack", 1},
    }
  }
},
}