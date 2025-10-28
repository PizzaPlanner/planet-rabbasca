local utils = require("__any-planet-start__.utils")

-- since rocket silo is only usable post-aquilo on rabbasca, make sure there is one planet available to jump to not gated behind rocket silo
-- muluna-compatibility: run after muluna.data-updates, to revert asteroid-collector prerequisite
utils.set_prerequisites("planet-discovery-gleba", {"landfill", "bunnyhop-engine"})