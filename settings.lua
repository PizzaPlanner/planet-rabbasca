if mods["any-planet-start"] then
  APS.add_choice("rabbasca")
end

data:extend{
  {
    type = "bool-setting",
    name = "rabbasca-cap-bunnyhop-research",
    setting_type = "startup",
    default_value = false,
    allow_blank = false,
    order="a[balance]"
  },
  {
    type = "bool-setting",
    name = "rabbasca-bunnyhop-force-naked",
    setting_type = "startup",
    default_value = false,
    allow_blank = false,
    order="a[balance]"
  },
  {
    type = "bool-setting",
    name = "rabbasca-harene-easy-mode",
    setting_type = "startup",
    default_value = false,
    allow_blank = false,
    order="a[balance]"
  },
  {
    type = "bool-setting",
    name = "rabbasca-no-extra-category",
    setting_type = "startup",
    default_value = false,
    allow_blank = false,
    order="u[ux]"
  },
  {
    type = "bool-setting",
    name = "rabbasca-bunnyhop-rabbasca-only",
    setting_type = "startup",
    default_value = false,
    allow_blank = false,
    order="a[balance]"
  },
  {
    type = "double-setting",
    name = "rabbasca-surface-megawatts",
    setting_type = "startup",
    -- hidden = true,
    default_value = 30,
    minimum_value = 0.01,
    maximum_value = 50000,
    allow_blank = false,
    order="a[balance]"
  },
  {
    type = "bool-setting",
    name = "rabbasca-ears-local-only",
    setting_type = "startup",
    default_value = false,
    allow_blank = false,
    order="a[balance]"
  },
  {
    type = "string-setting",
    name = "rabbasca-orbits",
    setting_type = "startup",
    default_value = "gleba",
    allowed_values = {
      "gleba",
      "nauvis",
      "fulgora",
      "vulcanus"
    },
    allow_blank = false,
    order="o[other]"
  },
  {
    type = "double-setting",
    name = "rabbasca-evolution-per-vault",
    setting_type = "runtime-global",
    default_value = 4,
    minimum_value = 0,
    maximum_value = 100,
    allow_blank = false,
    order="a[balance]"
  },
  {
    type = "int-setting",
    name = "rabbasca-bunnyhop-cooldown",
    setting_type = "runtime-global",
    default_value = 120,
    minimum_value = 0,
    maximum_value = 3600,
    allow_blank = false,
    order="a[balance]"
  },
  {
    type = "string-setting",
    name = "rabbasca-warp-inventory-name",
    setting_type = "runtime-global",
    default_value = "[virtual-signal=rabbasca-warp-inventory] Warp inventory content",
    allow_blank = false,
    hidden = true,
    order="u[ux]"
  },
  {
    type = "bool-setting",
    name = "rabbasca-debug-mode",
    setting_type = "runtime-global",
    default_value = false,
    hidden = true,
    order="z[debug]"
  },
  {
    type = "bool-setting",
    name = "rabbasca-show-alertness-ui",
    setting_type = "runtime-per-user",
    default_value = true,
    allow_blank = false,
    order="u[ux]"
  },
}