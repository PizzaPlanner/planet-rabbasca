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
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__Krastorio2Assets__/icons/items/imersium-plate.png",
    name = "infused-haronite-plate",
    stack_size = 50,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/bioflux.png",
    name = "smart-solution",
    stack_size = 100,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/fusion-generator.png",
    name = "harene-ears-core",
    stack_size = 10,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    destroyed_by_dropping_trigger = return_to_monument_trigger()
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/small-wriggler.png",
    name = "harene-glob-core",
    stack_size = 10,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    destroyed_by_dropping_trigger = return_to_monument_trigger()
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/jelly.png",
    name = "harene-cubic-core",
    stack_size = 10,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    destroyed_by_dropping_trigger = return_to_monument_trigger()
},
{
    type = "item",
    icon = "__base__/graphics/icons/steam-engine.png",
    name = "bunnyhop-engine",
    stack_size = 1,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icons = {{ icon = "__Krastorio2Assets__/icons/items/imersite-powder-2-light.png", tint = {0.8, 0.32, 0.06} }},
    name = "rabbasca-carotene-powder",
    stack_size = 50,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/big-volcanic-rock.png",
    name = "rabbasca-moonstone",
    stack_size = 50,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/tungsten-ore.png",
    name = "harene-infused-moonstone",
    stack_size = 5,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/tesla-turret.png",
    name = "moonstone-turret",
    stack_size = 5,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/metallurgic-science-pack.png",
    name = "ultranutritious-science-pack",
    stack_size = 200,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
},
{
    type = "item",
    icon = "__space-age__/graphics/icons/foundation.png",
    name = "harene-infused-foundation",
    stack_size = 20,
    subgroup = "transport",
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
    subgroup = "transport",
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
    stack_size = 50,
    subgroup = "transport",
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
    type = "item",
    name = "rabbascan-security-key",
    category = "rabbasca-security",
    icon = "__Krastorio2Assets__/icons/cards/utility-tech-card.png",
    stack_size = 1,
},
{
    type = "item",
    name = "rabbasca-vault-hacking-bot-capsule",
    category = "rabbasca-security",
    icon = "__Krastorio2Assets__/icons/cards/utility-tech-card.png",
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
          target_effects =
          {
            {
              type = "script",
              effect_id = "rabbasca_change_force_and_despawn"
            }
          }
        }
      }
    }
},
{
    type = "module-category",
    name = "rabbasca-security"
}
}