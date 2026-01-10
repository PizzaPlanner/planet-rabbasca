data:extend {
  {
    type = "noise-expression",
    name = "rabbasca_underground_starting_island",
    expression = "distance + 12 * basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 'warpten', input_scale = 1/5 } < 85"
  },
  {
    type = "noise-expression",
    name = "rabbasca_underground_elevation",
    expression = "max(rabbasca_underground_starting_island, rabbasca_underground_high_spots)"
  },
  {
    type = "noise-expression",
    name = "rabbasca_underground_lava",
    expression = "-rabbasca_underground_elevation"
  },
{
    type = "noise-expression",
    name = "rabbasca_underground_high_spots",
    expression = "aquilo_spot_noise{seed = 156213,\z
                                    count = 1,\z
                                    skip_offset = 0,\z
                                    region_size = 162,\z
                                    density = 0.66,\z
                                    radius = 8,\z
                                    favorability = 5} * 3 + basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 'explosivesbutdifferent', input_scale = 1/8} * 0.4 - 0.5"
  },
  {
    type = "noise-expression",
    name = "rabbasca_underground_lithium_amide",
    expression = "rabbasca_underground_high_spots - 0.9"
  },
  {
    type = "noise-expression",
    name = "rabbasca_underground_resources",
    expression = "(0.7 - rabbasca_underground_elevation)\z
                  * (0.7 + multioctave_noise{x = x, y = y, persistence = 0.57, seed0 = map_seed, seed1 = 'kindoflikeasteroidcrushing', input_scale = 0.5, output_scale = 0.3, octaves = 3 })"
  },
}