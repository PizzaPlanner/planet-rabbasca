local categories = {
    "assembling-machine",
    "furnace",
    "lab",
    "rocket-silo",
    "roboport",
    "inserter",
    "mining-drill",
    "cargo-bay",
    "cargo-landing-pad",
    "asteroid-collector",
    "thruster",
    "agricultural-tower",
    "burner-generator",
    "generator",
    "boiler",
}

local function is_machine(name)
    for _, category in pairs(categories) do
        if data.raw[category] and data.raw[category][name] then return true end
    end
    return false
end

local assembled_categories = data.raw["assembling-machine"]["assembling-machine-3"].crafting_categories
local function is_assembled(recipe)
    for _, category in pairs(assembled_categories) do
        if not recipe.category or (recipe.category == category) then return true end
        if recipe.additional_categories then 
            for _, add in pairs(recipe.additional_categories) do
                if add == category then return true end
            end
        end
    end
    return false
end

local function produces_placeable(recipe)
    local product = recipe.main_product or (recipe.results and recipe.results[1] and recipe.results[1].name)
    return product and is_machine(product)
end

for _, recipe in pairs(data.raw["recipe"]) do
    if is_assembled(recipe) and produces_placeable(recipe) then
        Rabbasca.make_complex_machinery(recipe)
    end
end

-- non-generalizable things 
Rabbasca.make_complex_machinery(data.raw["item"]["space-platform-foundation"])
-- Muluna compatibility
Rabbasca.make_complex_machinery(data.raw["item"]["low-density-space-platform-foundation"])