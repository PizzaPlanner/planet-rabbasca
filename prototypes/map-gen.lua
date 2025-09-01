-- based on https://github.com/wube/factorio-data/blob/2c2abc2b1d4cc4e8e9cac6d8e6351308004a406b/space-age/prototypes/planet/planet-aquilo-map-gen.lua
data:extend{
  {
    type = "noise-expression",
    name = "harene_spot_size",
    expression = "7 * sqrt(control:harene:size)"
  },
  {
    type = "noise-expression",
    name = "harene_area_size",
    expression = "14 * sqrt(control:harene:size)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_starting_mask",
    -- exclude random spots from the inner 400 tiles, 120 tile blur
    expression = "clamp((distance - 400) / 60, -1, 1)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_carrot_noise",
    expression = "-1 + 2 * (rabbasca_fertile > 0.9)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_plateau",
    expression = "clamp(pow(rabbasca_elevation*2, 5) - 0.5, -1, 1)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_low",
    expression = "clamp(-pow(rabbasca_elevation*2, 5) - 0.2, -1, 1)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_icy",
    expression = "max(rabbasca_low, rabbasca_harene_pools * 0.4)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_rocky",
    expression = "(rabbasca_plateau * rabbasca_low + rabbasca_elevation) * 0.4 * control:rabbasca_noise:richness"
  },
  {
    type = "noise-expression",
    name = "rabbasca_rocks",
    expression = "rabbasca_rocky * 0.3 * aquilo_spot_noise{seed = 442,\z
                                    count = 7,\z
                                    skip_offset = 1,\z
                                    region_size = 25 + 20 / control:harenetest:frequency,\z
                                    density = 0.05,\z
                                    radius = 3 * sqrt(control:harenetest:size),\z
                                    favorability = 1} * control:harenetest:size"
  },
  {
    type = "noise-expression",
    name = "rabbasca_fertile",
    expression = "rabbasca_plateau * 0.7 + aquilo_spot_noise{seed = 931,\z
                                    count = 7 + control:harenetest:richness,\z
                                    skip_offset = 1,\z
                                    region_size = 25 + 80 / control:harenetest:frequency,\z
                                    density = control:harenetest:frequency,\z
                                    radius = 12 * sqrt(control:harenetest:size),\z
                                    favorability = 3} * 0.6"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_spots",
    expression = "aquilo_spot_noise{seed = 931,\z
                                    count = 1 + control:harene:richness,\z
                                    skip_offset = 1,\z
                                    region_size = 400 + 700 / control:harene:frequency,\z
                                    density = control:harenetest:frequency,\z
                                    radius = harene_spot_size,\z
                                    favorability = 3}"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_areas",
    expression = "aquilo_spot_noise{seed = 931,\z
                                    count = 3 * control:harene:richness,\z
                                    skip_offset = 1,\z
                                    region_size = 400 + 700 / control:harene:frequency,\z
                                    density = 2,\z
                                    radius = harene_area_size,\z
                                    favorability = 3}"
  },
  {
    type = "noise-expression",
    name = "rabbasca_starting_harene",
    expression = "starting_spot_at_angle{angle = aquilo_angle + 180, distance = 35, radius = harene_spot_size, x_distortion = 0, y_distortion = 0}"
  },
  {
    type = "noise-expression",
    name = "rabbasca_starting_harene_area",
    expression = "starting_spot_at_angle{angle = aquilo_angle + 180, distance = 35, radius = harene_area_size, x_distortion = 0, y_distortion = 0}"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_center_probability",
    expression = "(control:harene:size > 0)\z
                  * (max(rabbasca_starting_harene,\z
                         min(rabbasca_starting_mask, rabbasca_harene_spots))) * 0.8"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_pools",
    expression = "clamp(max(rabbasca_harene_center_probability, (control:harene:size > 0)\z
                  * (max(rabbasca_starting_harene_area,\z
                         min(rabbasca_starting_mask, rabbasca_harene_areas))) * 0.8 + clamp(rabbasca_harene_cracks, -0.5, 1) * 0.35), 0, 1)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_cracks",
    expression = "multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 0, octaves = 5 }"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_vent_probability",
    expression = "rabbasca_harene_center_probability"
  },
  {
    type = "noise-expression",
    name = "rabbasca_harene_richness",
    expression = "50000 + 2000 * basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 0}"
  },
  {
    type = "noise-expression",
    name = "rabbasca_spot_size",
    expression = 17
  },
  {
    type = "noise-expression",
    name = "rabasca_up",
    expression = "aquilo_spot_noise{seed = 9312,\z
                                    count = 3 * control:rabbasca_noise:frequency,\z
                                    skip_offset = 0,\z
                                    region_size = 400 + 700 / control:rabbasca_noise:size,\z
                                    density = 2,\z
                                    radius = 13 + 3 * b,\z
                                    favorability = 3}",
  },
  {
    type = "noise-expression",
    name = "rabasca_down",
    expression = "aquilo_spot_noise{seed = 9312,\z
                                    count = 3 * control:rabbasca_noise:frequency,\z
                                    skip_offset = 2,\z
                                    region_size = 400 + 700 / control:rabbasca_noise:size,\z
                                    density = 2,\z
                                    radius = harene_area_size * 3,\z
                                    favorability = 3}",
  },
  {
    type = "noise-expression",
    name = "rabbasca_elevation",
    --intended_property = "elevation",
    expression = "up_crater + down_crater + a * 0.05",
    -- expression = "clamp(1 - lerp(blended, maxed, 0.4) * control:rabbasca_noise:size - rabbasca_harene_pools, -1, 1)",
    local_expressions = {
      up_crater = "min(rabasca_up, 0.62 - rabasca_up) * 2 * control:rabbasca_noise:richness + 0.03 * b",
      down_crater = "min(rabasca_down, 0.89 - rabasca_down) * 2 * control:rabbasca_noise:richness + 0.072 * b",
      a = "multioctave_noise{x = x, y = y, persistence = 0.3, seed0 = map_seed, seed1 = 0, input_scale = 10, octaves = 5 * control:rabbasca_noise:size }",
      b  = "multioctave_noise{x = x, y = y, persistence = 1.4, seed0 = map_seed, input_scale = 1/3, seed1 = 3, octaves = 7 * control:rabbasca_noise:size }",
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