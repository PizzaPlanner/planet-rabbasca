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
    icon = "__rabbasca-assets__/graphics/by-hurricane/gravity-assembler-icon.png",
    icon_size = 64,
    name = "machining-assembler",
    place_result = "machining-assembler",
    stack_size = 5,
    weight = 100 * kg,
    subgroup = "production-machine",
    order = "fr[machining-assembler]",
},
{
    type = "item",
    icon = "__rabbasca-assets__/graphics/recolor/icons/haronite.png",
    icon_size = 64,
    name = "haronite",
    stack_size = 50,
    weight = 20*kg,
    subgroup = "rabbasca-processes",
    order = "h[haronite]-a[haronite]",
    spoil_ticks = 5 * minute,
    spoil_result = "stone"
},
{
    type = "item",
    icon = "__Krastorio2Assets__/icons/items/imersium-plate.png",
    icon_size = 64,
    name = "haronite-plate",
    stack_size = 50,
    subgroup = "rabbasca-processes",
    order = "h[haronite]-d[haronite-plate]",
},
{
    type = "item",
    icon = "__rabbasca-assets__/graphics/recolor/icons/harenic-stabilizer.png",
    icon_size = 64,
    name = "harenic-stabilizer",
    stack_size = 50,
    subgroup = "rabbasca-processes",
    order = "b[processed]-h[harenic-stabilizer]",
},
{
    type = "item",
    icon = "__rabbasca-assets__/graphics/recolor/icons/harene-ears-core.png",
    icon_size = 64,
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
      { icon = "__rabbasca-assets__/graphics/recolor/icons/harene-ears-core.png", icon_size = 64, scale = 0.5, shift = { -8, 0 } },
      { icon = "__rabbasca-assets__/graphics/recolor/icons/harene-ears-core.png", icon_size = 64, scale = 0.5 },
      { icon = "__rabbasca-assets__/graphics/recolor/icons/harene-ears-core.png", icon_size = 64, scale = 0.5, shift = { 8, 0 } },
    },
    name = "harene-ears-subcore",
    stack_size = 50,
    weight = 5 * kg,
    subgroup = "rabbasca-processes",
    order = "v[vault]-d[harene-ears-subcore]",
    auto_recycle = false,
},
{
    type = "item",
    icon = "__base__/graphics/icons/steam-engine.png",
    icon_size = 64,
    name = "bunnyhop-engine-equipment",
    stack_size = 1,
    group = "combat",
    subgroup = "equipment",
    order = "r[personal-transport]-b[bunnyhop-engine]",
    place_as_equipment_result = "bunnyhop-engine-equipment",
    custom_tooltip_fields = {
      {
        name = {"tooltip.bunnyhop-engine-weight-multiplier"},
        value = {"tooltip-value.bunnyhop-engine-weight-multiplier", "100"},
        -- show_in_tooltip = false,
        quality_header = "quality-tooltip.increases",
        quality_values = { },
      }
    }
},
util.merge {
  data.raw["item"]["fusion-reactor-equipment"],
  {
    name = "ears-subcore-reactor-equipment",
    place_as_equipment_result = "ears-subcore-reactor-equipment",
    weight = 100 * kg,
  }
},
{
    type = "capsule",
    icon = "__base__/graphics/icons/steam-engine.png",
    icon_size = 64,
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
      icon = "__rabbasca-assets__/graphics/recolor/icons/turbofish.png",
      icon_size = 64,
      spoil_ticks = 3 * minute,
      spoil_result = "spoilage",
      subgroup = "rabbasca-processes",
      order = "b[organic]-a[turbofish]"
    },
  },
  util.merge {
    table.deepcopy(data.raw["capsule"]["raw-fish"]),
    {
      name = "rabbasca-protein-shake",
      icon = "__rabbasca-assets__/graphics/recolor/icons/protein-shake.png",
      icon_size = 64,
      spoil_ticks = 0,
      spoil_result = nil,
      weight = 20 * kg,
      fuel_category = "nutrients",
      fuel_value = "17.63MJ",
      burnt_result = "plastic-bottle",
      subgroup = "rabbasca-processes",
      order = "b[organic]-f[protein-shake]"
    },
},
util.merge { data.raw["item"]["rocket-fuel"],
{
  name = "rabbasca-turbofuel",
  icon = "__rabbasca-assets__/graphics/recolor/icons/turbofuel.png",
  icon_size = 64,
  fuel_value = "220MJ",
  fuel_top_speed_multiplier = 2.142,
  subgroup = "rabbasca-processes",
  order = "b[processed]-a[rabbasca-turbofuel]"
}},
{
    type = "item",
    icon = "__rabbasca-assets__/graphics/recolor/icons/carotenoid.png",
    icon_size = 64,
    name = "carotenoid-ore",
    stack_size = 5,
    weight = 100 * kg,
    subgroup = "rabbasca-processes",
    order = "a[raw-resource]-a[carotenoid]",
    fuel_category = "carotene",
    fuel_value = "720kJ"
},
{
    type = "item",
    icons = {
      { icon = "__rabbasca-assets__/graphics/recolor/icons/harene-gas.png", icon_size = 64 },
      { icon = "__space-age__/graphics/icons/nutrients.png", scale = 0.3, icon_size = 64  }
    },
    name = "protein-powder",
    stack_size = 200,
    subgroup = "rabbasca-processes",
    order = "b[organic]-d[protein-powder]",
},
{
    type = "item",
    name = "plastic-bottle",
    icon = "__rabbasca-assets__/graphics/recolor/icons/plastic-bottle.png",
    stack_size = 200,
    subgroup = "rabbasca-processes",
    order = "b[processed]-a[bottle]",
},
{
    type = "item",
    icon = "__rabbasca-assets__/graphics/by-hurricane/conduit-icon.png",
    icon_size = 64,
    name = "rabbasca-warp-core",
    stack_size = 5,
    weight = 100*kg,
    subgroup = "rabbasca-security",
    order = "x[rabbasca-warp-core]",
},
{
  type = "fluid",
    name = "harene",
    icon = "__rabbasca-assets__/graphics/recolor/icons/harene.png",
    icon_size = 64,
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
    icon = "__rabbasca-assets__/graphics/recolor/icons/harene-gas.png",
    icon_size = 64,
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
    icon = "__rabbasca-assets__/graphics/recolor/icons/beta-carotene.png",
    icon_size = 64,
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
    icon = "__rabbasca-assets__/graphics/recolor/icons/energetic-residue.png",
    icon_size = 64,
    subgroup = "fluid",
    base_color = {0, 0.14, 0.53},
    flow_color = {0, 0.14, 0.53},
    default_temperature = 72.0,
    fuel_value = "850kJ",
    auto_barrel = true,
    order = "r[rabbasca]-b[energetic-residue]"
},
util.merge { data.raw["tool"]["automation-science-pack"], {
  name = "athletic-science-pack",
  icon = "__rabbasca-assets__/graphics/recolor/icons/athletic-science-pack.png",
  icon_size = 64,
  order = "j-r[rabbasca]",
  weight = 0.1 * kg,
  stack_size = 500
}},
util.merge{
  data.raw["item"]["concrete"],
  {
    type = "item",
    name = "rabbasca-energetic-concrete",
    icons = { { icon = "__base__/graphics/icons/concrete.png", tint = {r=0.65, g=0.31, b=0.92}, icon_size = 64 } },
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
    name = "vault-access-key",
    subgroup = "rabbasca-security",
    order = "a[vault-access-key]",
    icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png",
    icon_size = 64,
    stack_size = 20,        
    ammo_type = {
      action = {
        action_delivery = {
          source_effects = {
            entity_name = "explosion-gunshot",
            only_when_visible = true,
            type = "create-explosion",
          },
          target_effects = {
            entity_name = "rabbasca-capture-robot",
            show_in_tooltip = true,
            type = "create-entity"
          },
          type = "instant"
        },
        type = "direct"
      },
      target_filter = { "rabbasca-vault-spawner" }
    },
    ammo_category = "bullet",
    shoot_protected = true,
    reload_time = 2 * second
},
{
    type = "ammo",
    icon = "__Krastorio2Assets__/icons/cards/advanced-tech-card.png",
    icon_size = 64,
    name = "vault-security-key",
    subgroup = "rabbasca-security",
    order = "a[vault-security-key]",
    stack_size = 5,
    ammo_type = {
      action = {
        action_delivery = {
          source_effects = {
            entity_name = "explosion-gunshot",
            only_when_visible = true,
            type = "create-explosion",
          },
          target_effects = {
            entity_name = "rabbasca-capture-robot-2",
            show_in_tooltip = true,
            type = "create-entity"
          },
          type = "instant"
        },
        type = "direct"
      },
      target_filter = { "rabbasca-vault-spawner", "rabbasca-vault-warp-spawner" }
    },
    ammo_category = "bullet",
    shoot_protected = true,
    reload_time = 2 * second
},
}

local fish_action = table.deepcopy(require("__space-age__.prototypes.item-effects").jellynut_speed)
fish_action.attack_parameters.ammo_type.action.action_delivery.target_effects[1].sticker = "turbofish-speed-sticker"
data.raw["capsule"]["rabbasca-turbofish"].capsule_action = fish_action

local shake_action = table.deepcopy(fish_action)
shake_action.attack_parameters.ammo_type.action.action_delivery.target_effects[1].sticker = "protein-shake-speed-sticker"
data.raw["capsule"]["rabbasca-protein-shake"].capsule_action = shake_action