local config = data.raw["mod-data"]["rabbasca-stabilizer-config"].data
local planet = data.raw["planet"]["rabbasca-underground"]
local planet_count = 0
local lut_table = { 
    { 0.0, "identity" } -- to make fog of war normal color
}
for planet, data in pairs(config.planets) do
    planet_count = planet_count + 1
end
config.planet_count = planet_count
local lut_step = 1 / (3 + 2 * planet_count)
local current_lut_step = 0
for planet, data in pairs(config.planets) do
    current_lut_step = current_lut_step + lut_step
    table.insert(lut_table, {current_lut_step, "__rabbasca-assets__/graphics/recolor/textures/lut-white.png"})
    current_lut_step = current_lut_step + lut_step
    data.lut_index = current_lut_step
    table.insert(lut_table, {current_lut_step, data.lut or "identity"})
    table.insert(config.water_tiles, data.water or "hot-lava")
    log("Underground: added "..planet.. " with "..serpent.line(data))
end

table.insert(lut_table, { current_lut_step + lut_step, "__rabbasca-assets__/graphics/recolor/textures/lut-white.png" })
table.insert(lut_table, { current_lut_step + lut_step, "identity" })
planet.surface_render_parameters.day_night_cycle_color_lookup = lut_table

if planet_count < 2 then
    log("ERROR: Underground planet count is too low: "..planet_count..". Game will now crash")
    data.raw["crash"]["too-few-planets"] = 3
end