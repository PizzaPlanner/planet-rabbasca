local M = { }

function M.is_type_supported(type)

end

function M.logistics_group_name()
    return tostring(settings.global["rabbasca-warp-inventory-name"].value)
end

function M.init_inventory()
    storage.inventory_warpers = { }
    storage.invetory_logistic_section = storage.invetory_logistic_section or { }
    for _, surface in pairs(game.surfaces) do
        for _, e in pairs(surface.find_entities_filtered { name = "rabbasca-warp-input" }) do
            table.insert(storage.inventory_warpers, e)
        end
    end

    if storage.warp_inventory then return end
    storage.warp_inventory = game.create_inventory(512, { "rabbasca-extra.warp-inventory" })
end

function M.update_logistic_section()
    local logi = game.forces.player.get_logistic_group(M.logistics_group_name())
    if not logi then
        game.forces.player.create_logistic_group(M.logistics_group_name())
        return
    end
    if #logi.members == 0 then return end
    local l = logi.members[1]
    local filters = { }
    for _, content in pairs(storage.warp_inventory.get_contents()) do
        local f = {
            value = { name = content.name, quality = content.quality },
            min = content.count,
        }
        table.insert(filters, f)
    end
    table.insert(filters, { value = { type = "virtual", name = "signal-black", quality = "normal" }, min = storage.warp_inventory.count_empty_stacks() })
    l.filters = filters
end

return M