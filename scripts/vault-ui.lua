local function gui(player) return player.gui.left end

-- Choose which spawner to inspect
local SPAWNER = "rabbasca-vault"
local TARGET_SURFACE = "rabbasca"

-- Interpolate weight for current evo
local function interpolate_weight(points, evo)
    local last_point = points[1]
    for _, point in ipairs(points) do
        if evo < point.evolution_factor then
            local t = (evo - last_point.evolution_factor) /
                      (point.evolution_factor - last_point.evolution_factor)
            return last_point.weight + t * (point.weight - last_point.weight)
        end
        last_point = point
    end
    return last_point.weight
end

-- Compute probabilities
local function get_spawn_probabilities()
    local evo = game.forces.enemy.get_evolution_factor("rabbasca")
    local proto = prototypes.entity[SPAWNER]

    local units = {}
    local total = 0
    for _, def in ipairs(proto.result_units) do
        local w = interpolate_weight(def.spawn_points, evo)
        if w ~= w then w = 0 end
        table.insert(units, {name = def.unit, weight = w})
        total = total + w
    end
    if total == 0 then return units end
    for _, u in ipairs(units) do 
        u.prob = u.weight / total
    end
    return units
end

-- Helper to build UI
local function create_evolution_bar(player)
    if gui(player).rabbasca_evo_frame then return end

    local frame = gui(player).add{
        type = "frame",
        name = "rabbasca_evo_frame",
        direction = "horizontal",
        style = "slot_window_frame"
    }
    -- frame.add{
    --     type = "sprite-button",
    --     sprite= "item/rabbasca-vault-access-protocol",
    --     style = "slot_button",
    --     name = "icon",
    --     number = 0
    -- }
    local right = frame.add {
        type = "flow",
        direction = "vertical",
        name = "right",
        -- style = "shortcut_bar_inner_panel"
    }
    right.add{
        type = "label", 
        name = "evolution_title",
        caption = "Alertness",
        style = "caption_label"
    }
    right.add{
        type = "label", 
        name = "evolution_subtitle",
        caption = "Active",
        style = "caption_label"
    }
    right.add{
        type = "button",
        name = "rabbasca-global-network-btn"
    }
    local list = right.add{
        type = "flow",
        direction = "horizontal",
        name = "rabbasca_spawns",
    }
    for _, unit in pairs(get_spawn_probabilities()) do
        list.add{
            type = "sprite-button",
            sprite= "entity/"..unit.name,
            style = "red_slot_button",
            name = unit.name,
    }
    end
end

-- Remove UI if not needed
local function destroy_evolution_bar(player)
    local frame = gui(player).rabbasca_evo_frame or player.gui.top.rabbasca_evo_frame
    if frame then frame.destroy() end
end

local M = {}

function M.update() 
  for _, player in pairs(game.connected_players) do
    if player.surface ~= game.surfaces["rabbasca"] then
        destroy_evolution_bar(player) 
    return end

    create_evolution_bar(player)
    local evo = storage.rabbasca_evo_last
    local spawns = gui(player).rabbasca_evo_frame.right.rabbasca_spawns
    if spawns then
        for _, prob in  pairs(get_spawn_probabilities()) do
            if spawns[prob.name] then
                local chance = prob.prob or 0
                spawns[prob.name].number = math.floor(chance * 100)
                spawns[prob.name].visible = chance > 0
            end
        end
    end
    local icon = gui(player).rabbasca_evo_frame.icon
    if icon then
        icon.number = math.floor(evo * 100)
    end
    local bar = gui(player).rabbasca_evo_frame.right.evolution_bar
    if bar then
        bar.value = evo
    end
    local title = gui(player).rabbasca_evo_frame.right.evolution_title
    if title then
        title.caption = string.format("[img=space-location/rabbasca] Alertness:\t\t%i%%", evo * 100)
    end
    local subtitle = gui(player).rabbasca_evo_frame.right.evolution_subtitle
    if subtitle then
    subtitle.caption = string.format("Active: [img=item/rabbascan-security-key-e]%i/[img=item/rabbascan-security-key-a]%i/[img=item/rabbascan-security-key-p]%i", 
        storage.rabbasca_active_vault_crafting or 0, storage.rabbasca_active_vault_research or 0, storage.rabbasca_active_vault_power or 0)
    end
    end
end

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
    local frame = storage.console_gui
    frame.add{
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

-- Listen for GUI selection changes
-- script.on_event(defines.events.on_gui_selection_state_changed, function(event)
--     local element = event.element
--     if not (element and element.valid) then return end

--     -- Only handle our teleport UI list
--     if element.name == "bunnyhop_surface_list" then
--         local player = game.get_player(event.player_index)
--         if not player then return end
--         local icon = element.get_item(element.selected_index)[2]
--         local planet = string.match(icon, "%[img=space%-location/(.-)%]")
--         if player.gui.screen.bunnyhop_ui then
--             player.gui.screen.bunnyhop_ui.destroy()
--         end

--         if not planet or not game.planets[planet] then return end

--         local surface = game.planets[planet].surface or game.planets[planet].create_surface()
--         if not surface then return end
--         local radius = surface.get_starting_area_radius()
--         player.force.chart(surface, {{-radius, -radius}, {radius, radius}})

--         local start_pos = surface.find_non_colliding_position("character", {0, 0}, surface.get_starting_area_radius(), 1)  or {0, 0}

--         -- Teleport player
--         if not player.teleport(start_pos, surface) then return end
--     end
-- end)

function M.clear_bunnyhop_ui(player)
    player.gui.screen.bunnyhop_ui.destroy()
    storage.rabbasca_bunnyhopping = (storage.rabbasca_bunnyhopping or 1) - 1
    if storage.rabbasca_bunnyhopping == 0 then
        script.on_event(defines.events.on_player_changed_position, nil)
    end
end

local function on_charge_bunnyhop(event)
    local player = game.get_player(event.player_index)
    if not player then return end

    local frame = player.gui.screen.bunnyhop_ui
    if not (frame and frame.valid) then return end

    
    local pb = frame.bunnyhop_charge
    if not (pb and pb.valid) then return end
    
    local is_character = player.controller_type == defines.controllers.character
    if not is_character then 
        M.clear_bunnyhop_ui(player)
        return
    end
    
    -- player.walking_state.walking = true
    local delta = player.character.effective_speed or 1
    local needed = 100
    pb.value = math.min(1, math.max(pb.value - delta/needed, 0))
    -- player.character.speed = (player.character.speed or 1) * 1.2

    if pb.value > 0 then return end
    
    local list = frame.bunnyhop_surface_list
    local icon = list.get_item(list.selected_index)[2]
    local planet = string.match(icon, "%[img=space%-location/(.-)%]")
    M.clear_bunnyhop_ui(player)

    if not planet or not game.planets[planet] then return end

    local surface = game.planets[planet].surface or game.planets[planet].create_surface()
    if not surface then return end

    local radius = surface.get_starting_area_radius()
    player.force.chart(surface, {{-radius, -radius}, {radius, radius}})
    local start_pos = surface.find_non_colliding_position("character", {0, 0}, surface.get_starting_area_radius(), 1)  or {0, 0}
    -- local pod = surface.create_entity{name="cargo-pod", position=player.position, force=player.force}
    -- -- player.set_controller{type=defines.controllers.character, character=pod.get_driver()}
    -- pod.cargo_pod_destination = {
    --     type = defines.cargo_destination.surface,
    --     surface = surface,
    --     position = start_pos
    -- }


    -- Teleport player
    if not player.teleport(start_pos, surface) then return end
end

function M.extend_bunnyhop_ui(player)
    storage.rabbasca_bunnyhopping = (storage.rabbasca_bunnyhopping or 0) + 1
    script.on_event(defines.events.on_player_changed_position, on_charge_bunnyhop)
end

script.on_event(defines.events.on_player_controller_changed, function(event)
    local player = game.get_player(event.player_index)
    if not player then return end

    if player.gui.screen.bunnyhop_ui then
        M.clear_bunnyhop_ui(player)
    end
end)

return M