data:extend{
Rabbasca.make_trigger_item({
  name = "rabbasca-locate-stabilizer",
  category = "rabbasca-security",
  order = "z[locate-underground]",
  icon = "__rabbasca-assets__/graphics/by-hurricane/custom-atom-forge-icon.png",
  icon_size = 64,
}, "rabbasca_on_send_pylon_underground"),
Rabbasca.make_trigger_item({
  name = "rabbasca-reboot-stabilizer",
  category = "rabbasca-security",
  order = "z[locate-underground-reboot]",
  icon = "__rabbasca-assets__/graphics/by-hurricane/custom-atom-forge-icon.png",
  icon_size = 64,
}, "rabbasca_on_send_pylon_underground"),
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
  name = "rabbasca-perfluorosulfonic-filter",
  icon = "__rabbasca-assets__/graphics/by-malcolmriley/part-filter-simple.png",
  stack_size = 20,
  weight = 50 * kg,
  auto_recycle = false,
  order = "u[underground]-b[filter]"
},
util.merge {
  data.raw["tool"]["automation-science-pack"],
  {
    name = "rabbasca-warp-matrix",
    icon = "__rabbasca-assets__/graphics/by-openai/warp-matrix.png",
    icon_size = 246,
    stack_size = 1000,
    weight = 1 * kg,
    localised_description = { "item-description.rabbasca-warp-matrix" },
    spoil_ticks = 15 * second,
    spoil_to_trigger_result = {
      items_per_trigger = 1,
      trigger =
      {
          type = "direct",
          -- probability = 0.3,
          action_delivery =
          {
          type = "instant",
          source_effects =
          {
              {
              type = "script",
              effect_id = "rabbasca_surface_malfunction",
              }
          }
          }
      }
    }, 
    auto_recycle = false,
    subgroup = "rabbasca-warp-stabilizer",
    order = "a[warp-matrix]",
  },
},
util.merge {
  data.raw["tool"]["automation-science-pack"],
  {
    type = "item",
    name = "rabbasca-holmium-coating",
    icon = data.raw["item"]["tungsten-carbide"].icon,
    stack_size = 100,
    weight = 50 * kg,
    subgroup = "rabbasca-warp-stabilizer",
    order = "b[science]-b",
  },
},
util.merge {
  data.raw["tool"]["automation-science-pack"],
  {
    name = "rabbasca-coordinate-calibrations",
    icon = data.raw["item"]["ice"].icon,
    stack_size = 200,
    weight = 1 * kg,
    auto_recycle = false,
    subgroup = "rabbasca-warp-stabilizer",
    order = "b[science]-c",
  },
},
util.merge {
  data.raw["tool"]["automation-science-pack"],
  {
    name = "rabbasca-spacetime-evolutionizer",
    icon = data.raw["item"]["pentapod-egg"].icon,
    stack_size = 200,
    weight = 1 * kg,
    auto_recycle = false,
    subgroup = "rabbasca-warp-stabilizer",
    order = "b[science]-d",
  },
},
util.merge {
  data.raw["tool"]["automation-science-pack"],
  {
    name = "rabbasca-spatial-anchor",
    icon = data.raw["item"]["holmium-plate"].icon,
    stack_size = 50,
    weight = 10 * kg,
    auto_recycle = false,
    subgroup = "rabbasca-warp-stabilizer",
    order = "b[science]-e",
  },
},
{
  type = "item",
  name = "rabbasca-warp-tech-analyzer",
  icon = data.raw["item"]["lab"].icon,
  place_result = "rabbasca-warp-tech-analyzer",
  stack_size = 10,
  weight = 100 * kg,
  subgroup = data.raw["item"]["lab"].subgroup,
  order = data.raw["item"]["lab"].order.."-r[rabbasca-underground]",
},
}