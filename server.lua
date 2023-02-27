RegisterNetEvent("KickForAFK", function()
    local src = source
    DropPlayer(src, "You were AFK for too long")
end)
