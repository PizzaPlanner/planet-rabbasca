require("__planet-rabbasca__.scripts.warp.rebuild-warp-network")
if storage.rabbasca_remote_builder and storage.rabbasca_remote_builder.valid then
    storage.rabbasca_remote_builder.get_inventory(defines.inventory.chest).insert({name = "rabbasca-warp-core", count = 10})
    game.print("[planet=rabbasca] Version 0.11 changed the inventory used by [entity=rabbasca-warp-pylon]. See [tip=rabbasca-warp-inventory]. Warp cores from the previous cargo landing pad have been refunded into "..storage.rabbasca_remote_builder.gps_tag)
    storage.rabbasca_remote_builder = nil
end