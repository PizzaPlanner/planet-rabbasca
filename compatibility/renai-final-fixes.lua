if not mods["RenaiTransportation"] then return end
-- https://github.com/PizzaPlanner/planet-rabbasca/issues/17

-- RenaiTransportation looks up a thrower's range by entity name (mod-data "RTRealRange<name>"):
-- without its own entry the copy crashes Renai when built
for name, variant in pairs(Rabbasca.ears_variants) do
    local range = data.raw["mod-data"] and data.raw["mod-data"]["RTRealRange" .. name]
    if range then
        data:extend { { type = "mod-data", name = "RTRealRange" .. variant.name, data = table.deepcopy(range.data) } }
    end
end