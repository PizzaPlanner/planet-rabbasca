
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
    local evo = game.forces["rabbascans"].get_evolution_factor("rabbasca")
    local proto = game.entity_prototypes["rabbasca-vault-spawner"]

    local units = {}
    local total = 0
    for _, def in ipairs(proto.result_units) do
        local w = interpolate_weight(def.spawn_points, evo)
        if w > 0 then
            table.insert(units, {name = def.unit, weight = w})
            total = total + w
        end
    end

    for _, u in ipairs(units) do
        u.prob = u.weight / total
    end
    return units
end

-- Helper to build UI
local function create_evolution_bar(player)
    if player.gui.top.rabbasca_alertness then
        player.gui.top.rabbasca_alertness.destroy() 
    end
    if not settings.get_player_settings(player)["rabbasca-show-alertness-ui"].value then return end
    
    local vaults = storage.hacked_vaults or 0
    local evo = game.forces["rabbascans"].get_evolution_factor("rabbasca")
    local color = { 0, 1, 0 }
    if evo > 0.9 then color = { 1, 0, 0 } 
    elseif evo > 0.6  then color = { 0.75, 0.25, 0 }
    elseif evo > 0.4  then color = { 1, 1, 0 }
    elseif evo > 0.25 then color = { 0.5, 1, 0 }
    elseif evo > 0.1  then color = { 0.25, 1, 0 }
    end

    local frame = player.gui.top.add{
        type = "frame",
        name = "rabbasca_alertness",
        direction = "horizontal",
        style = "slot_window_frame"
    }
    frame.add{
        type = "sprite-button",
        sprite= "entity/rabbasca-vault-crafter",
        style = "inventory_slot",
        name = "icon",
        number = vaults
    }
    local right = frame.add {
        type = "flow",
        direction = "vertical",
        name = "right",
        -- style = "shortcut_bar_inner_panel"
    }
    right.style.top_padding = 2
    right.add{
        type = "label", 
        name = "evolution_title",
        caption = { "rabbasca-extra.alertness-ui", string.format("%i", evo * 100) }
    }
    local bar = right.add{
        type = "progressbar",
        name = "evolution_bar",
        value = evo
    }
    bar.style.horizontally_stretchable = true
    bar.style.color = color
end

local M = { }
function M.update_bar(player)
    local is_on_rabbasca = player.surface and player.surface.name == "rabbasca"
    local ui = player.gui.top.rabbasca_alertness
    if ui and not is_on_rabbasca then
        ui.destroy()
    elseif is_on_rabbasca then
        create_evolution_bar(player)
    end
end

return M