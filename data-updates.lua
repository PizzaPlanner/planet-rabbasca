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

require("scripts.not-on-my-lawn")
require("scripts.machine-assembly")
require("scripts.create-ears-variants")