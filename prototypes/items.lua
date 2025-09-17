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
    name = "harene-solvent",
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
    icon = "__space-age__/graphics/icons/bioflux.png",
    name = "power-solution",
    stack_size = 100,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/bioflux.png",
    name = "haronite-catalyst",
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
    type = "capsule",
    icon = "__base__/graphics/icons/steam-engine.png",
    name = "bunnyhop-engine",
    stack_size = 10,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
    capsule_action = {
      type = "use-on-self",
      uses_stack = true,
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
    type = "item",
    icon = "__space-age__/graphics/icons/big-volcanic-rock.png",
    name = "rabbasca-moonstone",
    stack_size = 50,
    subgroup = "rabbasca",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/tesla-turret.png",
    name = "moonstone-turret",
    stack_size = 5,
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
    fuel_value = "180MJ",
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
    name = "harenic-sludge",
    icon = "__space-age__/graphics/icons/fluid/ammoniacal-solution.png",
    base_color = {0.17, 0.14, 0.53},
    flow_color = {0.17, 0.14, 0.53},
    default_temperature = 24.0,
    auto_barrel = true
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
    name = "harene-infused-brick",
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
    type = "item",
    name = "blank-vault-key",
    category = "rabbasca-security",
    fuel_value = "60MJ",
    fuel_category = "rabbasca-security-fuel-e",
    icon = "__Krastorio2Assets__/icons/cards/optimization-tech-card.png",
    stack_size = 20,
},
{
    type = "item",
    name = "rabbascan-security-key-e",
    category = "rabbasca-security",
    fuel_value = "3GW",
    fuel_category = "rabbasca-security-fuel-e",
    icon = "__Krastorio2Assets__/icons/cards/utility-tech-card.png",
    stack_size = 5,
    
},
{
    type = "fuel-category",
    name = "rabbasca-security-fuel-e",
    fuel_value_type = {"description.rabbasca-security-energy-value"}
},
{
    type = "item",
    name = "rabbascan-security-key-p",
    category = "rabbasca-security",
    fuel_value = "3GW",
    fuel_category = "rabbasca-security-fuel-p",
    icon = "__Krastorio2Assets__/icons/cards/production-tech-card.png",
    stack_size = 5,
},
{
    type = "fuel-category",
    name = "rabbasca-security-fuel-p",
    fuel_value_type = {"description.rabbasca-security-energy-value"}
},
{
    type = "item",
    name = "rabbascan-security-key-a",
    category = "rabbasca-security",
    fuel_value = "3GW",
    fuel_category = "rabbasca-security-fuel-a",
    icon = "__Krastorio2Assets__/icons/cards/matter-tech-card.png",
    stack_size = 5,
},
{
    type = "fuel-category",
    name = "rabbasca-security-fuel-a",
    fuel_value_type = {"description.rabbasca-security-energy-value"}
},
{
    type = "item",
    name = "rabbasca-console-scrap",
    icon = "__space-age__/graphics/icons/scrap-5.png",
    stack_size = 500,
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
    name = "rabbasca-vault-access-timer",
    category = "rabbasca-security",
    icon = "__Krastorio2Assets__/icons/cards/advanced-tech-card.png",
    hidden = true,
    hidden_in_factoriopedia = true,
    auto_recycle = false,
    stack_size = 1,
    spoil_ticks = 90 * second,
    spoil_to_trigger_result =
    {
      items_per_trigger = 1,
      trigger =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "script",
              effect_id = "rabbasca_on_hack_expire"
            }
          }
        }
      }
    }
},
{
    type = "item",
    name = "harene-ears-core-protocol",
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
},
{
    type = "module-category",
    name = "rabbasca-security"
}
}