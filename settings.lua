if mods["any-planet-start"] then
  APS.add_choice("rabbasca")
end

if mods["se-space-trains"] then
  data:extend{
    {
      type = "bool-setting",
      name = "rabbasca-train-equipment",
      setting_type = "startup",
      default_value = true,
      allow_blank = false
    },
  }
end