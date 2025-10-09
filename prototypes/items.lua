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
    stack_size = 1,
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
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
    spoil_ticks = 3 * minute,
    spoil_result = "stone"
},
{
    type = "item",
    icon = "__Krastorio2Assets__/icons/items/imersium-plate.png",
    name = "infused-haronite-plate",
    stack_size = 50,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__Krastorio2Assets__/icons/items/lithium-2.png",
    name = "rabbasca-turbofin",
    stack_size = 200,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__base__/graphics/icons/sulfur.png",
    name = "harenic-stabilizer",
    stack_size = 50,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/bioflux.png",
    name = "smart-solution",
    stack_size = 100,
    subgroup = "rabbasca",
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
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/fusion-generator.png",
    name = "harene-ears-core",
    stack_size = 10,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
    auto_recycle = false,
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/small-wriggler.png",
    name = "harene-glob-core",
    stack_size = 10,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/jelly.png",
    name = "harene-copy-core",
    stack_size = 10,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/jelly.png",
    name = "harene-copy-core-recharging",
    stack_size = 10,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "capsule",
    icon = "__base__/graphics/icons/steam-engine.png",
    name = "bunnyhop-engine",
    stack_size = 1,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
    capsule_action = {
      type = "use-on-self",
      uses_stack = false,
      attack_parameters = {
        type = "projectile",
        activation_type = "consume",
        ammo_category = "capsule",
        cooldown = 1 * minute,
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
    }
},
{
    type = "item",
    icons = {{ icon = "__Krastorio2Assets__/icons/items/imersite-powder-2-light.png", tint = {0.8, 0.32, 0.06} }},
    name = "rabbasca-carotene-powder",
    stack_size = 200,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "tool",
    icon = "__space-age__/graphics/icons/metallurgic-science-pack.png",
    name = "ultranutritious-science-pack",
    stack_size = 200,
    durability = 1,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/foundation.png",
    name = "harene-infused-foundation",
    stack_size = 20,
    subgroup = "rabbasca",
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
    subgroup = "rabbasca",
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
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
    fuel_category = "nutrients",
    fuel_value = "3MJ",
},
{
  type = "fluid",
    name = "harene",
    icon = "__space-age__/graphics/icons/fluid/electrolyte.png",
    base_color = {r=0.65, g=0.31, b=0.92},
    flow_color = {r=0.65, g=0.31, b=0.92},
    default_temperature = 35.0,
    fuel_value = "100MJ",
    auto_barrel = false
},
{
  type = "fluid",
    name = "harene-gas",
    icons = {{ icon = "__space-age__/graphics/icons/fluid/fluorine.png", tint = {r=0.65, g=0.31, b=0.92} }},
    base_color = {r=0.65, g=0.31, b=0.92},
    flow_color = {r=0.65, g=0.31, b=0.92},
    default_temperature = 35.0,
    fuel_value = "1MJ",
    auto_barrel = false
},
{
    type = "fluid",
    name = "beta-carotene",
    icon = "__space-age__/graphics/icons/fluid/thruster-fuel.png",
    base_color = { 0.8, 0.42, 0.02 },
    flow_color = { 0.8, 0.42, 0.02 },
    default_temperature = 14.0,
    auto_barrel = true
},
{
    type = "fluid",
    name = "energetic-residue",
    icon = "__space-age__/graphics/icons/fluid/ammoniacal-solution.png",
    base_color = {0, 0.14, 0.53},
    flow_color = {0, 0.14, 0.53},
    default_temperature = 72.0,
    fuel_value = "340kJ",
    auto_barrel = true
},
{
    type = "fluid",
    name = "rabbasca-copyslop",
    icon = "__space-age__/graphics/icons/fluid/ammoniacal-solution.png",
    base_color = {0.17, 0.42, 0.53},
    flow_color = {0.17, 0.42, 0.53},
    default_temperature = -32.0,
    auto_barrel = false
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/jellynut.png",
    name = "megabrain",
    stack_size = 20,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
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
    name = "blank-vault-key",
    category = "rabbasca-security",
    icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png",
    stack_size = 20,
},
{
    type = "item",
    name = "rabbasca-console-scrap",
    icon = "__space-age__/graphics/icons/scrap-5.png",
    stack_size = 500,
    weight = 0.1 * kg,
},
{
    type = "tool",
    name = "rabbascan-encrypted-vault-data",
    category = "rabbasca-security",
    icon = "__Krastorio2Assets__/icons/cards/matter-research-data.png",
    stack_size = 200,
    weight = 1 * kg,
    durability = 1,
},
{
    type = "item",
    name = "rabbasca-vault-access-protocol",
    category = "rabbasca-security",
    icon = "__Krastorio2Assets__/icons/cards/advanced-tech-card.png",
    hidden = true,
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
{
    type = "item",
    name = "rabbasca-vault-core-extraction-protocol",
    category = "rabbasca-security",
    icon = "__Krastorio2Assets__/icons/cards/advanced-tech-card.png",
    hidden = true,
    hidden_in_factoriopedia = true,
    auto_recycle = false,
    stack_size = 1,
    spoil_ticks = 1,
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
{
    type = "item",
    name = "rabbasca-vault-access-indicator",
    category = "rabbasca-security",
    icon = "__Krastorio2Assets__/icons/cards/advanced-tech-card.png",
    hidden = true,
    hidden_in_factoriopedia = true,
    stack_size = 5,
    spoil_ticks = 90 * second,
}
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