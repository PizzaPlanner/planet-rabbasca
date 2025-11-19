local rabbasca = game.surfaces["rabbasca"]
if not rabbasca then return end 

for _, e in pairs(rabbasca.find_entities_filtered{force = "enemy"}) do
    e.force = game.forces.rabbascans
end