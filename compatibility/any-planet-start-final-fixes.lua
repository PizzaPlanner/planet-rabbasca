local utils = require("__any-planet-start__.utils")

-- since rocket silo is only usable post-aquilo on rabbasca, make sure there is one planet available to jump to not gated behind rocket silo
-- muluna-compatibility: run after muluna.data-updates, to revert asteroid-collector prerequisite
local parent = settings.startup["rabbasca-orbits"].value
local prerequisites = { "bunnyhop-engine" }
local tech = data.raw["technology"]["planet-discovery-"..parent]
if not tech then return end

for _, req in tech.prerequisites do {
    if req ~= "space-platform-thruster" and req ~= "space-science-pack" and req ~= "asteroid-collector" then
        table.insert(prerequisites, req)
}

utils.set_prerequisites("planet-discovery-"..parent, prerequisites)
utils.remove_packs("planet-discovery-"..parent, {"space-science-pack"})