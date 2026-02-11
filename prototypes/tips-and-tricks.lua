local simulation = {
    planet = "rabbasca",
    mods = { "planet-rabbasca" },
    generate_map = true,
    hide_health_bars = false,
    checkboard = false,
    init = [[
        local offset = { -113, 31 }
        game.simulation.camera_position = offset
        game.simulation.camera_zoom = 1.1
        game.simulation.camera_alt_info = true

        
        local surface = game.surfaces[1]
        surface.daytime = 0.0
        surface.freeze_daytime = true
        surface.create_global_electric_network()
        game.forces.player.technologies["rabbascan-vault-access"].researched = true
        for x = -7, 3, 1 do
        for y = -5, 5 do
            surface.set_chunk_generated_status({x, y}, defines.chunk_generated_status.nothing)
        end
        end
        local tiles = { }
        for x = -32, 32 do
            for y = -32, 32 do
                table.insert(tiles, { name = "rabbasca-rough", position = { x + offset[1], y + offset[2] } })
            end
        end
        surface.set_tiles(tiles)
        local s = surface.map_gen_settings
        s.seed = 8
        s.autoplace_settings = prototypes["space_location"]["rabbasca"].map_gen_settings.autoplace_settings
        surface.map_gen_settings = s
        surface.regenerate_entity() -- Does not do anything????
        surface.regenerate_decorative()
        surface.create_entities_from_blueprint_string { position = { offset[1] + 1, offset[2] - 1 }, string = "0eNrVmt1uo0gQhd+FazPqX6At7ZOsRhbBbW8r0GShiTYT+d0HnPXPaBinTmkvZu/iAF8XpzlU69Dv2VM7+ZchxJRt37PQ9HHMtn++Z2M4xrpd/hfrzmfbLA11HF/6IeVPvk3ZaZOFuPf/ZFt5+rrJfEwhBf9x7fnH2y5O3ZMf5hM2F4ZvfZOG0ORdiCEe8/0Q2jbbZC/9OF/dx2W4mZhLWX6xm+wt2yrzxc5D7cMwX3k+ozptfhpBMUYw0AiaMYKERjDXEYa+efYpT9Mw+LRGVld15j9OKyx7ZR3qMeUhjn5I84E1lr1n/VClWSEXm188D2voq8QFBV2y0L9QoEJgGqrTsdA/qSvVClsKBK5AuGTBSaJIhbAFxtYIW2Jsw2ITBbcsUYhwxIqywlRBvCgdxq5YbKIojiUKDa4Qc8oShCPmlAUIVyw4aT6VZqlCYyPulBYUBXGnNCC8YMFpqpQsVWhsyJ1gd1OQO8HupgULTlJFS5YqNDbkTbADacicYAfShgWnqWJZqtDYiDcF2IE0Yk4BdiBdseA0VRxLFRLbIN4UYOc0iDkF2DmNYsFpqmiWKjQ24k2B9R9jWWyi4JA5wZZvShacpgrkTbBzGsicYOe0ggUnqWIlSxUaW9FjDgH2Ngt5E+zK1rDgBSVGspacI7nqsxipAHKka5nVucxDaOczP/LAS1B4pb3WU5vyumn8OObP/m0G/j3V7Tz2fDD2Q1cviVrTdy/1UKd+LiX7I1tixmn0uys5DZNfq7oEqhZA1YdZ+Xro8q4+1t9C9P9t1RXwMBe/TdUOqNr+LlUXtxfecYqPglZ1LliLNXcUkkoRjyiKSBHlI4qmUuwjyu29FOIhxPlY3vzlx9WXx8XvWp9n83LBbvQphXgclxMH3/WvfjfFjxnx+11IvrtMzFoFyNJCX1qRtqToGllZaI2xkYWFFhgbWVhoibGhMLuC2CWUZTuMDUXZJcaGouwCY0NRtsXYhvMBhci2nI8eRHbB+SxBZJeceJ/IrjjpPpHtOCE5jV0JTkZOZEtOGExks0JsIvvmy6epfX64jrmmtZr0XbdiZdjEslkRNpFdAJLoe0nWYCUnnCUWyoqsiWzHiThpbCc4ESeRLTlBIZGtOEEhka05cRuRbThxG5HNisSIbFYiRmSXnHiGyK44sRKR7TgJCo0tBZSHCRAOONM5kA0401UgG3CmK0A24ExXgmzAmc6AbMCZzoJswJlOgWzAmU6DbMCZDjTm3e6oz5YkNzRpkSbv9kZ9utq55Q4Fja3oscodvGTkKoe6Hf2P0dq/Izf10Ccf+7DP+8Gfs7Np2fO5hFNdv19OqVPe+vpc1m1r52n1jjRyR/r/cEcGmH8Nzr9lPLbF+kJa3m37AjK6kp3RfZ0vm38vtV83Cm+y13kuzgPZQjnjnK2UsMbI0+k7RiNacw==" }
        local crafter = surface.create_entity { name = "rabbasca-vault-crafter",  position = offset }
        crafter.set_recipe("vault-protocol-iron-ore")
    ]]
}

data:extend {
{
    type = "tips-and-tricks-item",
    name = "rabbasca-briefing",
    category = "space-age",
    tag = "[planet=rabbasca]",
    indent = 0,
    order = "r[rabbasca]-a",
    trigger = {
        type = "research",
        technology = "planet-discovery-rabbasca",
    },
    -- simulation = simulation
},
{
    type = "tips-and-tricks-item",
    name = "rabbasca-vaults",
    category = "space-age",
    tag = "[entity=rabbasca-vault-crafter]",
    indent = 1,
    order = "r[rabbasca]-b",
    trigger = {
        type = "research",
        technology = "planet-discovery-rabbasca",
    },
},
{
    type = "tips-and-tricks-item",
    name = "rabbasca-bunnyhop",
    category = "space-age",
    tag = "[item=bunnyhop-engine]",
    indent = 1,
    order = "r[rabbasca]-c",
    trigger = {
        type = "research",
        technology = "bunnyhop-engine-1",
    },
},
{
    type = "tips-and-tricks-item",
    name = "rabbasca-warp-inventory",
    category = "space-age",
    tag = "[item=rabbasca-warp-sequence]",
    indent = 1,
    order = "r[rabbasca]-d",
    trigger = {
        type = "research",
        technology = "interplanetary-construction-1",
    },
},
}