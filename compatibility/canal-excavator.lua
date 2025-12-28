if not mods["canal-excavator"] then return end

data:extend({{
  type = "mod-data",
  name = "canex-rabbasca-config",
  data_type = "canex-surface-config",
  data = {
    surfaceName = "rabbasca",
    localisation = {"space-location-name.rabbasca"},
    oreStartingAmount = 10,
    mining_time = 6,
    tint = {r = 120, g = 120, b = 120},
    mineResult = "stone"
  }
}})