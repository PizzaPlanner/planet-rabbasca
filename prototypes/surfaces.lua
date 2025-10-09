local planet_lib = require("__PlanetsLib__.lib.planet")
local parent_planet = "gleba"
local gleba = data.raw["planet"][parent_planet]
local tau = 2*math.pi
local planet_catalogue_aquilo = require("__space-age__.prototypes.planet.procession-catalogue-aquilo")


data:extend{
{
  type = "autoplace-control",
  name = "harene",
  order = "a-a-a",
  category = "resource",
  richness = true, 
},
{
  type = "autoplace-control",
  name = "rabbasca_rocks",
  order = "a-a-a",
  category = "resource",
  richness = true, 
},
{
  type = "autoplace-control",
  name = "rabbasca_noise",
  order = "a-a-a",
  category = "resource",
  richness = true, 
}
}

local map_gen = {
    cliff_settings = { },
    autoplace_controls = 
    {
        ["harene"] = {},
        ["rabbasca_rocks"] = {},
        ["rabbasca_noise"] = {}
    },
    autoplace_settings = {
      ["tile"] =
      {
        settings =
        {
          ["rabbasca-harene"] = {},
          ["rabbasca-fertile"] = {},
          ["rabbasca-rough"] = {},
          ["rabbasca-rough-2"] = {},
          ["rabbasca-ice"] = {},
          -- ["harene-infused-foundation"] = {}
        }
      },
      ["decorative"] =
      {
        settings =
        {
          ["lunar-medium-rock"] = data.raw["optimized-decorative"]["lunar-medium-rock"] ~= nil and {} or nil,
          ["lunar-small-rock"] = data.raw["optimized-decorative"]["lunar-small-rock"] ~= nil and {} or nil,
          ["lunar-tiny-rock"] = data.raw["optimized-decorative"]["lunar-tiny-rock"] ~= nil and {} or nil,
          --["medium-sand-rock"] = {},
          --["small-sand-rock"] = {}
        }
      },
        ["entity"] =
      {
        settings =
        {
          ["rabbascan-scrap"] = {},
          ["rabbasca-energy-source"] = {},
          ["harene-vent"] = {},
          ["carotenoid"] = {},
          ["rabbasca-turbofish"] = {},
          ["moonstone-rock"] = {},
          -- ["moonstone-turret"] = {},
          ["rabbasca-vault"] = {},
        }
      }
    }


}

PlanetsLib:extend({
{
    type = "planet",
    name = "rabbasca",
    draw_orbit = false,
    solar_power_in_space = gleba.solar_power_in_space,
    auto_save_on_first_trip = true,
    gravity_pull = 10,
    order = gleba.order .. "a",
    
    icons = {
      {
        icon = "__muluna-graphics__/graphics/moon-icon-mipped.png",
        icon_size = 64, 
      }
    },
    icon = "__muluna-graphics__/graphics/moon-icon-mipped.png",
    icon_size = 64,
    label_orientation = 0.75,
    starmap_icon = "__muluna-graphics__/graphics/moon-icon.png",
    starmap_icon_size = 1215,
    subgroup = "satellites",
    magnitude = gleba.magnitude*3/5,
    pollutant_type = "vault-activity",
    persistent_ambient_sounds=data.raw["space-platform-hub"]["space-platform-hub"].persistent_ambient_sounds,
    localised_description={"planetslib-templates.moon-description",{"space-location-description.rabbasca"},"[planet="..parent_planet.."]"},
    surface_properties = {
        ["solar-power"] = 0,
        ["pressure"] = 0,
        ["day-night-cycle"] = 0,
        ["magnetic-field"] = 0.01,
        ["harenic-energy-signatures"] = 100,
        ["atmospheric-oxygen"] = 0,
        ["atmospheric-carbon-dioxide"] = 0,
    },
    map_gen_settings = map_gen,
    parked_platforms_orientation = 0.27,
    orbit = {
      orientation = 0.74,
      distance = 1.7,
      parent = {
        type = "planet",
        name = parent_planet,
      },
      sprite = {
        type = "sprite",
        filename = "__muluna-graphics__/graphics/orbits/orbit-muluna.png",
        size = 412,
        scale = 0.25,
      }
    },
    platform_procession_set =
    {
      arrival = {"planet-to-platform-b"},
      departure = {"platform-to-planet-a"}
    },
    planet_procession_set =
    {
      arrival = {"platform-to-planet-b"},
      departure = {"planet-to-platform-a"}
    },
    procession_graphic_catalogue = planet_catalogue_aquilo
}
})

data:extend{
util.merge{ data.raw["surface"]["space-platform"], {
  type = "surface",
  name = "harene-powered-space-platform",
  surface_properties = {
    gravity = 0,
    pressure = 0,
    ["magnetic-field"] = 0,
    ["day-night-cycle"] = 0 ,
    ["harenic-energy-signatures"] = 60, 
  }
}},
{
  type = "space-connection",
  name = "gleba-rabbasca",
  order = "a-b-c",
  from = "gleba",
  to = "rabbasca",
  subgroup = data.raw["space-connection"]["gleba-fulgora"].subgroup,
  length = 1000,
  --asteroid_spawn_definitions = asteroid_spawn_definitions_connection
},
{
  type = "surface-property",
  name = "harenic-energy-signatures",
  default_value = 0
},
  {
  type = "airborne-pollutant",
  name = "vault-activity",
  chart_color = {r = 133, g = 13, b = 240, a = 149},
  icon =
  {
    filename = "__core__/graphics/icons/mip/side-map-menu-buttons.png",
    priority = "high",
    size = 64,
    mipmap_count = 2,
    y = 3 * 64,
    flags = {"gui-icon"}
  },
  affects_evolution = true,
  affects_water_tint = false,
}
}