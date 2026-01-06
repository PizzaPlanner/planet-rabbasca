local TARGET_MACHINE_NAME = "rabbasca-warp-pylon"
local GUI_NAME = "rabbasca_warp_queue"

local function destroy_gui(player)
    if player.gui.relative[GUI_NAME] then
        player.gui.relative[GUI_NAME].destroy()
    end
end

local function create_gui(player, machine)
    destroy_gui(player)

    local data = storage.warp_storage[machine.unit_number].queue
    if not data then return end

    local frame = player.gui.relative.add{
        type = "frame",
        name = GUI_NAME,
        caption = "Warp Queue",
        direction = "vertical",
        anchor = {
            gui = defines.relative_gui_type.assembling_machine_gui,
            position = defines.relative_gui_position.right
        }
    }

    local items = { }
    for _, entry in pairs(data.modules.targets) do
        local key = "[img=entity/item-request-proxy][img=entity/"..entry.entity.proxy_target.name.."]"
        items[key] = (items[key] or 0) + 1
    end
    for _, entry in pairs(data.ghosts.targets) do
        local key = "[img=entity/entity-ghost][img=item/"..entry.name.."]"
        items[key] = (items[key] or 0) + 1
    end
    for _, entry in pairs(data.tiles.targets) do
        local key = "[img=entity/tile-ghost][img=item/"..entry.name.."]"
        items[key] = (items[key] or 0) + 1
    end
    for _, entry in pairs(data.decon.targets) do
        local key = "[img=virtual-signal/signal-deny][img=item/"..entry.name.."]"
        items[key] = (items[key] or 0) + 1
    end

    local items_aggregated = { }
    for k, v in pairs(items) do
        table.insert(items_aggregated, { "", k, " x ", v })
    end

    frame.add {
      type = "list-box",
      items = items_aggregated
    }
end

script.on_event(defines.events.on_gui_opened, function(event)
    if event.gui_type ~= defines.gui_type.entity then return end
    if not event.entity or not event.entity.valid then return end

    local entity = event.entity
    if entity.name ~= TARGET_MACHINE_NAME then return end

    local player = game.get_player(event.player_index)
    if not player then return end

    create_gui(player, entity)
end)

script.on_event(defines.events.on_gui_closed, function(event)
    if event.gui_type == defines.gui_type.entity then
        local player = game.get_player(event.player_index)
        if player then
            destroy_gui(player)
        end
    end
end)
