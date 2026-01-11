data:extend{
{
    type = "item",
    name = "rabbasca-locate-stabilizer",
    category = "rabbasca-security",
    order = "z[locate-underground]",
    icon = "__rabbasca-assets__/graphics/by-hurricane/custom-atom-forge-icon.png",
    icon_size = 64,
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
    icon = "__rabbasca-assets__/graphics/by-hurricane/custom-atom-forge-icon.png",
    icon_size = 64,
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
  auto_recycle = false,
  subgroup = "rabbasca-processes",
  order = "u[underground]-a[amide]"
},
{
  type = "item",
  name = "rabbasca-holmium-coating",
  icon = data.raw["item"]["ice"].icon,
  stack_size = 100,
  weight = 50 * kg,
  order = "u[underground]-b[coating]"
},
{
  type = "item",
  name = "rabbasca-perfluorosulfonic-filter",
  icon = "__rabbasca-assets__/graphics/by-malcolmriley/part-filter-simple.png",
  stack_size = 20,
  weight = 50 * kg,
  auto_recycle = false,
  order = "u[underground]-b[filter]"
},
{
  type = "item",
  name = "rabbasca-warp-matrix",
  icon = "__rabbasca-assets__/graphics/by-openai/warp-matrix.png",
  icon_size = 246,
  stack_size = 50,
  weight = 1 * kg,
  spoil_ticks = 3 * minute,
  auto_recycle = false,
  subgroup = "rabbasca-warp-stabilizer",
  order = "a[warp-matrix]",
},
{
  type = "item",
  name = "rabbasca-coordinate-calibrations",
  icon = data.raw["item"]["ice"].icon,
  stack_size = 200,
  weight = 1 * kg,
  auto_recycle = false,
  subgroup = "rabbasca-warp-stabilizer",
  order = "a[warp-matrix-calibrated]",
},
{
  type = "item",
  name = "rabbasca-spatial-anchor",
  icon = data.raw["item"]["holmium-plate"].icon,
  stack_size = 50,
  weight = 10 * kg,
  auto_recycle = false,
  subgroup = "rabbasca-warp-stabilizer",
  order = "a[warp-matrix-anchor]",
},
{
  type = "item",
  name = "rabbasca-warp-tech-analyzer",
  icon = data.raw["item"]["lab"].icon,
  stack_size = 10,
  weight = 100 * kg,
  subgroup = data.raw["item"]["lab"].subgroup,
  order = data.raw["item"]["lab"].order.."-r[rabbasca-underground]",
},
}