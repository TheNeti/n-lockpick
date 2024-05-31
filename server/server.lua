RegisterServerEvent('n-lockpick:durability')
AddEventHandler('n-lockpick:durability', function(slot, durability)
    local ox_inventory = exports.ox_inventory

    ox_inventory:SetDurability(source, slot, durability)
end)
