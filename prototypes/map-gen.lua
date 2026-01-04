-- based on https://github.com/wube/factorio-data/blob/2c2abc2b1d4cc4e8e9cac6d8e6351308004a406b/space-age/prototypes/planet/planet-aquilo-map-gen.lua
data:extend{
  {
    type = "noise-expression",
    name = "rabbasca_starting_mask",
    expression = "clamp((distance - 120) / 20, 0, 1)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_starting_pool",
    expression = "max(starting_spot_at_angle{angle = aquilo_angle, distance = 45, radius = rabbasca_pool_size, x_distortion = 0, y_distortion = 0},\z
                      starting_spot_at_angle{angle = aquilo_angle + 120, distance = 77, radius = rabbasca_camp_size, x_distortion = 0, y_distortion = 0})"
  },
  {
    type = "noise-function",
    name = "rabbasca_starting_camp",
    parameters = { "radius" },
    expression = "starting_spot_at_angle{angle = aquilo_angle + 150, distance = 120, radius = radius, x_distortion = 0, y_distortion = 0}"
  },
  {
    type = "noise-expression",
    name = "rabbasca_starting_carrots",
    expression = "starting_spot_at_angle{angle = aquilo_angle + 240, distance = 25, radius = 31, x_distortion = 0, y_distortion = 0}\z
             * (1.1 + 0.3 * multioctave_noise{x = x, y = y, persistence = 0.83, seed0 = map_seed, input_scale = 3.1, seed1 = 'omnom', octaves = 6 })"
  },
  {
    type = "noise-expression",
    name = "rabbasca_pool_size",
    expression = "22 * sqrt(control:harene:size)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_camp_size",
    expression = "7 + 6 * sqrt(control:rabbasca_vaults:size)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_ug_hole_size",
    expression = "58"
  },
  {
    type = "noise-expression",
    name = "rabbasca_carrot_noise",
    expression = "(rabbasca_fertile > 0.8) * aquilo_spot_noise{seed = 821,\z
                                    count = 6 + 3 * sqrt(control:rabbasca_carotenoids:frequency),\z
                                    skip_offset = 0,\z
                                    region_size = 44,\z
                                    density = 0.66,\z
                                    radius = 5.3 + 3 * sqrt(control:rabbasca_carotenoids:size),\z
                                    favorability = 5}"
  },
  {
    type = "noise-expression",
    name = "rabbasca_rocky",
    expression = "0.75"
  },
  {
    type = "noise-expression",
    name = "rabbasca_rocky_variance",
    expression = "multioctave_noise{x = x, y = y, persistence = 1.3, input_scale = 10, seed0 = map_seed, seed1 = 11, octaves = 7 } * 0.01 * rabbasca_elevation"
  },
  
  {
    type = "noise-function",
    name = "rabbasca_rocks",
    parameters = {"scale"},
    expression = "aquilo_spot_noise{seed = 442,\z
                                    count = 2 + 2 / control:rabbasca_rocks:frequency,\z
                                    skip_offset = 1,\z
                                    region_size = 20 + 120 / (0.1 + control:rabbasca_rocks:size),\z
                                    density = 0.6,\z
                                    radius = scale * 1.8,\z
                                    favorability = 1} - clamp(rabbasca_fertile, 0, 1)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_fertile",
    expression = "min(0, - 2 * rabbasca_down(1)) - 0.2 + \z
            min(rabbasca_starting_mask, 0.7 * multioctave_noise{x = x, y = y, persistence = 0.8, input_scale = 1/3.5, seed0 = map_seed, seed1 = 'yummyrocks', octaves = 8 })\z
            * aquilo_spot_noise{seed = 71632,\z
                                    count = 4 + 3 * control:rabbasca_carotenoids:frequency,\z
                                    skip_offset = 2,\z
                                    region_size = 400 + 300 / control:rabbasca_carotenoids:frequency,\z
                                    density = 1,\z
                                    radius = 20 + 4 * control:rabbasca_carotenoids:size,\z
                                    favorability = 1}"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_pools",
    expression = "(rabbasca_down(1) > 0) * (rabbasca_harene_cracks * 0.4 + rabbasca_down(1) * 2)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_vaults",
    expression = "rabbasca_vault_spots(rabbasca_camp_size)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_vaults_holes",
    expression = "rabbasca_vault_spots(rabbasca_ug_hole_size)"
  },
  {
    type = "noise-function",
    name = "rabbasca_vault_spots",
    parameters = {"spot_size"},
    expression = "clamp(max(rabbasca_starting_camp(spot_size), \z
                            aquilo_spot_noise{seed = 9312,\z
                              count = 3 + 3 * control:rabbasca_vaults:frequency,\z
                              skip_offset = 0,\z
                              region_size = 300 + 500 / control:rabbasca_vaults:size,\z
                              density = 1,\z
                              radius = spot_size,\z
                              favorability = 3\z
                            }), 0, 1)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_cracks",
    expression = "multioctave_noise{x = x, y = y, persistence = 0.21, seed0 = map_seed, input_scale = 24 / rabbasca_pool_size, seed1 = 'purple', octaves = 4 }"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_richness",
    expression = "(50000 + 2000 * basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 'feedme'}) * control:harene:richness"
  },
  {
    type = "noise-function",
    name = "rabbasca_down",
    parameters = {"scale"},
    expression = "clamp(max(rabbasca_starting_pool, \z
                      min(rabbasca_starting_mask, aquilo_spot_noise{seed = 9312,\z
                                    count = 1 + 2 * control:harene:frequency,\z
                                    skip_offset = 1,\z
                                    region_size = 300 + 500 / control:harene:frequency,\z
                                    density = 1,\z
                                    radius = rabbasca_pool_size * scale,\z
                                    favorability = 3})), 0, 1)",
  },
  {
    type = "noise-expression",
    name = "rabbasca_elevation",
    --intended_property = "elevation",
    expression = "clamp(down_mountain + a * 0.062 + b * 0.08, -1, 1) ",
    local_expressions = {
      down_mountain = "min(rabbasca_down(1), 0.83 - rabbasca_down(1)) * 2.3",
      a = "multioctave_noise{x = x, y = y, persistence = 0.3, seed0 = map_seed, seed1 = 0, input_scale = 3, octaves = 5 }",
      b  = "multioctave_noise{x = x, y = y, persistence = 1.4, seed0 = map_seed, input_scale = 1/2, seed1 = 3, octaves = 7 }",                          
    }
  },
  {
    type = "noise-expression",
    name = "rabbasca_devourer_territory_radius",
    expression = 297
  },
  {
    type = "noise-expression",
    name = "rabbasca_devourer_territory_expression",
    expression = "voronoi_cell_id{x = x + 1000 * rabbasca_devourer_territory_radius,\z
                                  y = y + 1000 * rabbasca_devourer_territory_radius,\z
                                  seed0 = map_seed,\z
                                  seed1 = 0,\z
                                  grid_size = rabbasca_devourer_territory_radius,\z
                                  distance_type = 'manhattan',\z
                                  jitter = 1} * rabbasca_underground_elevation * rabbasca_underground_elevation"
  },
  {
    type = "noise-expression",
    name = "rabbasca_underground_elevation",
    expression = "1 - rabbasca_vaults_holes"
  },
  {
    type = "noise-expression",
    name = "rabbasca_underground_lithium_amide",
    expression = "(rabbasca_underground_elevation > 0.9)\z
                  * min(\z
                    basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 'lavalava', input_scale = 1/80 },  \z
                    basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 'lavaaval', input_scale = 1/65 },  \z
                    basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 57123, input_scale = 1/96 }, \z
                    multioctave_noise{x = x, y = y, persistence = 0.5, seed0 = map_seed, seed1 = 'lavaoncrack', input_scale = 1/5, octaves = 3 }\z
                  ) - 0.25"
  },
  {
    type = "noise-expression",
    name = "rabbasca_underground_resources",
    expression = "(0.7 - rabbasca_underground_elevation)\z
                  * (0.7 + multioctave_noise{x = x, y = y, persistence = 0.57, seed0 = map_seed, seed1 = 'kindoflikeasteroidcrushing', input_scale = 0.5, output_scale = 0.3, octaves = 3 })"
  },
}