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
    type = "noise-expression",
    name = "rabbasca_starting_camp",
    expression = "starting_spot_at_angle{angle = aquilo_angle + 150, distance = 120, radius = rabbasca_camp_size, x_distortion = 0, y_distortion = 0}"
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
    expression = "6 + 6 * sqrt(control:rabbasca_vaults:size)"
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
                                    count = 3,\z
                                    skip_offset = 1,\z
                                    region_size = 70 + 90 / control:rabbasca_rocks:frequency,\z
                                    density = 0.32,\z
                                    radius = scale * (1.1 + 0.7 * sqrt(control:rabbasca_rocks:size)),\z
                                    favorability = 1} * control:rabbasca_rocks:size - clamp(rabbasca_fertile, 0, 1)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_fertile",
    expression = "min(0, - 2 * rabbasca_down) - 0.2 + \z
            min(rabbasca_starting_mask, 0.7 * multioctave_noise{x = x, y = y, persistence = 0.8, input_scale = 1/3.5, seed0 = map_seed, seed1 = 'yummyrocks', octaves = 8 })\z
            * aquilo_spot_noise{seed = 71632,\z
                                    count = 4 + 3 * control:rabbasca_carotenoids:frequency,\z
                                    skip_offset = 2,\z
                                    region_size = 400 + 300 / control:rabbasca_carotenoids:frequency,\z
                                    density = 1,\z
                                    radius = 20 + 4 * control:rabbasca_carotenoids:size,\z
                                    favorability = 1}"
                -- * multioctave_noise{x = x/4.2, y = y/4.8, persistence = 0.2, seed0 = map_seed, seed1 = 'bewarethehare', octaves = 9 })"
    -- expression = "0.4 + rabbasca_up * rabbasca_crater + rabbasca_up_variance * (0.8 - rabbasca_elevation)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_pools",
    expression = "(rabbasca_down > 0) * (rabbasca_harene_cracks * 0.4 + rabbasca_down * 2)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_camps",
    expression = "clamp(max(rabbasca_starting_camp, \z
                      min(rabbasca_starting_mask, aquilo_spot_noise{seed = 9312,\z
                                    count = 1 + 3 * control:rabbasca_vaults:frequency,\z
                                    skip_offset = 0,\z
                                    region_size = 300 + 500 / control:rabbasca_vaults:size,\z
                                    density = 1,\z
                                    radius = rabbasca_camp_size,\z
                                    favorability = 3})), 0, 1)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_pools_deep",
    expression = "(rabbasca_down > 0.8) * (3 + rabbasca_harene_cracks * 0.5)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_pools_center",
    expression = "5 * (rabbasca_down > 0.93)"
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
    type = "noise-expression",
    name = "rabbasca_crater",
    expression = "rabbasca_down > 0.3"
  },
  {
    type = "noise-expression",
    name = "rabbasca_down",
    expression = "clamp(max(rabbasca_starting_pool, \z
                      min(rabbasca_starting_mask, aquilo_spot_noise{seed = 9312,\z
                                    count = 1 + 3 * control:harene:frequency,\z
                                    skip_offset = 1,\z
                                    region_size = 300 + 500 / control:harene:frequency,\z
                                    density = 1,\z
                                    radius = rabbasca_pool_size,\z
                                    favorability = 3})), 0, 1)",
  },
   {
    type = "noise-expression",
    name = "rabbasca_up_variance",
    expression = "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 817231}",
  },
  {
    type = "noise-expression",
    name = "rabbasca_elevation",
    --intended_property = "elevation",
    expression = "clamp(down_mountain + a * 0.062 + b * 0.08, -1, 1) ",
    local_expressions = {
      down_mountain = "min(rabbasca_down, 0.83 - rabbasca_down) * 2.3",
      a = "multioctave_noise{x = x, y = y, persistence = 0.3, seed0 = map_seed, seed1 = 0, input_scale = 3, octaves = 5 }",
      b  = "multioctave_noise{x = x, y = y, persistence = 1.4, seed0 = map_seed, input_scale = 1/2, seed1 = 3, octaves = 7 }",
      voronoi_large = "voronoi_facet_noise{   x = x + aquilo_wobble_x * 2,\z
                                        y = y + aquilo_wobble_y * 2,\z
                                        seed0 = map_seed,\z
                                        seed1 = 'aquilo-cracks',\z
                                        grid_size = 24,\z
                                        distance_type = 'euclidean',\z
                                        jitter = 1}",
                          
    }
  },
}