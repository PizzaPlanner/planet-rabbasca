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
    local list = right.add{
        type = "flow",
        direction = "horizontal",
        name = "spawns",
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
    local evo = storage.rabbasca_evo_last
    local spawns = gui(player).rabbasca_evo_frame.right.spawns
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
  end
end

return M