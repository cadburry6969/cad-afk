RegisterNetEvent("KickForAFK", function()
    local source = source
    DropPlayer(source, "You were AFK for too long")
end)