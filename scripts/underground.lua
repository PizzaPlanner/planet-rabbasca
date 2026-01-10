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
    game.forces.player.print({ "rabbasca-extra.created-underground-stabilizer", stab.gps_tag})
end

return M