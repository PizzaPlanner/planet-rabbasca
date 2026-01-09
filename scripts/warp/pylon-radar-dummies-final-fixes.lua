local pylon = data.raw["assembling-machine"]["rabbasca-warp-pylon"]
if not pylon then return end
for _, quality in pairs(data.raw["quality"]) do
data:extend {
  {
    type = "roboport",
    name = "rabbasca-network-cell-"..quality.name,
    icon = pylon.icon,
    localised_name = { "entity-name.rabbasca-warp-pylon" },
    localised_description = { "entity-localised_description.rabbasca-warp-pylon" },
    flags = { "not-on-map" },
    selectable_in_game = false,
    collision_box = pylon.collision_box,
    collision_mask = { layers = { } },
    energy_source = { type = "void" },
    energy_usage = "1MW",
    recharge_minimum = "1MW",
    robot_slots_count = 0,
    material_slots_count = 0,
    request_to_open_door_timeout = 0,
    spawn_and_station_height = 0,
    charge_approach_distance = 0,
    logistics_radius = 0,
    construction_radius = Rabbasca.get_warp_radius(quality),
    logistics_connection_distance = Rabbasca.get_warp_radius(quality),
    charging_energy = "1MW",
    radar_visualisation_color = { 0, 0.25, 0.8, 0.3 }
  }
}
end