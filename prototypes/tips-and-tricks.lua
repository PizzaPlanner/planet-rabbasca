data:extend {{
    type = "tips-and-tricks-item",
    name = "rabbasca-briefing",
    category = "space-age",
    tag = "[planet=rabbasca]",
    indent = 0,
    order = "r[rabbasca]-a",
    trigger = {
        type = "research",
        technology = "planet-discovery-rabbasca",
    },
    simulation = {
        planet = "rabbasca",
        generate_map = true,
        hide_health_bars = false,
        init = [[
            local surface = game.surfaces[1]

            surface.daytime = 0.0
            game.simulation.camera_alt_info = true
            game.simulation.camera_zoom = 0.9

            surface.freeze_daytime = true
            surface.create_global_electric_network()
            surface.create_entity { name = "rabbasca-energy-source", position = {0, 0}}
            game.forces.player.technologies["rabbascan-vault-access"].researched = true

            for x = -5, 5, 1 do
            for y = -5, 5 do
                surface.set_chunk_generated_status({x, y}, defines.chunk_generated_status.entities)
            end
            end

            for x = -32, 64, 1 do
            for y = -32, 64 do
                surface.set_tiles{{position = {x, y}, name = "rabbasca-rough"}}
            end
            end

            surface.create_entities_from_blueprint_string {
                string = "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",
                position = {0, -0}
                }
                
            local chest = surface.find_entities_filtered{ name = "steel-chest"}[1]
            chest.get_inventory(defines.inventory.chest).insert({name = "vault-access-key-u", count = 2})
            local center = chest.bounding_box.left_top
            game.simulation.camera_position = center
            local vault = surface.create_entity {
                name = "rabbasca-vault",
                position = {center.x - 2, center.y}
            }
            vault.destructible = false
            surface.find_entities_filtered{ name = "rabbasca-vault-hacked"}[1].force = game.forces.player
            surface.find_entities_filtered{ name = "locomotive"}[1].get_inventory(defines.inventory.fuel).insert({name = "rabbasca-turbofuel"})
            surface.find_entities_filtered{ name = "gun-turret"}[1].get_inventory(defines.inventory.turret_ammo).insert({name = "firearm-magazine", count = 1})
        ]],
        checkboard = false,
        mute_wind_sounds = true,
    },
}}