local M = { }


local function on_tick_underground(event)
    for _, player in pairs(game.connected_players) do
        M.update_affinity_bar(player, true)
    end
end

local function stabilizer_config()
    return prototypes.mod_data["rabbasca-stabilizer-config"].data
end

local function register_stabilizer(s)
    if storage.stabilizer and storage.stabilizer.entity ~= s then s.die() return end -- cannot have multiple stabilizers
    local id, _, _ = script.register_on_object_destroyed(s)
    storage.stabilizer = {
        surface = s.surface_index,
        entity = s,
        destroyed_id = id
    }
    s.set_recipe("rabbasca-reboot-stabilizer")
    s.recipe_locked = true
    s.set_fluid(1, { name = "harene", amount = 47000 })
    storage.rabbasca_affinity = "rabbasca"
    M.warp_to(s.surface, "rabbasca")
    M.register_ui_handler()
    game.forces.player.chart(s.surface, {{-48, -48}, {48, 48}})
    game.forces.player.print({ "rabbasca-extra.created-underground-stabilizer", s.gps_tag})
end

-- called in on_load: must adhere to https://lua-api.factorio.com/latest/classes/LuaBootstrap.html#on_load
function M.register_ui_handler()
    script.on_nth_tick(120, on_tick_underground)
end

function M.on_stabilizer_died(id)
    if storage.stabilizer and storage.stabilizer.destroyed_id == id then
        game.forces.player.print({ "rabbasca-extra.stabilizer-destroyed" })
        game.forces.player.technologies["rabbasca-underground"].researched = false
        game.forces.player.technologies["rabbasca-underground"].saved_progress = 0
        if game.surfaces[storage.stabilizer.surface] and game.surfaces[storage.stabilizer.surface].valid then
            game.delete_surface(storage.stabilizer.surface)
        end
        storage.stabilizer = nil
        script.on_nth_tick(120, nil)
    end
end

-- function M.replace_entities()
--     game.surfaces["rabbasca-underground"].destroy_decoratives{}
--     for _, e in pairs(game.surfaces["rabbasca-underground"].find_entities_filtered{
--     force = "neutral"
--     }) do e.destroy{} end
--     local map_gen = game.surfaces["fulgora"].map_gen_settings
--     map_gen.seed = 1123234515
--     game.surfaces["rabbasca-underground"].map_gen_settings = map_gen
--     game.surfaces["rabbasca-underground"].regenerate_entity()
--     game.surfaces["rabbasca-underground"].regenerate_decorative()
-- end

function M.replace_entities(surface, settings)
    for _, e in pairs(game.surfaces["rabbasca-underground"].find_entities_filtered{force = "neutral"}) do e.destroy{} end
    local map_settings = surface.map_gen_settings
    map_settings.autoplace_settings.entity.settings = settings
    surface.map_gen_settings = map_settings
    surface.regenerate_entity()
end

function M.replace_tiles(surface, from, to)
    for _, tile in pairs(surface.find_tiles_filtered {
        has_hidden_tile = true 
    }) do
        for _, f in pairs(from) do
            if tile.hidden_tile == f then
                surface.set_hidden_tile(tile.position, to)
            end
        end
    end
    for _, tile in pairs(surface.find_tiles_filtered {
        has_double_hidden_tile = true 
    }) do
        for _, f in pairs(from) do
            if tile.hidden_tile == f then
                surface.set_double_hidden_tile(tile.position, to)
            end
        end
    end
    local tiles = { }
    for _, tile in pairs(surface.find_tiles_filtered {
        name = from
    }) do
        table.insert(tiles, { name = to, position = tile.position })
    end
    surface.set_tiles(tiles, true, false)
end

local function on_warp_underground(event)
    local data = storage.pending_warp
    if not (data and data.surface.valid) then
        storage.pending_warp = nil -- if surface got removed in between
        script.on_nth_tick(5, nil)
        return
    end
    if event.tick > data.warp_tick  then
        storage.pending_warp.warp_tick = math.huge
        local config = stabilizer_config()
        if not config.planets[data.warp_to] then
            game.print("[ERROR]: Could not warp to "..data.warp_to)
            data.warp_to = storage.rabbasca_affinity
        end
        storage.rabbasca_affinity = data.warp_to
        M.replace_tiles(data.surface, config.water_tiles, config.planets[data.warp_to].water)
        M.replace_entities(data.surface, config.planets[data.warp_to].autoplace_entities)
        for _, e in pairs(data.surface.find_entities_filtered { type = "offshore-pump" }) do
            e.die(e.force)
        end
        M.change_affinity()
        local lut_step = 1 / (3 + 2 * config.planet_count)
        data.surface.daytime = config.planets[storage.rabbasca_affinity].lut_index - lut_step
    elseif event.tick > data.finished_tick then
        M.post_warp_surface(data.surface)
    end
end

function M.post_warp_surface(surface)
    surface.daytime = stabilizer_config().planets[storage.rabbasca_affinity].lut_index
    surface.freeze_daytime = true
    surface.min_brightness = 1
    storage.pending_warp = nil
    M.change_affinity()
end

function M.warp_to(surface, planet)
    local config = stabilizer_config()
    storage.stabilizer.progress = 0
    if not (surface and config.planets[planet]) then log("error: stabilizer could not warp to "..planet) return end
    storage.pending_warp = { warp_to = planet, surface = surface, warp_tick = game.tick + 90, finished_tick = game.tick + 180 }
    surface.ticks_per_day = 180 * (stabilizer_config().planet_count + 1.5)
    surface.freeze_daytime = false
    storage.last_warp = game.tick
    script.on_nth_tick(5, on_warp_underground)
end

function M.on_stabilization(surface)
    local config = stabilizer_config()
    storage.stabilizer.progress = storage.stabilizer.progress + 1
    if storage.stabilizer.progress < config.stabilization_required then return end
    local choice = { }
    for planet, _ in pairs(config.planets) do table.insert(choice, planet) end
    local next = choice[math.random(#choice)]
    M.warp_to(surface, next)
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
        storage.rabbasca_affinity = "rabbasca"
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

function M.change_affinity()
    for planet, data in pairs(prototypes.mod_data["rabbasca-stabilizer-config"].data.planets) do
        local researched = planet == storage.rabbasca_affinity
        game.forces.player.technologies[data.tech].researched = researched
        game.forces.player.technologies[data.tech_prep].researched = true
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
    surface.create_entity {
        name = "rabbasca-stabilizer-consumer",
        position = {0, 0},
        force = game.forces.player
    }
    if not stab then game.forces.player.print("[ERROR] Could not create [entity=rabbasca-warp-stabilizer]. This should never happen. Please report a bug.") return end
    register_stabilizer(stab)
end

local function add_button(parent, sprite, style, name, size)
    local btn = parent.add{
        type = "sprite-button",
        sprite= sprite,
        style = style,
        name = name,
    }
    btn.style.size = size
end

local function create_affinity_bar(player, numbers_only)
    if numbers_only and player.gui.top.rabbasca_affinity then
        local config = stabilizer_config()
        local progress = config.stabilization_required - storage.stabilizer.progress
        player.gui.top.rabbasca_affinity.current_planet.number = progress
        local fluid = storage.stabilizer.entity.get_fluid(1)
        local value = (fluid and fluid.amount / 100000) or 0
        local bar = player.gui.top.rabbasca_affinity.right.fuel.bar
        bar.value = value
        if bar.value > 0.33 then bar.style.color = { 0.9, 0, 1 }
        elseif bar.value > 0.1 then bar.style.color = { 1, 1, 0 }
        else bar.style.color = { 1, 0, 0 } end
        return
    end
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
        name = "current_planet",
        tooltip = { "rabbasca-extra.affinity-ui-tooltip", affinity }
    }
    local right = frame.add {
        type = "flow",
        direction = "vertical",
        name = "right",
    }
    right.style.vertical_spacing = 0
    local top = right.add {
        type = "flow",
        direction = "horizontal",
        name = "top",
    }
    top.style.vertical_align = "center"
    add_button(top, "virtual-signal/signal-map-marker", "transparent_slot", "resources_marker", 16)
    local recipes1 = top.add {
        type = "flow",
        direction = "horizontal",
        name = "resources",
    }
    recipes1.style.horizontal_spacing = 0
    recipes1.style.vertical_align = "center"
    add_button(top, "entity/rabbasca-warp-pylon", "transparent_slot", "recipes_marker", 16)
    local recipes2 = top.add {
        type = "flow",
        direction = "horizontal",
        name = "recipes",
    }
    recipes2.style.horizontal_spacing = 0
    recipes2.style.vertical_align = "center"
    local fuel = right.add {
        type = "flow",
        direction = "horizontal",
        name = "fuel",
    }
    fuel.style.vertical_align = "center"
    add_button(fuel, "fluid/harene", "transparent_slot", "icon", 16)
    local bar = fuel.add {
        type = "progressbar",
        name = "bar",
        value = 0,
    }
    bar.style.minimal_width = 96
    bar.style.natural_width = 96
    bar.style.horizontally_stretchable = true
    right.style.top_padding = 1
    local config = stabilizer_config().planets[affinity]
    if config then
        add_button(recipes1, "tile/"..config.water, "inventory_slot", "fluid", 24)
        local i = 0
        for e, _ in pairs(config.autoplace_entities) do
            i = i + 1
            add_button(recipes1, "entity/"..e, "inventory_slot", "icon_"..tostring(i), 24)
        end
        local tech = player.force.technologies["rabbasca-warp-anchoring-"..affinity]
        if tech then
            for _, reward in pairs(tech.prototype.effects) do
                if reward.recipe then
                    i = i + 1
                    add_button(recipes2, "recipe/"..reward.recipe, "inventory_slot", "icon_"..tostring(i), 24)
                end
            end
        end
    end
    create_affinity_bar(player, true)
end

function M.update_affinity_bar(player, numbers_only)
    local is_on_rabbasca = player.surface and player.surface.name == "rabbasca-underground"
    local ui = player.gui.top.rabbasca_affinity
    if ui and not is_on_rabbasca then
        ui.destroy()
    elseif is_on_rabbasca then
        create_affinity_bar(player, numbers_only)
    end
end

return M