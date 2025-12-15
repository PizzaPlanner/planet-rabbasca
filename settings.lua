if mods["any-planet-start"] then
  APS.add_choice("rabbasca")
end

data:extend{
  {
    type = "bool-setting",
    name = "rabbasca-cap-bunnyhop-research",
    setting_type = "startup",
    default_value = false,
    allow_blank = false
  },
  {
    type = "bool-setting",
    name = "rabbasca-bunnyhop-force-naked",
    setting_type = "startup",
    default_value = false,
    allow_blank = false
  },
  {
    type = "bool-setting",
    name = "rabbasca-harene-easy-mode",
    setting_type = "startup",
    default_value = false,
    allow_blank = false
  },
  {
    type = "bool-setting",
    name = "rabbasca-no-extra-category",
    setting_type = "startup",
    default_value = false,
    allow_blank = false
  },
  {
    type = "bool-setting",
    name = "rabbasca-bunnyhop-rabbasca-only",
    setting_type = "startup",
    default_value = false,
    allow_blank = false
  },
  {
    type = "double-setting",
    name = "rabbasca-surface-megawatts",
    setting_type = "startup",
    -- hidden = true,
    default_value = 30,
    minimum_value = 0.01,
    maximum_value = 50000,
    allow_blank = false
  },
  {
    type = "double-setting",
    name = "rabbasca-evolution-per-vault",
    setting_type = "runtime-global",
    default_value = 4,
    minimum_value = 0,
    maximum_value = 100,
    allow_blank = false
  },
  {
    type = "bool-setting",
    name = "rabbasca-show-alertness-ui",
    setting_type = "runtime-per-user",
    default_value = true,
    allow_blank = false
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
    allow_blank = false
  },
  {
    type = "bool-setting",
    name = "rabbasca-disable-train-extensions",
    setting_type = "startup",
    default_value = true,
    allow_blank = false
  },
}