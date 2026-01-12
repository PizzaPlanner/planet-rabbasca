local M = { }

local function register_stabilizer(s)
    storage.ug_stabilizers = storage.ug_stabilizers or { }
    local id, _, _ = script.register_on_object_destroyed(s)
    storage.ug_stabilizers[id] = s.surface_index
end

function M.on_stabilizer_died(id)
    if storage.ug_stabilizers and storage.ug_stabilizers[id] then
        game.forces.player.print({ "rabbasca-extra.stabilizer-destroyed" })
        game.delete_surface(storage.ug_stabilizers[id])
        game.forces.player.technologies["rabbasca-underground"].researched = false
        game.forces.player.technologies["rabbasca-underground"].saved_progress = 0
        storage.ug_stabilizers[id] = nil
    end
end

function M.reboot_stabilizer(s)
    s.force = game.forces.player
    s.set_recipe(nil)
    s.recipe_locked = false
end

function M.on_locate_progress()
local tech = game.forces.player.technologies["rabbasca-underground"]
    local surface = game.planets["rabbasca-underground"].surface
    if not surface then
        if not tech.researched then
            if math.random() > 0.1 then return end
            tech.researched = true
        end
        game.planets["rabbasca-underground"].create_surface()
        return
    end
    local offset = {0, 10}
    local radius = 3 * 32
    surface.request_to_generate_chunks(offset, 3)
    surface.force_generate_chunk_requests()
    local pos = surface.find_non_colliding_position("rabbasca-warp-pylon", offset, radius, 1)
    if not pos then
        game.forces.player.print({ "rabbasca-extra.created-underground-pylon-error", offset.x, offset.y })
        return
    end
    local tiles = {
        { position = {pos.x- 1, pos.y- 1}, name = "rabbasca-energetic-concrete" },
        { position = {pos.x+ 0, pos.y- 1}, name = "rabbasca-energetic-concrete" },
        { position = {pos.x- 1, pos.y+ 0}, name = "rabbasca-energetic-concrete" },
        { position = {pos.x+ 0, pos.y+ 0}, name = "rabbasca-energetic-concrete" },
    }
    surface.set_tiles(tiles)
    local spawner = surface.create_entity {
        name = "rabbasca-warp-pylon",
        position = pos,
        force = game.forces.player,
        snap_to_grid = true,
        raise_built = true
    }
    if spawner then
        game.forces.player.print({ "rabbasca-extra.created-underground-pylon", spawner.gps_tag })
    end
end

function M.change_affinity(stabilizer)
    local recipe = stabilizer.get_recipe()
    storage.rabbasca_affinity = recipe and string.match(recipe.name, "rabbasca%-initiate%-stabilizer%-affinity%-(.*)")
    stabilizer.set_recipe(nil)
    for p, data in pairs(prototypes.mod_data["rabbasca-materialize-recipes"].data) do
        local enable = p == storage.rabbasca_affinity
        for _, recipe in pairs(data) do
            stabilizer.force.recipes[recipe].enabled = enable
        end
    end
    for _, player in pairs(game.players) do
        M.update_affinity_bar(player)
    end
end

function M.init_underground(surface)
    local stab = surface.create_entity {
        name = "rabbasca-warp-stabilizer",
        position = {0, 0},
        force = game.forces.player
    }
    if not stab then game.forces.player.print("[ERROR] Could not create [entity=rabbasca-warp-stabilizer]. This should never happen. Please report a bug.") return end
    stab.set_recipe("rabbasca-reboot-stabilizer")
    stab.recipe_locked = true
    register_stabilizer(stab)
    M.change_affinity(stab)
    game.forces.player.chart(surface, {{-48, -48}, {48, 48}})
    game.forces.player.print({ "rabbasca-extra.created-underground-stabilizer", stab.gps_tag})
end

local function create_affinity_bar(player)
    if player.gui.top.rabbasca_affinity then
        player.gui.top.rabbasca_affinity.destroy()
    end
    if not settings.get_player_settings(player)["rabbasca-show-alertness-ui"].value then return end

    local affinity = storage.rabbasca_affinity

    local frame = player.gui.top.add{
        type = "frame",
        name = "rabbasca_affinity",
        direction = "horizontal",
        style = "slot_window_frame",
    }
    frame.style.vertically_stretchable = false
    frame.add{
        type = "sprite-button",
        sprite= affinity and "space-location/"..affinity or "entity/rabbasca-warp-stabilizer",
        style = "inventory_slot",
        name = "icon",
        tooltip = { "rabbasca-extra.affinity-ui-tooltip", affinity }
    }
    local right = frame.add {
        type = "flow",
        direction = "vertical",
        name = "right",
    }
    right.style.top_padding = 1
end

function M.update_affinity_bar(player)
    local is_on_rabbasca = player.surface and player.surface.name == "rabbasca-underground"
    local ui = player.gui.top.rabbasca_affinity
    if ui and not is_on_rabbasca then
        ui.destroy()
    elseif is_on_rabbasca then
        create_affinity_bar(player)
    end
end

return M