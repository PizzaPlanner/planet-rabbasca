
-- Usually redundant, as planet-discovery-... tech is required anyways, normally gated behind rocket-silo
function default_requirements() 
  return { "rocket-silo" }
end

bunnyhop_requirements = bunnyhop_requirements or {
    ["gleba"]    = { }, -- APS: rocket-silo can only be researched once gleba is solved
    ["rabbasca"] = { "bunnyhop-engine" },
}

local M = {}

function M.set_requirements(name, requirements)
  table.insert()
  bunnyhop_requirements[name] = requirements
end

function M.dont_allow(name)
  bunnyhop_requirements[name] = { "bunnyhop-never" }
end

function M.can_jump_to(planet)
  if not game.planets[planet] or not game.forces.player.is_space_location_unlocked(planet) then return false end
  local requirements = bunnyhop_requirements[planet] or default_requirements()
  local techs = game.forces.player.technologies
  for _, req in pairs(requirements) do 
    if not techs[req] or not techs[req].researched then return false end
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
      if M.can_jump_to(target) then
        display = {"", "[img=space-location/" .. target .. "] ", game.planets[target].prototype.localised_name or target}
        table.insert(surfaces, display)
      end
    end
  end
  return surfaces
end

return M