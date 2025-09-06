function make_capsule(proto) 
return {
    type = "capsule",
    icon = proto.icon,
    name = "bunnyhop-engine-"..proto.name,
    stack_size = 1,
    subgroup = "transport",
    order = "b[personal-transport]-c[startertron]",
    capsule_action = {
      type = "use-on-self",
      uses_stack = true,
      attack_parameters = {
        type = "projectile",
        activation_type = "consume",
        ammo_category = "capsule",
        cooldown = 1 * minute,
        range = 0,
        ammo_type =
        {
          target_type = "position",
          action =
          {
            type = "direct",
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                {
                  type = "script",
                  effect_id = "rabbasca_teleport_".. proto.name
                }
              }
            }
          }
        }
      }
    }  
  }
end

function make_recipe(proto, settings) 
   -- build ingredient list
  local ingredients = {
    {type = "item", name = "bunnyhop-engine", amount = 1},
  }
  if settings.extra_inputs then
    for _, ing in pairs(settings.extra_inputs) do
      table.insert(ingredients, table.deepcopy(ing))
    end
  end

  local recipe = {
    type = "recipe",
    name = "bunnyhop-engine-" .. proto.name,
    icon = proto.icon,
    energy_required = 180,
    enabled = settings.unlocked_by == nil,
    ingredients = ingredients,
    unlock_results = true,
    results = {{type = "item", name = "bunnyhop-engine-" .. proto.name, amount = 1}},
    category = "crafting",
  }

  -- gate behind tech if specified
  local tech = data.raw.technology[settings.unlocked_by] or data.raw.technology["moonstone-glob-technology"]
  if tech then
    tech.effects = tech.effects or {}
    table.insert(tech.effects, {type = "unlock-recipe", recipe = recipe.name})
  else
    log("Warning: technology " .. settings.unlocked_by .. " not found for teleporter " .. planet)
  end
  if settings.unlocked_by then
    -- add unlock effect to technology
  end

  return recipe 
end

for planet, settings in pairs(require("__planet-rabbasca__.teleporters").get_planets()) do
    local proto = data.raw["planet"][planet]
    if settings ~= nil and proto ~= nil then
        data:extend{ make_capsule(proto), make_recipe(proto, settings) }
    end
end

for _, pole in pairs(data.raw["electric-pole"]) do 
  if pole.surface_conditions then
    table.insert(pole.surface_conditions, {property = "harenic-energy-signatures", max = 0.5})
  else
    pole.surface_conditions = {{property = "harenic-energy-signatures", max = 0.5}}
  end
end