local rabbasca = game.surfaces["rabbasca"]
if not rabbasca then return end 

rabbasca.regenerate_decorative({"rabbasca-gravewort", "rabbasca-asterisk-mini"})
rabbasca.regenerate_entity({"carotenoid-ore"})
game.print("[planet=rabbasca] Version 0.19 changed [entity=carotenoid-ore] placement changed slightly. Previously mined ore has been regenerated")