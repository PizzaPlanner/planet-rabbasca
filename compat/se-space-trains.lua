if not data.raw["cargo-wagon"]["space-cargo-wagon"] then return end
if not data.raw["technology"]["tech-space-trains"] then return end
if not settings.startup["rabbasca-train-equipment"].value then return end

local wagon = data.raw["cargo-wagon"]["space-cargo-wagon"]
wagon.equipment_grid = "train-equipment-grid"

table.insert(data.raw["technology"]["rabbasca-cargo-wagon"].prerequisites, "tech-space-trains")