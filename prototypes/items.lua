function return_to_monument_trigger()
 return {
    type = "direct",
    action_delivery =
    {
      type = "instant",
      target_effects =
      {
        {
          type = "script",
          effect_id = "rabbasca_rescue_item"
        }
      }
    }
  }
end

data:extend {
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
    order = "b[personal-transport]-c[startertron]",
    spoil_ticks = 3 * minute,
    spoil_result = "stone"
},
{
    type = "item",
    icon = "__Krastorio2Assets__/icons/items/imersium-plate.png",
    name = "infused-haronite-plate",
    stack_size = 50,
    subgroup = "rabbasca-processes",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__Krastorio2Assets__/icons/items/lithium-2.png",
    name = "rabbasca-turbofin",
    stack_size = 200,
    subgroup = "rabbasca-processes",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__planet-rabbasca__/graphics/icons/harenic-stabilizer.png",
    name = "harenic-stabilizer",
    stack_size = 50,
    subgroup = "rabbasca-processes",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icons = { { icon = "__base__/graphics/icons/electronic-circuit.png", tint = { 0.2, 1, 1 } } },
    name = "vision-circuit",
    stack_size = 100,
    group = "intermediate-products",
    subgroup = "intermediate-product",
    order = "b[circuits]-d[vision-circuit]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/bioflux.png",
    name = "power-solution",
    stack_size = 100,
    subgroup = "rabbasca-processes",
    order = "b[personal-transport]-c[power-solution]",
},
{
    type = "item",
    icon = "__planet-rabbasca__/graphics/icons/harene-ears-core.png",
    name = "harene-ears-core",
    stack_size = 5,
    weight = 50 * kg,
    subgroup = "rabbasca-processes",
    order = "b[personal-transport]-d[harene-ears-core]",
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
    order = "b[personal-transport]-d[harene-ears-subcore]",
    auto_recycle = false,
},
{
    type = "item",
    icon = "__planet-rabbasca__/graphics/icons/harene-copy-core.png",
    name = "harene-copy-core",
    stack_size = 10,
    subgroup = "rabbasca-processes",
    order = "b[personal-transport]-d[harene-copy-core]",
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
        activation_type = "consume",
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
{
    type = "item",
    icons = {{ icon = "__Krastorio2Assets__/icons/items/imersite-powder-2-light.png", tint = {0.8, 0.32, 0.06} }},
    name = "rabbasca-carotene-powder",
    stack_size = 200,
    subgroup = "rabbasca-processes",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/foundation.png",
    name = "harene-infused-foundation",
    stack_size = 20,
    subgroup = "rabbasca-processes",
    order = "b[personal-transport]-c[startertron]",
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
    order = "b[personal-transport]-c[startertron]",
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
    icon = "__space-age__/graphics/icons/nutrients.png",
    name = "protein-powder",
    stack_size = 200,
    subgroup = "rabbasca-processes",
    order = "b[personal-transport]-c[startertron]",
    fuel_category = "nutrients",
    fuel_value = "8.7MJ",
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
    auto_barrel = false
},
{
    type = "fluid",
    name = "harene-gas",
    icons = {{ icon = "__space-age__/graphics/icons/fluid/fluorine.png", tint = {r=0.65, g=0.31, b=0.92} }},
    subgroup = "fluid",
    base_color = {r=0.65, g=0.31, b=0.92},
    flow_color = {r=0.65, g=0.31, b=0.92},
    default_temperature = 35.0,
    fuel_value = "1MJ",
    auto_barrel = false
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
},
{
    type = "fluid",
    name = "energetic-residue",
    icon = "__planet-rabbasca__/graphics/icons/energetic-residue.png",
    subgroup = "fluid",
    base_color = {0, 0.14, 0.53},
    flow_color = {0, 0.14, 0.53},
    default_temperature = 72.0,
    fuel_value = "340kJ",
    auto_barrel = true
},
{
    type = "fluid",
    name = "rabbasca-copyslop",
    icon = "__planet-rabbasca__/graphics/icons/copyslop.png",
    subgroup = "fluid",
    base_color = {0.37, 0.42, 0.23},
    flow_color = {0.37, 0.42, 0.23},
    default_temperature = -32.0,
    auto_barrel = true
},
{
    type = "item",
    name = "haronite-brick",
    icons = { { icon = "__base__/graphics/icons/stone-brick.png", tint = {r=0.65, g=0.31, b=0.92} } },
    stack_size = 50,
    spoil_ticks = 90 * second,
    spoil_result = "stone-brick"
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
    }
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
    type = "item",
    name = "vault-access-key",
    subgroup = "rabbasca-security",
    order = "a[vault-access-key]",
    icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png",
    stack_size = 20,
},
{
    type = "item",
    name = "vault-access-key-r",
    icon = data.raw["virtual-signal"]["signal-hourglass"].icon,
    hidden = true,
    hidden_in_factoriopedia = true,
    spoil_ticks = 5,
    subgroup = "rabbasca-security",
    order = "a[vault-access-key]",
    icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png",
    stack_size = 20,
},
{
    type = "item",
    name = "vault-access-key-e",
    subgroup = "rabbasca-security",
    order = "a[vault-access-key-e]",
    icons = {
      { icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png" },
      { icon = "__planet-rabbasca__/graphics/icons/harene-ears-core.png", scale = 0.3, shift = {4, 4} }
    } ,
    stack_size = 20,
},
{
    type = "item",
    name = "vault-access-key-c",
    subgroup = "rabbasca-security",
    order = "a[vault-access-key-c]",
    icons = {
      { icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png" },
      { icon = "__planet-rabbasca__/graphics/icons/harene-copy-core.png", scale = 0.3, shift = {4, 4} }
    } ,
    stack_size = 20,
},
{
    type = "item",
    name = "vault-access-key-u",
    subgroup = "rabbasca-security",
    order = "a[vault-access-key-u]",
    icons = {
      { icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png" },
      { icon = "__base__/graphics/icons/copper-ore.png", scale = 0.3, shift = {4, 4} }
    } ,
    stack_size = 20,
},
{
    type = "item",
    name = "vault-access-key-b",
    subgroup = "rabbasca-security",
    order = "a[vault-access-key-b]",
    icons = {
      { icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png" },
      { icon = "__base__/graphics/icons/blueprint.png", scale = 0.2, shift = {6, 6} }
    } ,
    stack_size = 20,
},
{
    type = "item",
    name = "vault-access-key-protocol",
    category = "rabbasca-security",
    icon = "__Krastorio2Assets__/icons/cards/advanced-tech-card.png",
    flags = { "ignore-spoil-time-modifier" },
    hidden_in_factoriopedia = true,
    auto_recycle = false,
    stack_size = 1,
    spoil_ticks = 1,
    -- spoil_result = "rabbasca-vault-access-timer",
    spoil_to_trigger_result =
    {
      items_per_trigger = 1,
      trigger =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          source_effects =
          {
            {
              type = "script",
              effect_id = "rabbasca_on_hack_console"
            }
          }
        }
      }
    }
},
}

local starter_pack = util.merge {
  data.raw["space-platform-starter-pack"]["space-platform-starter-pack"],
  {
    name = "harene-powered-space-platform-starter-pack",
    surface = "harene-powered-space-platform",
  }}
starter_pack.trigger =
{
  {
    type = "direct",
    action_delivery =
    {
      type = "instant",
      source_effects =
      {
        {
          type = "create-entity",
          entity_name = "harene-space-platform-hub"
        },
        {
          type = "create-entity",
          entity_name = "harene-platform-energy-source"
        }
      }
    }
  }
}
data:extend{ starter_pack }