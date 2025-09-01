function init_moon_chest(surface) 
    if settings.global["moonfolk-inventory-created"].value == true then return end
    for _, vent in pairs(surface.find_entities_filtered({name = "harene-vent"})) do
        local pos = surface.find_non_colliding_position("harene-extractor", vent.position, 0, 1)
        local chest = surface.create_entity{
            name = "moonfolk-chest",
            position = {pos.x - 2, pos.y + 2},
            force = game.forces.player,
            raise_built = true
        }
        if chest then
            local miner = surface.create_entity{
                name = "harene-extractor",
                position = pos,
                force = game.forces.player,
                raise_built = true
            }
            local chest2 = 
                surface.create_entity{
                    name = "moonfolk-chest",
                    position = surface.find_non_colliding_position("moonfolk-chest", vent.position, 7, 1),
                    force = game.forces.player,
                    raise_built = true
            }
            if not miner then -- fallback
                chest.insert{name = "harene-extractor", count = 1 }
            end
            if not chest2 then -- fallback
                chest.insert{name = "moonfolk-chest", count = 1 }
            end
            chest.insert{name = "harene-transmuter", count = 2 }
            chest.insert{name = "rabbasca-harean-assembler", count = 1 }
            settings.global["moonfolk-inventory-created"] = {value = true}
            return
        end
    end
    game.print("[color=red]ERROR[/color]: Could not spawn a moonfolk-chest on rabbasca.")
end

script.on_event(defines.events.on_player_changed_surface,function(event)
    if not game.planets["rabbasca"].surface or game.planets["rabbasca"].surface.index ~= event.surface_index then return end
    init_moon_chest(game.planets["rabbasca"].surface)
end)

script.on_event(defines.events.on_player_created, function(event)
    if not game.planets["rabbasca"].surface then return end
    init_moon_chest(game.planets["rabbasca"].surface)
end)