local parent_name = settings.startup["rabbasca-orbits"].value
local gleba = data.raw["planet"][parent_name]

data:extend { 
  {
    type = "planet",
    name = "rabbasca-underground",
    icon = "__rabbasca-assets__/graphics/by-openai/rabbasca-underground.png", 
    icon_size = 128,
    hidden = true,
    draw_orbit = false,
    distance = 10,
    orientation = 0,
    gleba.order .. "-r[rabbasca-underground]",
    map_seed_offset = rabbasca_seed_offset,
    surface_properties = {
        ["gravity"] = 8,
        ["solar-power"] = 0,
        ["pressure"] = Rabbasca.underground_pressure(),
        ["magnetic-field"] = 0.01,
        ["harenic-energy-signatures"] = Rabbasca.surface_megawatts() * 0.1,
        ["day-night-cycle"] = 30 * second,
    },
    map_gen_settings = {
      cliff_settings = {
        name = "rabbasca-underground-cliff",
        cliff_elevation_0 = 0.255,
        cliff_elevation_interval = 0.4,
        cliff_smoothing = 0,
        -- richness = 10,
      },
      property_expression_names = {
        elevation = "rabbasca_underground_elevation",
        cliff_elevation = "rabbasca_underground_elevation",
        cliffiness = "1",
      },
      autoplace_controls = 
      {
          ["rabbasca_vaults"] = {},
      },
      autoplace_settings = {
      tile = { settings = {
        ["rabbasca-underground-rubble"] = {},
        ["rabbasca-underground-out-of-map"] = {},
      }},
      entity = { settings = {
        ["rabbasca-energy-source-big"] = {},
        -- ["rabbasca-underground-rock"] = {},
        ["rabbasca-carbonic-ore"] = {},
        ["rabbasca-lithium-amide"] = {},
      }}
      },
      territory_settings =
      {
        units = {"rabbasca-underground-devourer"},
        territory_index_expression = "rabbasca_devourer_territory_expression",
        territory_variation_expression = "demolisher_variation_expression",
        minimum_territory_size = 8
      },
    },
    surface_render_parameters = {
      shadow_opacity = 0.8,
      draw_sprite_clouds = false,
      clouds = nil,
      day_night_cycle_color_lookup = {
          {0.0, "__rabbasca-assets__/graphics/recolor/textures/lut-underground.png"},
          {0.5, "__rabbasca-assets__/graphics/recolor/textures/lut-black.png"}
      },
      fog = util.merge {
        data.raw["planet"]["vulcanus"].surface_render_parameters.fog,
        {
          color1 = {0.45, 0.3706, 1},
          color2 = {0.4, 0.2706,  0.9902},
          tick_factor = 0.0005,
        }
      }
    },
  }
}