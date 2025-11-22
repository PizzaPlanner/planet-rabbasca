local gleba = settings.startup["rabbasca-orbits"].value

function default_requirements(planet)
  -- If there is a cargo drop restriction, also forbid to bunnyhop cargo in
  return { "planetslib-"..planet.. "-cargo-drops" }
end

bunnyhop_requirements = bunnyhop_requirements or { 
  [gleba] = { }, -- force no restriction on gleba, so we do not softlock on rabbasca
}

local M = {}

-- default requirements: { "planetslib-<name>-cargo-drops" }
-- use this to restrict to one or more other technologies
-- note that planet-discovery-<name> is always required through is_space_location_unlocked
-- modifying parent requirements is not allowed to prevent softlocks.
function M.set_requirements(name, requirements)
  if name == gleba then return end
  bunnyhop_requirements[name] = requirements
end

function M.dont_allow(name)
  M.set_requirements(name, { "bunnyhop-never" })
end

function M.can_jump_to(planet)
  if not game.planets[planet] or not game.forces.player.is_space_location_unlocked(planet) then return false end
  local requirements = bunnyhop_requirements[planet] or default_requirements(planet)
  local techs = game.forces.player.technologies
  for _, req in pairs(requirements) do 
    if req == "bunnyhop-never" then return false end
    if techs[req] and not techs[req].researched then return false end
  end
  return true
end

-- Initial range is 1000km (Planet <-> Moon / Moon <-> Moon), but can be extended with infinity research, 
--   restricting Planet <-> Planet to very late game usually.
function M.get_connections(from, max_range)
  local surfaces = { }
  for _, conn in pairs(prototypes.space_connection) do
    if conn.length <= max_range and (conn.from.name == from or conn.to.name == from) then
      local target = (conn.from.name == from) and conn.to.name or conn.from.name
      if M.can_jump_to(target) and (from == "rabbasca" or not settings.startup["rabbasca-bunnyhop-rabbasca-only"].value) then
        display = {"", "[img=space-location/" .. target .. "] ", game.planets[target].prototype.localised_name or target}
        table.insert(surfaces, display)
      end
    end
  end
  return surfaces
end


local function recalc_bunnyhoppers()
  storage.rabbasca_bunnyhopping = 0
  for _, player in pairs(game.connected_players) do
    if player.gui.screen.bunnyhop_ui then
      storage.rabbasca_bunnyhopping = storage.rabbasca_bunnyhopping + 1
    end
  end
end

function M.clear_bunnyhop_ui(player)
    if not player.gui.screen.bunnyhop_ui then return end
    player.gui.screen.bunnyhop_ui.destroy()
    recalc_bunnyhoppers()
    M.register_bunnyhop_handler()
end

local function get_max_range_and_weight(force)
  local bunnyhop_techs = { "bunnyhop-engine-1", "bunnyhop-engine-2", "bunnyhop-engine-3", "bunnyhop-engine-4" }
  local all_techs = force.technologies 
  local range = 0
  local weight = 0
  for _, tech in pairs(bunnyhop_techs) do
    if all_techs[tech] then 
      local levels = all_techs[tech].level - all_techs[tech].prototype.level
      if all_techs[tech].researched then levels = levels + 1 end
      -- game.print(tech..": "..levels) 
      for _, effect in pairs(all_techs[tech].prototype.effects) do
        if effect.effect_description and effect.effect_description[1] == "modifier-description.bunnyhop-engine-range" then range = range + effect.effect_description[2] * levels
        elseif effect.effect_description and effect.effect_description[1] == "modifier-description.bunnyhop-engine-weight" then weight = weight + effect.effect_description[2] * levels
        elseif effect.effect_description then game.print(effect.effect_description[1])
        end
      end
    end
  end 
  if settings.startup["rabbasca-bunnyhop-force-naked"].value then
    weight = 0
  end
  return range, weight
end

local function get_character_weight_label(character, max_weight) 
  local weight = 0
  for _, inventory in pairs({defines.inventory.character_main, defines.inventory.character_ammo, defines.inventory.character_trash}) do
    weight = weight + (character.get_inventory(inventory).weight or 0)
  end
  local cursor = character.player.cursor_stack
  if cursor.valid_for_read then
    weight = weight + (cursor.prototype.weight or 0) * cursor.count
  end
  weight = math.floor(weight / 1000)
  if weight <= max_weight then
    return true, {"rabbasca-extra.bunnyhop-weight", weight, max_weight}
  else
    return false, {"rabbasca-extra.bunnyhop-weight-too-heavy", weight, max_weight}
  end
  
end

local function on_charge_bunnyhop(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    local frame = player.gui.screen.bunnyhop_ui
    if not (frame and frame.valid) then return end
    local pb = frame.bunnyhop_charge
    if not (pb and pb.valid) then return end
    local wl = frame.bunnyhop_weight
    if not (wl and wl.valid) then return end
    
    local character = player.controller_type == defines.controllers.character and player.character
    if not character then 
        M.clear_bunnyhop_ui(player)
        return
    end

    local max_weight = (wl.caption and #wl.caption == 3 and tonumber(wl.caption[3]) or -1)
    if max_weight < 0 then
      player.print({"rabbasca-extra.bunnyhop-error"})
      M.clear_bunnyhop_ui(player)
      return
    end
    is_weight_ok, wl.caption = get_character_weight_label(character, max_weight)
    
    -- player.walking_state.walking = true
    local delta = character.effective_speed or 1
    local needed = 100
    local change = (is_weight_ok and delta / needed) or -0.05
    pb.value = math.min(1, math.max(pb.value - change, 0))
    -- player.character.speed = (player.character.speed or 1) * 1.2

    if pb.value > 0 then return end
    
    local list = frame.bunnyhop_surface_list
    local icon = list.get_item(list.selected_index)[2]
    local planet = string.match(icon, "%[img=space%-location/(.-)%]")
    M.clear_bunnyhop_ui(player)

    if not planet or not game.planets[planet] then return end

    local surface = game.planets[planet].surface or game.planets[planet].create_surface()
    if not surface then return end
    local cid = character.unit_number
    storage.last_bunnyhops = storage.last_bunnyhops or { }
    storage.last_bunnyhops[cid] = storage.last_bunnyhops[cid] or {}
    storage.last_bunnyhops[cid][character.surface_index] = character.position

    game.print(storage.last_bunnyhops[cid][character.surface_index])

    local offset = storage.last_bunnyhops[cid][surface.index]
    if not (offset and offset.x and offset.y) then offset = {x = 0, y = 0} end
    local radius = surface.get_starting_area_radius()
    player.force.chart(surface, {{-radius + offset.x, -radius + offset.y}, {radius + offset.x, radius + offset.y}})
    local start_pos = surface.find_non_colliding_position("character", offset, radius, 1) or {x = 0, y = 0}
    
    -- Teleport player
    if not player.teleport(start_pos, surface) then 
      player.print({"rabbasca-extra.bunnyhop-error"})
    end
end

-- called in on_load: must adhere to https://lua-api.factorio.com/latest/classes/LuaBootstrap.html#on_load
function M.register_bunnyhop_handler()
    if (storage.rabbasca_bunnyhopping or 0) == 0 then
      script.on_event(defines.events.on_player_changed_position, nil)
    else
      script.on_event(defines.events.on_player_changed_position, on_charge_bunnyhop)
    end
end

function M.show_bunnyhop_ui(player, equipment)
    local max_range, max_weight = get_max_range_and_weight(player.force)
    max_weight = max_weight * (equipment.quality.default_multiplier or 1)
    local surface = player.surface
    local reachable_surfaces = M.get_connections(surface.name, max_range)

    if #reachable_surfaces == 0 then
      if settings.startup["rabbasca-bunnyhop-rabbasca-only"].value then
        player.print({"rabbasca-extra.bunnyhop-not-from-here"})
      else
        player.print({"rabbasca-extra.bunnyhop-no-target", max_range})
      end
      return 
    end

    if player.gui.screen.bunnyhop_ui then
        M.clear_bunnyhop_ui()
    end

    local frame = player.gui.screen.add{
        type = "frame",
        name = "bunnyhop_ui",
        caption = "Bunnyhop within "..max_range.."km",
        direction = "vertical"
    }
    frame.auto_center = true
    local pb = frame.add{
        type = "progressbar",
        name = "bunnyhop_charge",
        value = 1
    }
    pb.style.horizontally_stretchable = true
    local _, weight = get_character_weight_label(player.character, max_weight)
    local pb = frame.add{
        type = "label",
        name = "bunnyhop_weight",
        caption = weight
    }

    local list = frame.add{ 
      type = "list-box", 
      name = "bunnyhop_surface_list",
      selected_index = current_index,
      items = reachable_surfaces 
    }
    list.selected_index = 1
    recalc_bunnyhoppers()
    M.register_bunnyhop_handler()
end

return M