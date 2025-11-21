local sounds = require("__base__.prototypes.entity.sounds")
return {
{
    type = "play-sound",
    sound = sounds.nuclear_explosion(1.3),
    play_on_target_position = false,
    max_distance = 2000,
},
{
    type = "play-sound",
    sound = sounds.nuclear_explosion_aftershock(0.7),
    play_on_target_position = false,
    max_distance = 2000,
},
{
    type = "create-entity",
    check_buildability = true,
    entity_name = "rabbasca-meltdown-effect"
},
{
    type = "create-entity",
    entity_name = "nuke-explosion"
},
{
    type = "camera-effect",
    duration = 120,
    ease_in_duration = 5,
    ease_out_duration = 60,
    delay = 0,
    strength = 9,
    full_strength_max_distance = 400,
    max_distance = 1600
},
{
    type = "nested-result",
    action =
    {
        type = "area",
        radius = 36,
        target_entities = true,
        trigger_from_target = true,
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "damage",
                    damage = {amount = 400000, type = "explosion"},
                    -- lower_distance_threshold = 16,
                    -- upper_distance_threshold = 48,
                    -- lower_damage_modifier = 1,
                    -- upper_damage_modifier = 0,
                }
            }
        }
    }
},
{
    type = "invoke-tile-trigger",
    repeat_count = 1
},
{
    type = "destroy-decoratives",
    include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
    include_decals = true,
    invoke_decorative_trigger = true,
    decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
    radius = 48 -- large radius for demostrative purposes
},
{
    type = "nested-result",
    action =
    {
        type = "area",
        target_entities = false,
        trigger_from_target = true,
        repeat_count = 1000,
        radius = 10,
        action_delivery =
        {
            type = "projectile",
            projectile = "atomic-bomb-ground-zero-projectile",
            starting_speed = 0.6 * 0.8,
            starting_speed_deviation = 0.075
        }
    }
},
{
    type = "nested-result",
    action =
    {
        type = "area",
        target_entities = false,
        trigger_from_target = true,
        repeat_count = 1000,
        radius = 42,
        action_delivery =
        {
            type = "projectile",
            projectile = "atomic-bomb-wave",
            starting_speed = 0.5 * 0.7,
            starting_speed_deviation = 0.075
        }
    }
},
}