data:extend{
{
    type = "item",
    name = "rabbasca-locate-stabilizer",
    category = "rabbasca-security",
    order = "b[vault-access-key]",
    icon = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-icon.png",
    icon_size = 640,
    flags = { "ignore-spoil-time-modifier" },
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
              effect_id = "rabbasca_on_send_pylon_underground"
            }
          }
        }
      }
    }
},
{
    type = "item",
    name = "rabbasca-reboot-stabilizer",
    category = "rabbasca-security",
    order = "b[vault-access-key]",
    icon = "__rabbasca-assets__/graphics/by-hurricane/atom-forge-icon.png",
    icon_size = 640,
    flags = { "ignore-spoil-time-modifier" },
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
              effect_id = "rabbasca_on_send_pylon_underground"
            }
          }
        }
      }
    }
},
{
    type = "fluid",
    name = "rabbasca-perfluorosulfonic-acid",
    icons = 
    {
      { icon = data.raw["fluid"]["fluorine"].icon, icon_size = 64 },
      { icon = data.raw["fluid"]["sulfuric-acid"].icon, icon_size = 64, scale = 0.3 }
    },
    base_color = {0.65, 0.83, 0.15},
    flow_color = {0.65, 0.83, 0.15},
    default_temperature = 192,
},
{
  type = "item",
  name = "rabbasca-lithium-amide",
  icon = data.raw["item"]["lithium"].icon,
  stack_size = 50,
  weight = 25 * kg,
},
{
  type = "item",
  name = "rabbasca-warp-matrix",
  icon = data.raw["item"]["ice"].icon,
  stack_size = 50,
  weight = 10 * kg,
  auto_recycle = false
},
util.merge { data.raw["tool"]["automation-science-pack"], {
  name = "rabbasca-warp-proofed-science-pack",
  icon = "__rabbasca-assets__/graphics/recolor/icons/athletic-science-pack.png",
  icon_size = 64,
  order = "x-r[rabbasca]",
}},
}