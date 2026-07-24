if not mods["maraxsis"] then return end
if not data.raw["fluid"]["maraxsis-omega-3"] then return end

data:extend {
    {
        type = "capsule",
        name = "rabbasca-health-supplement",
        icon = "__base__/graphics/icons/slowdown-capsule.png",
        weight = 1 * kg,
        stack_size = 50,
        subgroup = "rabbasca-processes",
        order = "b[organic]-g[health-supplement]",
        capsule_action = util.merge {
            require("__space-age__.prototypes.item-effects").jellynut_speed,
            { attack_parameters = { ammo_type = { action = { action_delivery = { target_effects = { { sticker = "rabbasca-health-supplement-sticker" } } } } } }  }
        }
    },
    {
        type = "recipe",
        name = "rabbasca-health-supplement",
        categories = { "organic", "chemistry" },
        ingredients = { 
            { type = "item", name = "plastic-bottle", amount = 1 },
            { type = "item", name = "iron-ore", amount = 1 },
            { type = "fluid", name = "beta-carotene", amount = 25 },
            { type = "fluid", name = "maraxsis-omega-3", amount = 18 },
        },
        results = {
            { type = "item", name = "rabbasca-health-supplement", amount = 1 }
        }
    },
    {
        type = "sticker",
        name = "rabbasca-health-supplement-sticker",
        duration_in_ticks = 1 * minute,
        flags = {"not-on-map"},
        hidden = true,
        single_particle = true,
        animation = {
            layers = { 
                Rabbasca.animation_layer("__rabbasca-assets__/graphics/recolor/textures/sani", { tint = { 0.83, 0, 0.72 }, scale = 0.16, draw_as_glow = true, blend_mode = "additive", shift = util.by_pixel(-8,-54) }),
            }
        },
        damage_per_tick = { amount = -5, type = "poison" },
        damage_interval = 10,
        target_movement_modifier = 1.25,
        update_effects = {
            { 
                time_cooldown = 0.5 * second,
                effect =
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        radius = 5,
                        force = "all",
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "damage",
                                    damage = { amount = -20, type = "impact" }
                                },
                            },
                        }
                    }
                }
            }
        }
    }
}