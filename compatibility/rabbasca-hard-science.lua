if not settings.startup["rabbasca-hard-science"].value then return end

table.insert(data.raw["recipe"]["athletic-science-pack"].ingredients, { type = "item", name = "exoskeleton-equipment", amount = 1 })
data.raw["recipe"]["athletic-science-pack"].results[1].amount = 4