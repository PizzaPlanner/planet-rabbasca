-- duplicated infinity researches are not registered through api and thus dont do anything
if not mods["Rocs-Hardcore-Delayed-Tech-Tree"] then return end
local original_data = data.raw["mod-data"]["rabbasca-bunnyhop-effects"].data["bunnyhop-engine-4"]
if not original_data then return end
if data.raw["technology"]["bunnyhop-engine-5"] then
    data.raw["mod-data"]["rabbasca-bunnyhop-effects"].data["bunnyhop-engine-5"] = table.deepcopy(original_data)
end
if data.raw["technology"]["bunnyhop-engine-6"] then
    data.raw["mod-data"]["rabbasca-bunnyhop-effects"].data["bunnyhop-engine-6"] = table.deepcopy(original_data)
end