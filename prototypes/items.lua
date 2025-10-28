data:extend {
{
  type = "fuel-category",
  name = "carotene",
  fuel_value_type = {
    "description.food-energy-value"
  },
},
{
    type = "item",
    icon = "__planet-rabbasca__/graphics/gravity-assembler/gravity-assembler-icon.png",
    name = "machining-assembler",
    place_result = "machining-assembler",
    stack_size = 5,
    weight = 200 * kg,
    subgroup = "production-machine",
    order = "fr[machining-assembler]",
},
{
    type = "item",
    name = "rabbasca-remote-builder",
    icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png",
    stack_size = 5,
    place_result = "rabbasca-remote-builder",
    group = "logistics",
    subgroup = "logistic-network",
    order = "c[signal]-r[rabbasca-remote-builder]",
},
{
    type = "item",
    name = "rabbasca-remote-receiver",
    icon = "__FFF339BeaconGraphics__/graphics/alt_beacon_icon.png",
    stack_size = 5,
    place_result = "rabbasca-remote-receiver",
    group = "logistics",
    subgroup = "logistic-network",
    order = "c[signal]-r[rabbasca-remote-receiver]",
},
{
    type = "item",
    icon = "__Krastorio2Assets__/icons/items/imersite-2.png",
    name = "haronite",
    stack_size = 50,
    subgroup = "rabbasca-processes",
    order = "h[haronite]-a[haronite]",
    spoil_ticks = 3 * minute,
    spoil_result = "stone"
},
{
    type = "item",
    icon = "__Krastorio2Assets__/icons/items/imersium-plate.png",
    name = "infused-haronite-plate",
    stack_size = 50,
    subgroup = "rabbasca-processes",
    order = "h[haronite]-d[infused-haronite-plate]",
},
{
    type = "item",
    icon = "__Krastorio2Assets__/icons/items/lithium-2.png",
    name = "rabbasca-turbofin",
    stack_size = 200,
    subgroup = "rabbasca-processes",
    order = "b[organic]-c[turbofin]",
},
{
    type = "item",
    icon = "__planet-rabbasca__/graphics/icons/harenic-stabilizer.png",
    name = "harenic-stabilizer",
    stack_size = 50,
    subgroup = "rabbasca-processes",
    order = "b[processed]-h[harenic-stabilizer]",
},
{
    type = "item",
    icon = "__planet-rabbasca__/graphics/icons/vision-circuit.png",
    name = "vision-circuit",
    stack_size = 100,
    group = "intermediate-products",
    subgroup = "intermediate-product",
    order = "b[circuits]-d[vision-circuit]",
},
{
    type = "item",
    icon = "__planet-rabbasca__/graphics/icons/harene-ears-core.png",
    name = "harene-ears-core",
    stack_size = 5,
    weight = 50 * kg,
    subgroup = "rabbasca-processes",
    order = "v[vault]-d[harene-ears-core]",
    auto_recycle = false,
},
{
    type = "item",
    icons = {
      { icon = "__planet-rabbasca__/graphics/icons/harene-ears-core.png", scale = 0.5, shift = { -8, 0 } },
      { icon = "__planet-rabbasca__/graphics/icons/harene-ears-core.png", scale = 0.5 },
      { icon = "__planet-rabbasca__/graphics/icons/harene-ears-core.png", scale = 0.5, shift = { 8, 0 } },
    },
    name = "harene-ears-subcore",
    stack_size = 50,
    subgroup = "rabbasca-processes",
    order = "v[vault]-d[harene-ears-subcore]",
    auto_recycle = false,
},
{
    type = "item",
    icon = "__base__/graphics/icons/steam-engine.png",
    name = "bunnyhop-engine-equipment",
    stack_size = 1,
    group = "combat",
    subgroup = "equipment",
    order = "r[personal-transport]-b[bunnyhop-engine]",
    place_as_equipment_result = "bunnyhop-engine-equipment"
},
util.merge {
  data.raw["item"]["fusion-reactor-equipment"],
  {
    name = "ears-subcore-reactor-equipment",
    place_as_equipment_result = "ears-subcore-reactor-equipment",
  }
},
{
    type = "capsule",
    icon = "__base__/graphics/icons/steam-engine.png",
    name = "bunnyhop-engine",
    flags = {"only-in-cursor", "not-stackable", "spawnable"},
    auto_recycle = false,
    stack_size = 1,
    group = "others",
    subgroup = "spawnables",
    capsule_action = {
      type = "use-on-self",
      uses_stack = true,
      attack_parameters = {
        type = "projectile",
        activation_type = "activate",
        ammo_category = "capsule",
        cooldown = 2 * minute,
        range = 0,
        ammo_type =
        {
          target_type = "position",
          action =
          {
            type = "direct",
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                {
                  type = "script",
                  effect_id = "rabbasca_teleport"
                }
              }
            }
          }
        }
      }
    },
    order = "b[personal-transport]-b[bunnyhop-engine]-r[remote]",
},
util.merge {
    table.deepcopy(data.raw["capsule"]["raw-fish"]),
    {
      name = "rabbasca-turbofish",
      icon = "__planet-rabbasca__/graphics/icons/turbofish.png",
      spoil_ticks = 3 * minute,
      spoil_result = "protein-powder",
      subgroup = "rabbasca-processes",
      order = "b[organic]-a[turbofish]"
    },
  },
  util.merge {
    table.deepcopy(data.raw["capsule"]["raw-fish"]),
    {
      name = "rabbasca-protein-shake",
      icon = "__planet-rabbasca__/graphics/icons/protein-shake.png",
      spoil_ticks = 0,
      spoil_result = nil,
      fuel_category = "nutrients",
      fuel_value = "25.4MJ",
      subgroup = "rabbasca-processes",
      order = "b[organic]-f[protein-shake]"
    },
},
util.merge { data.raw["item"]["rocket-fuel"],
{
  name = "rabbasca-turbofuel",
  icon = "__planet-rabbasca__/graphics/icons/turbofuel.png",
  fuel_value = "220MJ",
  fuel_top_speed_multiplier = 2.142,
  subgroup = "rabbasca-processes",
  order = "b[processed]-a[rabbasca-turbofuel]"
}},
{
    type = "item",
    icon = "__planet-rabbasca__/graphics/icons/carotenoid.png",
    name = "carotenoid-ore",
    stack_size = 5,
    subgroup = "rabbasca-processes",
    order = "a[raw-resource]-a[carotenoid]",
    fuel_category = "carotene",
    fuel_value = "720kJ"
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/foundation.png",
    name = "harene-infused-foundation",
    stack_size = 20,
    subgroup = "rabbasca-processes",
    order = "z[tbd]",
    place_as_tile =
    {
      result = "harene-infused-foundation",
      condition_size = 1,
      condition = {layers={water_tile=true, ground_tile = true}},
      invert = true,
    }
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/space-platform-foundation.png",
    name = "harene-infused-space-platform",
    stack_size = 50,
    subgroup = "rabbasca-processes",
    order = "z[tbd]",
    place_as_tile =
    {
      result = "harene-infused-space-platform",
      condition_size = 1,
      condition = {layers={empty_space=true}},
      invert = true,
    }
},
{
    type = "item",
    icons = {
      { icon = "__space-age__/graphics/icons/fluid/fluorine.png", tint = { r=0.65, g=0.31, b=0.92 } },
      { icon = "__space-age__/graphics/icons/nutrients.png", scale = 0.3,  }
    },
    name = "protein-powder",
    stack_size = 200,
    subgroup = "rabbasca-processes",
    order = "b[organic]-d[protein-powder]",
},
{
  type = "fluid",
    name = "harene",
    icons = {
      { icon = "__space-age__/graphics/icons/fluid/fluorine.png", tint = { r=0.65, g=0.31, b=0.92 } },
      { icon = "__space-age__/graphics/icons/fluid/electrolyte.png", tint = { 0.9, 0.8, 1 } },
    },
    subgroup = "fluid",
    base_color = {r=0.65, g=0.31, b=0.92},
    flow_color = {r=0.65, g=0.31, b=0.92},
    default_temperature = 1032.0,
    fuel_value = "100MJ",
    auto_barrel = false,
    order = "r[rabbasca]-c[harene]"
},
{
    type = "fluid",
    name = "harene-gas",
    icon = "__space-age__/graphics/icons/fluid/fluorine.png",
    subgroup = "fluid",
    base_color = {r=0.65, g=0.31, b=0.92},
    flow_color = {r=0.65, g=0.31, b=0.92},
    default_temperature = 35.0,
    fuel_value = "1MJ",
    auto_barrel = true,
    order = "r[rabbasca]-b[harene-gas]"
},
{
    type = "fluid",
    name = "beta-carotene",
    icon = "__planet-rabbasca__/graphics/icons/beta-carotene.png",
    subgroup = "fluid",
    base_color = { 0.8, 0.42, 0.02 },
    flow_color = { 0.8, 0.42, 0.02 },
    default_temperature = 14.0,
    auto_barrel = true,
    order = "r[rabbasca]-a[beta-carotene]"
    
},
{
    type = "fluid",
    name = "energetic-residue",
    icon = "__planet-rabbasca__/graphics/icons/energetic-residue.png",
    subgroup = "fluid",
    base_color = {0, 0.14, 0.53},
    flow_color = {0, 0.14, 0.53},
    default_temperature = 72.0,
    fuel_value = "850kJ",
    auto_barrel = true,
    order = "r[rabbasca]-b[energetic-residue]"
},
{
  type = "tool",
  name = "athletic-science-pack",
  icon = "__planet-rabbasca__/graphics/icons/athletic-science-pack.png",
  subgroup = "science-pack",
  order = "j-r[rabbasca]",
  durability = 1,
  stack_size = 200,
},
{
    type = "item",
    name = "haronite-brick",
    icons = { { icon = "__base__/graphics/icons/stone-brick.png", tint = {r=0.65, g=0.31, b=0.92} } },
    stack_size = 50,
    weight = 100 * kg,
    spoil_ticks = 90 * second,
    spoil_result = "stone-brick",
    subgroup = "rabbasca-processes",
    order = "h[haronite]-x[haronite-brick]",
},
util.merge{
  data.raw["item"]["concrete"],
  {
    type = "item",
    name = "rabbasca-energetic-concrete",
    icons = { { icon = "__base__/graphics/icons/concrete.png", tint = {r=0.65, g=0.31, b=0.92} } },
    stack_size = 50,
    place_as_tile =
    {
      result = "rabbasca-energetic-concrete",
    },
    order = "b[concrete]-f[energetic-concrete]",
  }
},
{
    type = "ammo",
    name = "self-replicating-firearm-magazine",
    category = data.raw["ammo"]["firearm-magazine"].category,
    icons = {
      { icon = "__base__/graphics/icons/firearm-magazine.png", tint = { r = 0.95, g = 1, b = 1 }, shift = { -8, -8 } },
      { icon = "__base__/graphics/icons/firearm-magazine.png", tint = { r = 0.95, g = 1, b = 1 }, shift = { 0,   0 } },
      { icon = "__base__/graphics/icons/firearm-magazine.png", tint = { r = 0.95, g = 1, b = 1 }, shift = { 8,   8 } } 
    },
    stack_size = 10,
    weight = 25 * kg,
    ammo_type = table.deepcopy(data.raw["ammo"]["firearm-magazine"].ammo_type),
    ammo_category = "bullet",
    magazine_size = 500,
    spoil_ticks = 20 * second,
    spoil_result = "self-replicating-firearm-magazine"
},
{
    type = "capsule",
    name = "vault-access-key",
    subgroup = "rabbasca-security",
    order = "a[vault-access-key]",
    icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png",
    stack_size = 20,
    capsule_action = {
      type = "throw",
      attack_parameters = {
        type = "projectile",
        ammo_type = {
          action = {
            action_delivery = {
              target_effects = {
                entity_name = "rabbasca-capture-robot",
                show_in_tooltip = true,
                type = "create-entity"
              },
              type = "instant"
            },
            type = "direct"
          },
          target_filter = { "rabbasca-vault" }
        },
        activation_type = "throw",
        ammo_category = "capsule",
        cooldown = 5,
        range = 5,
      }
    }
},
}

local fish_action = table.deepcopy(require("__space-age__.prototypes.item-effects").jellynut_speed)
fish_action.attack_parameters.ammo_type.action.action_delivery.target_effects[1].sticker = "turbofish-speed-sticker"
data.raw["capsule"]["rabbasca-turbofish"].capsule_action = fish_action

local shake_action = table.deepcopy(fish_action)
shake_action.attack_parameters.ammo_type.action.action_delivery.target_effects[1].sticker = "protein-shake-speed-sticker"
data.raw["capsule"]["rabbasca-protein-shake"].capsule_action = shake_action