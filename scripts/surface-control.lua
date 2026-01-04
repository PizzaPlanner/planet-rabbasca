local output = { }

function output.rabbasca_set_vault_active(e, active)
  if (not e) or e.name ~= "rabbasca-vault-crafter" then return end
  e.active = true -- disabling prevents hp regeneration
  if active then
    e.force = game.forces.player
  else
    e.force = game.forces.rabbascans
  end
end

function output.update_alertness(surface, position)
  local active_vaults_count = #surface.find_entities_filtered { name = "rabbasca-vault-console", force = game.forces.player }
  local is_meltdown = #surface.find_entities_filtered { name = "rabbasca-vault-meltdown" } > 0
  local modulation = storage.alertness_modulation or 0
  local new_evo = active_vaults_count * settings.global["rabbasca-evolution-per-vault"].value / 100 + modulation * Rabbasca.alertness_modulation_step() / 100
  new_evo = math.max(0, math.min(1, new_evo))
  if is_meltdown then new_evo = 1 end
  game.forces.rabbascans.set_evolution_factor(new_evo, surface)
  game.forces.enemy.set_evolution_factor(new_evo, surface) -- make sure factoriopedia evolution ui shows correct value
  storage.hacked_vaults = active_vaults_count
  if not position then return end
  local new_evo_text = string.format("%.1f", game.forces.rabbascans.get_evolution_factor(surface) * 100)
  for _, player in pairs(game.players) do
    player.create_local_flying_text { text = {"rabbasca-extra.alertness-floating", new_evo_text}, surface = surface, position = position }
    output.update_evolution_bar(player)
  end
end

local function create_evolution_bar(player)
    if player.gui.top.rabbasca_alertness then
        player.gui.top.rabbasca_alertness.destroy() 
    end
    if not settings.get_player_settings(player)["rabbasca-show-alertness-ui"].value then return end
    
    local vaults = storage.hacked_vaults or 0
    local evo = game.forces["rabbascans"].get_evolution_factor("rabbasca")
    local color = { 0, 1, 0 }
    if evo > 0.9 then color = { 1, 0, 0 } 
    elseif evo > 0.6  then color = { 0.75, 0.25, 0 }
    elseif evo > 0.4  then color = { 1, 1, 0 }
    elseif evo > 0.25 then color = { 0.5, 1, 0 }
    elseif evo > 0.1  then color = { 0.25, 1, 0 }
    end

    local frame = player.gui.top.add{
        type = "frame",
        name = "rabbasca_alertness",
        direction = "horizontal",
        style = "slot_window_frame",
    }
    frame.add{
        type = "sprite-button",
        sprite= "entity/rabbasca-vault-crafter",
        style = "inventory_slot",
        name = "icon",
        number = vaults,
        tooltip = {
          "rabbasca-extra.alertness-ui-tooltip", 
          storage.hacked_vaults or 0, 
          settings.global["rabbasca-evolution-per-vault"].value, 
          storage.alertness_modulation or 0, 
          Rabbasca.alertness_modulation_step(),
          string.format("%i", evo * 100) 
        }
    }
    local right = frame.add {
        type = "flow",
        direction = "vertical",
        name = "right",
    }
    right.style.top_padding = 2
    right.add{
        type = "label", 
        name = "evolution_title",
        caption = { "rabbasca-extra.alertness-ui", string.format("%i", evo * 100) }
    }
    local bar = right.add{
        type = "progressbar",
        name = "evolution_bar",
        value = evo
    }
    bar.style.horizontally_stretchable = true
    bar.style.color = color
end

function output.update_evolution_bar(player)
    local is_on_rabbasca = player.surface and player.surface.name == "rabbasca"
    local ui = player.gui.top.rabbasca_alertness
    if ui and not is_on_rabbasca then
        ui.destroy()
    elseif is_on_rabbasca then
        create_evolution_bar(player)
    end
end

return output