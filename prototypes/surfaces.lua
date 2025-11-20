local planet_lib = require("__PlanetsLib__.lib.planet")
local parent_name = settings.startup["rabbasca-orbits"].value
local gleba = data.raw["planet"][parent_name]
local tau = 2*math.pi
local planet_catalogue_aquilo = require("__space-age__.prototypes.planet.procession-catalogue-aquilo")


data:extend{
{
  type = "autoplace-control",
  name = "rabbasca_rocks",
  order = "r[rabbasca]-c[rocks]",
  category = "resource",
  richness = false, 
},
{
  type = "autoplace-control",
  name = "harene",
  order = "r[rabbasca]-a[harene]",
  category = "resource",
  richness = true, 
  can_be_disabled = false,
},
{
  type = "autoplace-control",
  name = "rabbasca_carotenoids",
  order = "r[rabbasca]-b[carotenoids]",
  category = "resource",
  richness = true, 
  can_be_disabled = false,
},
{
  type = "autoplace-control",
  name = "rabbasca_vaults",
  order = "r[rabbasca]-b[vaults]",
  category = "resource",
  richness = true, 
  can_be_disabled = false,
}
}

data:extend {
  util.merge{
    data.raw["optimized-decorative"]["yellow-lettuce-lichen-cups-3x3"],
    {
      name = "rabbasca-yellow-lettuce-lichen-3x3",
      autoplace = { probability_expression = "(rabbasca_fertile > 1.1) * rpi(0.6) * decorative_knockout" }
    }
  },
  util.merge{
    data.raw["optimized-decorative"]["yellow-lettuce-lichen-cups-6x6"],
    {
      name = "rabbasca-yellow-lettuce-lichen-6x6",
      autoplace = { probability_expression = "(rabbasca_fertile > 1.2) * rpi(0.4) * decorative_knockout" }
    }
  },
  util.merge{
    data.raw["optimized-decorative"]["crater-large"],
    {
      name = "rabbasca-crater-large",
      autoplace = { probability_expression = "crater_large * (1.3 - max(rabbasca_down, rabbasca_fertile))" } 
    }
  },
  util.merge{
    data.raw["optimized-decorative"]["vulcanus-dune-decal"],
    {
      name = "rabbasca-dune-decal",
      autoplace = { probability_expression = "vulcanus_dune_decal * rpi(0.2) * decorative_knockout - max(rabbasca_fertile, rabbasca_rocks(4)) - rabbasca_down" }
    }
  },
  util.merge{
    data.raw["optimized-decorative"]["tiny-volcanic-rock"],
    {
      name = "rabbasca-tiny-rock",
      autoplace = { probability_expression = "rabbasca_rocks(1.9)" }
    }
  },
  util.merge{
    data.raw["optimized-decorative"]["small-volcanic-rock"],
    {
      name = "rabbasca-small-rock",
      autoplace = { probability_expression = "rabbasca_rocks(1.3)" }
    }
  },
  util.merge{
    data.raw["optimized-decorative"]["brown-asterisk-mini"],
    {
      name = "rabbasca-asterisk-mini",
      autoplace = { probability_expression = "rabbasca_carrot_noise" }
    }
  },
  util.merge{
    data.raw["optimized-decorative"]["fulgoran-gravewort"],
    {
      name = "rabbasca-gravewort",
      autoplace = { probability_expression = "rabbasca_carrot_noise" }
    }
  },
}

local map_gen = {
    cliff_settings = { },
    autoplace_controls = 
    {
        ["harene"] = {},
        ["rabbasca_rocks"] = {},
        ["rabbasca_carotenoids"] = {},
        ["rabbasca_vaults"] = {},
    },
    autoplace_settings = {
      ["tile"] =
      {
        settings =
        {
          ["rabbasca-harenic-sludge"] = {},
          ["rabbasca-fertile"] = {},
          ["rabbasca-rough"] = {},
          ["rabbasca-rough-2"] = {},
        }
      },
      ["decorative"] =
      {
        settings =
        {
          ["rabbasca-crater-large"] = {},
          ["rabbasca-yellow-lettuce-lichen-3x3"] = {},
          ["rabbasca-yellow-lettuce-lichen-6x6"] = {},
          ["shroom-decal"] = {},
          ["rabbasca-tiny-rock"] = {},
          ["rabbasca-small-rock"] = {},
          ["rabbasca-dune-decal"] = {},
          ["rabbasca-asterisk-mini"] = {},
          ["rabbasca-gravewort"] = {},
        }
      },
        ["entity"] =
      {
        settings =
        {
          ["rabbasca-energy-source"] = {},
          ["rabbasca-vault-crafter"] = {},
          ["carotenoid-ore"] = {},
          ["rabbascan-scrap"] = {},
          ["harene-vent"] = {},
          ["rabbasca-turbofish"] = {},
          ["rabbasca-big-rock"] = {},
        }
      }
    }
}

local spawn_definitions = table.deepcopy(gleba.asteroid_spawn_definitions)
PlanetsLib:extend({
{
    type = "planet",
    name = "rabbasca",
    icon = "__rabbasca-assets__/graphics/recolor/icons/vulcanus-bw.png",
    icon_size = 64,
    starmap_icon = "__rabbasca-assets__/graphics/recolor/icons/vulcanus-bw.png",
    starmap_icon_size = 64,
    draw_orbit = true,
    solar_power_in_space = gleba.solar_power_in_space,
    auto_save_on_first_trip = true,
    gravity_pull = 10,
    subgroup = "satellites",
    order = gleba.order .. "a",
    label_orientation = 0.14,
    magnitude = gleba.magnitude*3/5,
    persistent_ambient_sounds=data.raw["space-platform-hub"]["space-platform-hub"].persistent_ambient_sounds,
    localised_description={"planetslib-templates.moon-description",{"space-location-description.rabbasca"},"[planet="..gleba.name.."]"},
    asteroid_spawn_definitions = spawn_definitions,
    asteroid_spawn_influence = 0.7,
    -- robot energy usage = gravity/pressure*100, gravity > 0.1 (allow chests), robots should be expensive and limited by energy field
    -- on x8+(?) energy usage, normal robots are stuck in recharge loop
    surface_properties = {
        ["gravity"] = 1,
        ["solar-power"] = 0,
        ["pressure"] = 14,
        ["day-night-cycle"] = 12 * minute,
        ["magnetic-field"] = 0.01,
        ["harenic-energy-signatures"] = 50,
    },
    surface_render_parameters = {
      shadow_opacity = 0.73,
      draw_sprite_clouds = false,
      clouds = nil,
      fog = nil,
    },
    map_gen_settings = map_gen,
    parked_platforms_orientation = 0.27,
    orbit = {
      orientation = 0.9,
      distance = 1.8,
      parent = {
        type = "planet",
        name = gleba.name,
      },
      sprite = {
        type = "sprite",
        filename = "__rabbasca-assets__/graphics/recolor/icons/vulcanus-bw.png",
        size = 64,
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
{
  type = "space-connection",
  name = gleba.name.."-rabbasca",
  order = "a-b-c",
  from = gleba.name,
  to = "rabbasca",
  subgroup = data.raw["space-connection"]["gleba-fulgora"].subgroup,
  length = 1000,
},
{
  type = "surface-property",
  name = "harenic-energy-signatures",
  default_value = 0
},
}