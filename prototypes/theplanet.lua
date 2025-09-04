local planet_lib = require("__PlanetsLib__.lib.planet")
local parent_planet = "gleba"
local nauvis = data.raw["planet"][parent_planet]
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
          ["rabbasca-harene-deep"] = {},
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
          ["harene-vent"] = {},
          ["rabbasca-infused-moonstone-rock"] = {},
          ["carotenoid"] = {},
          ["rabbasca-turbofish"] = {},
          ["rabbasca-moonstone-rock"] = {},
          -- ["moonstone-turret"] = {},
          ["rabbasca-vault"] = {},
        }
      }
    }


}

local rabbasca = 
{
    type = "planet",
    name = "rabbasca",
    draw_orbit = false,
    solar_power_in_space = nauvis.solar_power_in_space,
    auto_save_on_first_trip = true,
    gravity_pull = 10,
    order = nauvis.order .. "a",
    
    icons = {
      {
        icon = "__muluna-graphics__/graphics/moon-icon-mipped.png",
        icon_size = 64, 
      }
    },
    icon = "__muluna-graphics__/graphics/moon-icon-mipped.png",
    icon_size = 64,
    label_orientation = 0.55,
    starmap_icon = "__muluna-graphics__/graphics/moon-icon.png",
    starmap_icon_size = 1482,
    subgroup = "satellites",
    magnitude = nauvis.magnitude*3/5,
    --pollutant_type = "radiation",
    persistent_ambient_sounds=data.raw["space-platform-hub"]["space-platform-hub"].persistent_ambient_sounds,
    localised_description={"planetslib-templates.moon-description",{"space-location-description.rabbasca"},"[planet="..parent_planet.."]"},
    surface_properties = {
        ["solar-power"] = 0,
        ["pressure"] = 15,
        ["magnetic-field"] = 0.01,
        ["day-night-cycle"] = 0,
        ["mooniness"] = 1,
    },
    map_gen_settings = map_gen,
    parked_platforms_orientation=0.70,
    orbit = {
      orientation = 0.93,
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
    surface_render_parameters = {
      shadow_opacity = 0.2,
      space_dust_foreground = data.raw["space-platform-hub"]["space-platform-hub"].surface_render_parameters.space_dust_foreground
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
    procession_graphic_catalogue = planet_catalogue_aquilo,

    --Player effects, based on Varaxia's work on Celestial weather
    ticks_between_player_effects = 1,
    --player_effects = require("player_effects").player_effects

    
}

local rabbasca_connection = {
  type = "space-connection",
  name = "gleba-rabbasca",
  order = "a-b-c",
  from = "gleba",
  to = "rabbasca",
  subgroup = data.raw["space-connection"]["gleba-fulgora"].subgroup,
  length = 1000,
  --asteroid_spawn_definitions = asteroid_spawn_definitions_connection
}

PlanetsLib:extend({rabbasca})

data:extend{rabbasca_connection}