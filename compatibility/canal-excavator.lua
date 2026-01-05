if not mods["canal-excavator"] then return end

data:extend({{
  type = "mod-data",
  name = "canex-rabbasca-config",
  data_type = "canex-surface-config",
  data = {
    surfaceName = "rabbasca",
    localisation = {"space-location-name.rabbasca"},
    oreStartingAmount = 60,
    mining_time = 3,
    tint = {r = 60, g = 60, b = 60},
    mineResult = "carbon"
  }
}})