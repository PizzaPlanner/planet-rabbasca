local function gui(player) return player.gui.top end

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
    local proto = game.entity_prototypes[SPAWNER]

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
    if gui(player).rabbasca_evo_frame then return end

    local frame = gui(player).add{
        type = "frame",
        name = "rabbasca_evo_frame",
        direction = "horizontal",
        style = "slot_window_frame"
    }
    frame.add{
        type = "sprite-button",
        sprite= "item/rabbasca-vault-access-protocol",
        style = "slot_button",
        name = "icon",
        number = 0
    }
    local right = frame.add {
        type = "flow",
        direction = "vertical",
        name = "right",
        -- style = "shortcut_bar_inner_panel"
    }
    right.add{
        type = "label", 
        name = "evolution_title",
        caption = "Rabbasca Alertness:\t\t100%"
    }
    right.add{
        type = "progressbar",
        name = "evolution_bar",
        value = 0
    }.style.horizontally_stretchable = true
end

-- Remove UI if not needed
local function destroy_evolution_bar(player)
    if gui(player).rabbasca_evo_frame then
        gui(player).rabbasca_evo_frame.destroy()
    end
end

local M = {}

function M.update() 
  for _, player in pairs(game.connected_players) do
    if player.surface ~= game.surfaces["rabbasca"] then
        destroy_evolution_bar(player) 
    return end

    create_evolution_bar(player)
    local icon = gui(player).rabbasca_evo_frame.icon
    local evo = storage.rabbasca_evo_last
    if bar then
        icon.number = evo * 100
    end
    local bar = gui(player).rabbasca_evo_frame.right.evolution_bar
    if bar then
        bar.value = evo
    end
    local bar = gui(player).rabbasca_evo_frame.right.evolution_title
    if title then
        title.caption = string.format("[img=item/rabbasca-vault-access-protocol] Rabbasca Alertness:\t\t%i%%", evo * 100)
    end
  end
end

return M