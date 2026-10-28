data:extend { 
{
  type = "change-surface-achievement",
  surface = "rabbasca",
  name = "visit-rabbasca",
  order = "a[progress]-g[visit-planet]-e[rabbasca]",
  icon = "__rabbasca-assets__/graphics/recolor/textures/achievement-visit-rabbasca.png",
  icon_size = 128
},
{
  type = "achievement",
  name = "rabbasca-meltdown",
  order = "g[quality]-r[meltdown]",
  icon = "__rabbasca-assets__/graphics/recolor/textures/achievement-meltdown.png",
  icon_size = 128,
},
{
  type = "achievement",
  name = "rabbasca-build-more-pylons",
  order = "r[rabbasca]-a[pylon]",
  icons = Rabbasca.icons({
      { icon = "__rabbasca-assets__/graphics/recolor/textures/achievement-bg-upper.png", icon_size = 128 },
      { icon = "__rabbasca-assets__/graphics/by-hurricane/conduit-icon-big.png", icon_size = 640, scale = 0.75, shift = {0, -2} },
      { icon = "__rabbasca-assets__/graphics/recolor/textures/achievement-bg-lower.png", icon_size = 128 },
  })
},
}