require("__base__.prototypes.entity.combinator-pictures")

local function vault_access_burner_source(suffix, emissions)
return {
  type = "burner",
  fuel_inventory_size = 1,
  fuel_categories = {"rabbasca-security-fuel-"..suffix},
  initial_fuel = "rabbascan-security-key-"..suffix,
  initial_fuel_percent = 1,
  emissions_per_minute = { ["vault-activity"] = emissions * minute / 50 } -- actual numbers are way higher
}
end

local access_console = util.merge{
  table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"]),
  {
    name = "rabbasca-vault-access-terminal",
    max_health = 2400,
    crafting_speed = 1,
    energy_usage = "1MW",
    allow_copy_paste = false,
    module_slots = 1,
    return_ingredients_on_change = true,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.6, -1}, {0.6, 0.6}},
    is_military_target = false
  }
}
access_console.next_upgrade = nil
access_console.fluid_boxes = { } 
-- access_console.allowed_effects = nil
access_console.energy_source = {
  type = "void",
  emissions_per_minute = { ["vault-activity"] = 0.75 * minute } -- actual numbers are way higher
}
access_console.resistances = {
  { type = "physical", percent = 70 },
  { type = "fire", percent = 90 },
  { type = "poison", percent = 100 },
  { type = "laser", percent = 50 },
  { type = "electric", percent = 30 },
}
access_console.created_effect = {
  type = "direct",
  action_delivery =
  {
    type = "instant",
    target_effects =
    {
      {
        type = "script",
        effect_id = "rabbasca_init_terminal"
      },
    }
  } 
}
access_console.collision_mask = { layers = { } }
access_console.loot = { { item = "infused-haronite-plate", count_min = 3, count_max = 3 } }
access_console.minable = nil
access_console.flags = {"placeable-player", "not-deconstructable", "not-rotatable", "placeable-off-grid"}
access_console.surface_conditions = nil
access_console.crafting_categories = { "rabbasca-vault-hacking" }
access_console.graphics_set =
{
  animation =
  {
    layers =
    {
      {
        filename = "__Krastorio2Assets__/buildings/singularity-beacon/singularity-beacon.png",
        priority = "high",
        width = 360,
        height = 360,
        frame_count = 1,
        scale = 0.2
      }
    }
  },
}

local extraction_console = util.merge{ 
  table.deepcopy(access_console),
  {
    name = "rabbasca-vault-extraction-terminal",
    energy_usage = "1MW",
    vector_to_place_result = {0.5, 1}
  } 
}
extraction_console.crafting_categories = { "rabbasca-vault-extraction" }
extraction_console.energy_source = vault_access_burner_source("e", 1.2)

local research_console = util.merge{
  table.deepcopy(extraction_console),
  {
    name = "rabbasca-vault-research-terminal",
    type = "lab",
    inputs = {"rabbascan-encrypted-vault-data"}
  }
}
research_console.on_animation = access_console.graphics_set.animation
research_console.off_animation = access_console.graphics_set.animation
research_console.energy_source = vault_access_burner_source("a", 0.4)

local power_node = util.merge{ 
    extraction_console,
{  
  name = "rabbasca-vault-power-node",
  type = "burner-generator",
  -- burns_fluid = true,
  -- scale_fluid_usage = true,
  -- fluid_usage_per_tick = 0.05 / second,
  collision_box = {{-1, -1}, {1, 1}},
  selection_box = {{-1, -1}, {1, 1}},
  effectivity = 1,
  maximum_temperature = 10,
  max_power_output = "50MW",
}}
power_node.burner = vault_access_burner_source("p", 2)
power_node.energy_source = {
  type = "electric",
  buffer_capacity = "5MJ",
  usage_priority = "secondary-output",
  emissions_per_minute = { ["vault-activity"] = 0.5 * minute } -- actual numbers are way higher
}

local vault = util.merge{ 
  table.deepcopy(data.raw["unit-spawner"]["spitter-spawner"]), 
{
  name = "rabbasca-vault",
  type = "unit-spawner",
  captured_spawner_entity = nil,
  spawning_cooldown = {15 * second, 0.25 * second},
  max_count_of_owned_units = 4,
  max_count_of_owned_defensive_units = 0,
  max_friends_around_to_spawn = 1,
  max_defensive_friends_around_to_spawn = 0,
  spawning_radius = 12,
  map_generator_bounding_box = {{-10.5, -10.5}, {10.5, 10.5}},
  -- map_color = {0.9, 0.3, 0.4},
  collision_box = {{-2.5, -2},{2.5, 3}},
  selection_priority = 30
}}
vault.absorptions_per_second = { ["vault-activity"] = { absolute = 100, proportional = 0.5 }}
vault.autoplace = { probability_expression = "rabbasca_camps", force = "neutral" }
vault.created_effect = {
  type = "direct",
  action_delivery =
  {
    type = "instant",
    target_effects =
    {
      {
        type = "create-entity",
        entity_name = "rabbasca-vault-access-terminal",
        offsets = {{0, 2.5}},
      },
      {
        type = "create-entity",
        entity_name = "rabbasca-vault-access-terminal",
        offsets = {{2, 2.5}},
      },
      {
        type = "create-entity",
        entity_name = "rabbasca-vault-access-terminal",
        offsets = {{-2, 2.5}},
      },
      -- {
      --   type = "create-entity",
      --   entity_name = "rabbasca-vault-power-node",
      --   offsets = {{1.7, 0.7}},
      -- },
      {
        type = "create-entity",
        entity_name = "rabbasca-vault-timer",
        offsets = {{0, 0}},
      },
      {
        type = "script",
        effect_id = "make_invulnerable"
      }
    }
  } 
}
vault.result_units = {
  { unit = "vault-defender-1", spawn_points = {
    {evolution_factor = 0, spawn_weight = 0.1}, 
    {evolution_factor = 0.1, spawn_weight = 1},
    {evolution_factor = 0.2, spawn_weight = 0},
  }},
  { unit = "vault-defender-2", spawn_points = {
    {evolution_factor = 0.14, spawn_weight = 0}, 
    {evolution_factor = 0.25, spawn_weight = 1},
    {evolution_factor = 0.3, spawn_weight = 0},
  }},
  { unit = "medium-biter", spawn_points = {
    {evolution_factor = 0.2, spawn_weight = 0}, 
    {evolution_factor = 0.3, spawn_weight = 1},
    {evolution_factor = 0.5, spawn_weight = 0},
  }},
    { unit = "big-biter", spawn_points = {
    {evolution_factor = 0.3, spawn_weight = 0}, 
    {evolution_factor = 0.4, spawn_weight = 0.5},
    {evolution_factor = 0.7, spawn_weight = 1},
    {evolution_factor = 1, spawn_weight = 0},
  }},
    { unit = "behemoth-biter", spawn_points = {
    {evolution_factor = 0.9, spawn_weight = 0}, 
    {evolution_factor = 0.91, spawn_weight = 0.5},
  }},
}
vault.graphics_set =
{
  animations = {
  {
    layers =
    {
      {
        filename = "__Krastorio2Assets__/buildings/stabilizer-charging-station/stabilizer-charging-station.png",
        priority = "high",
        width = 170,
        height = 170,
        frame_count = 80,
        line_length = 10,
        scale = 1.5
      }
    }
  },
} }

local timer_dummy = {
    name = "rabbasca-vault-timer",
    type = "container",
    max_health = 100,
    inventory_size = 100,
    -- selectable_in_game = false,
    -- allow_copy_paste = false,
    selection_box = {{-1, -1}, {1, 1}},
    flags = { "not-in-kill-statistics", "not-deconstructable", "not-repairable", "not-rotatable", "placeable-off-grid" },
    -- dying_trigger_effect = {
    --     type = "script",
    --     effect_id = "rabbasca_on_hack_expire"
    -- },
    -- activity_led_light_offsets =
    -- {
    --   {0.296875, -0.40625},
    --   {0.25, -0.03125},
    --   {-0.296875, -0.078125},
    --   {-0.21875, -0.46875}
    -- },
    created_effect = {
    type = "direct",
    action_delivery =
    {
        type = "instant",
        target_effects =
        {
        {
            type = "script",
            effect_id = "rabbasca_init_terminal"
        },
        }
    } 
    }
}

data:extend {
  vault, 
  access_console, 
  extraction_console, 
  research_console,
  power_node,
  timer_dummy,
}