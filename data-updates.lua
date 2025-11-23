local r = require("__planet-rabbasca__.util")

data.raw["item"]["beta-carotene-barrel"].fuel_category = "carotene"
data.raw["item"]["beta-carotene-barrel"].fuel_value = "27.35MJ"

for _, lab in pairs(data.raw["lab"]) do
  for _, input in pairs(lab.inputs) do
    if input == "automation-science-pack" then
      table.insert(lab.inputs, "athletic-science-pack")
      break
    end
  end
end

if not r.rabbasca.is_aps_planet then
  local gleba = r.rabbasca.parent
  if data.raw["technology"]["planet-discovery-"..gleba] and data.raw["technology"]["planet-discovery-rabbasca"] then
    table.insert(data.raw["technology"]["planet-discovery-rabbasca"].prerequisites, "planet-discovery-"..gleba)
  end
end

require("scripts.not-on-my-lawn")
require("scripts.machine-assembly")
require("scripts.create-ears-variants")

require("compatibility.crushing-industry-updates")