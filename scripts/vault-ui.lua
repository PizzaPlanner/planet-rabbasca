script.on_event(defines.events.on_gui_closed, function(event)
    if storage.console_gui then 
        storage.console_gui.destroy()
        storage.console_gui = nil
    end
end)

script.on_event(defines.events.on_gui_opened, function(event)
    if not event.entity then return end
    if storage.console_gui then return end
    local entity = event.entity
    local player = game.get_player(event.player_index)
    local anchor = {
        gui = defines.relative_gui_type.assembling_machine_gui, 
        position = defines.relative_gui_position.top
    }
    storage.console_gui = player.gui.relative.add{type="frame", anchor=anchor, direction = "vertical"}
    storage.console_gui.add{
        type = "sprite-button",
        name = "rabbasca-global-network-btn",
        sprite = "space-location/rabbasca",
        style = "frame_action_button"
    }
end)

script.on_event(defines.events.on_gui_click, function(event)
    local player = game.get_player(event.player_index)
    if not player or not event.element.valid then return end

    if event.element.name == "rabbasca-global-network-btn" then
        player.opened = defines.gui_type.global_electric_network
    elseif event.element.parent.name == "rabbasca_spawns" then
        player.open_factoriopedia_gui(prototypes.entity[event.element.name])
    end
end)