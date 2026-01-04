data:extend {
{
  type = "generator-equipment",
  name = "bunnyhop-engine-equipment",
  sprite =
  {
    filename = "__base__/graphics/technology/engine.png",
    flags = { "icon" },
    size = 256,
    priority = "extra-high-no-scale",
    scale = 0.5
  },
  shape =
  {
    width = 4,
    height = 6,
    type = "full"
  },
  energy_source =
  {
    type = "electric",
    usage_priority = "primary-output"
  },
  power = "200kW",
  take_result = "bunnyhop-engine-equipment",
  categories = {"armor"}
},
{
  type = "generator-equipment",
  name = "ears-subcore-reactor-equipment",
  weight = 100 * kg,
  sprite =
  {
    filename = "__space-age__/graphics/equipment/fusion-reactor-equipment.png",
    size = 512,
    priority = "medium",
    scale = 0.5
  },
  shape =
  {
    width = 2,
    height = 2,
    type = "full"
  },
  energy_source =
  {
    type = "electric",
    usage_priority = "primary-output"
  },
  power = "100kW",
  categories = {"armor"}
},
{
    type = "equipment-grid",
    name = "train-equipment-grid",
    width = 6,
    height = 2,
    equipment_categories = {"armor"},
    locked = false
},
{
    type = "shortcut",
    name = "activate-bunnyhop-engine",
    action = "spawn-item",
    item_to_spawn = "bunnyhop-engine",
    toggleable = false,
    technology_to_unlock = "bunnyhop-engine-1",
    unavailable_until_unlocked = true,
    icon = "__rabbasca-assets__/graphics/recolor/icons/bunnyhop-jump.png",
    small_icon = "__rabbasca-assets__/graphics/recolor/icons/bunnyhop-jump.png",
    icon_size = 56,
    small_icon_size = 56,
    associated_control_input = "give-bunnyhop-engine",
},
{
    type = "custom-input",
    name = "give-bunnyhop-engine",
    key_sequence = "ALT + J",
    consuming = "game-only",
    item_to_spawn = "bunnyhop-engine",
    action = "spawn-item"
}
}