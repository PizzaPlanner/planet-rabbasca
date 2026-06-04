local surface = game.planets["rabbasca"] and game.planets["rabbasca"].surface
if surface and surface.no_enemies_mode then
  game.print({ "rabbasca-extra.no-enemies-mode-ignored" })
  surface.no_enemies_mode = false
end