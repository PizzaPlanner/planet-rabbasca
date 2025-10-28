local rutil = require("__planet-rabbasca__.util")

if settings.startup["remove-tree-seeding-requirement"].value then
    local preq = data.raw["technology"]["fish-breeding"].prerequisites
    for i = 1, #preq do 
        if preq[i] == "tree-seeding" then
            table.remove(preq, i)
            table.insert(preq, "agricultural-science-pack")
            break
        end
    end
end

rutil.not_on_harenic_surface(data.raw["recipe"]["rocket-part"])