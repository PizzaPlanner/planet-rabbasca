if data.raw["unit"]["behemoth-wasp"] then
  local effects = data.raw["unit"]["rabbasca-vault-panic-dummy"].created_effect.action_delivery.source_effects
  table.insert(effects, 1, 
    { type = "create-entity", entity_name = "behemoth-wasp", as_enemy = true, probability = 0.1, offset_deviation = { {-12, -12}, {12, 12} } }
  )
end