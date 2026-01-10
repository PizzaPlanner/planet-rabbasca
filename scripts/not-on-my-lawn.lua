for _, thing in pairs(data.raw["solar-panel"]) do 
  Rabbasca.not_on_harenic_surface(thing)
end
for _, thing in pairs(data.raw["burner-generator"]) do 
  Rabbasca.not_on_harenic_surface(thing)
end
for _, thing in pairs(data.raw["generator"]) do 
  Rabbasca.not_on_harenic_surface(thing)
end
for _, thing in pairs(data.raw["fusion-generator"]) do 
  Rabbasca.not_on_harenic_surface(thing)
end
for _, thing in pairs(data.raw["accumulator"]) do 
  Rabbasca.not_on_harenic_surface(thing)
end
for _, thing in pairs(data.raw["rocket-silo"]) do 
  Rabbasca.not_on_harenic_surface(thing, 3)
end

Rabbasca.not_on_harenic_surface(data.raw["recipe"]["rocket-part"])

-- TODO
-- local specific = {
--     data.raw["land-mine"]["teleporter"]
-- }

-- for _, proto in pairs(specific) do
--     if proto then Rabbasca.not_on_harenic_surface(proto, 0) end
-- end