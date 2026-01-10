local rock = util.merge {
    table.deepcopy(data.raw["simple-entity"]["big-volcanic-rock"]),
    {
      name = "rabbasca-underground-rock",
      minable = { 
        mining_time = 3,
      },
      autoplace = {
        probability_expression = "rabbasca_underground_elevation > 0.85",
      },
      map_color = {0.09, 0.12, 0.17},
      collision_box = {{-3, -3}, {3, 3.5}},
      selection_box = {{-2.9, -2.9}, {2.9, 3.4}},
    }
}

rock.minable.results = {
  {type = "item", name = "stone", amount_min = 12, amount_max = 17 }, 
  {type = "item", name = "calcite", amount_min = 9, amount_max = 12 }
}
for _, pic in pairs(rock.pictures) do
  pic.scale = 5 * (pic.scale or 1)
end

data:extend {
  rock,
  util.merge {
    data.raw["electric-energy-interface"]["rabbasca-energy-source"],
    {
      name = "rabbasca-energy-source-big",
      energy_production = Rabbasca.surface_megawatts() * 5 .. "MW",
      energy_source = { 
        buffer_capacity = (Rabbasca.surface_megawatts() * 5 / 6) .. "MJ", 
        output_flow_limit = Rabbasca.surface_megawatts() * 5 .. "MW",
      },
      created_effect = {
        type = "direct",
        action_delivery = {
          {
            type = "instant",
            target_effects =
            {
              {
                type = "create-entity",
                entity_name = "rabbasca-energy-consumer-big",
                offsets = {{0, 0}},
                protected = true,
              },
            }
          }
        }
      }
    },
  },
  util.merge {
    data.raw["electric-energy-interface"]["rabbasca-energy-source"],
    {
      name = "rabbasca-energy-consumer-big",
      icon = data.raw["segmented-unit"]["big-demolisher"].icon,
      type = "beacon",
      flags = data.raw["electric-energy-interface"]["rabbasca-energy-source"].flags,
      energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
      },
      energy_usage = Rabbasca.surface_megawatts() * 50 .. "MW",
      supply_area_distance = 0,
      distribution_effectivity = 0,
      module_slots = 0,
    }
  }
}