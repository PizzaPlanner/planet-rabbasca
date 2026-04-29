if not mods["skewer_planet_vesta"] then return end
-- Copy of vesta's final fixes code for the ears variant

cryoplant = data.raw["assembling-machine"]["harene-infused-cryogenic-plant"]
cryoplant.fluid_boxes[1].pipe_connections[1].connection_category = {"fusion-plasma", "default"}
cryoplant.fluid_boxes[2].pipe_connections[1].connection_category = {"fusion-plasma", "default"}
cryoplant.fluid_boxes[3].pipe_connections[1].connection_category = {"fusion-plasma", "default"}
cryoplant.fluid_boxes[4].pipe_connections[1].connection_category = {"fusion-plasma", "default"}
cryoplant.fluid_boxes[5].pipe_connections[1].connection_category = {"fusion-plasma", "default"}
cryoplant.fluid_boxes[6].pipe_connections[1].connection_category = {"fusion-plasma", "default"}