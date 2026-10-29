if not storage.last_bunnyhops then return end

local new_hop_data = { }

for _, player in pairs(game.players) do
    local data = player.character and player.character.valid and storage.last_bunnyhops[player.character.unit_number]
    new_hop_data[player.index] = data
end

storage.last_bunnyhops = new_hop_data