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
for _, category in pairs(categories) do
    for _, thing in pairs(data.raw[category]) do
        rutil.make_complex_machinery(thing, true)
    end
end

-- non-generalizable things 
rutil.make_complex_machinery(data.raw["item"]["space-platform-foundation"])
rutil.make_complex_machinery(data.raw["mining-drill"]["big-mining-drill"])
-- Muluna compatibility
rutil.make_complex_machinery(data.raw["item"]["low-density-space-platform-foundation"])