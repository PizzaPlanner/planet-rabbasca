local rutil = require("__planet-rabbasca__.util")

local muluna_rocket_part = data.raw["recipe"]["rocket-part-muluna"]
if muluna_rocket_part then rutil.not_on_harenic_surface(muluna_rocket_part) end