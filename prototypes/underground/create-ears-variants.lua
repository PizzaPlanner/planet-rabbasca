local costs = {
  {
    { type = "item", name = nil, amount = 1 }, -- replaced with self
    { type = "item", name = "harene-ears-subcore", amount = 1 },
    { type = "fluid", name = "harene-gas", amount = 30 },
  },
}
local lamp = Rabbasca.create_ears_variant(data.raw["lamp"]["small-lamp"], "rabbasca-underground", costs[1])
data.raw["lamp"][lamp].glow_size = 48
data.raw["lamp"][lamp].glow_color_intensity = 3
data.raw["lamp"][lamp].light.size = 48
data.raw["lamp"][lamp].light_when_colored.size = 48
