local afkTable = {
    enabled = true,
    previouspos = nil,
    time = nil,
    timewarnings = {[900]=true, [600]=true, [300]=true, [150]=true, [60]=true, [30]=true, [10]=true}
}

local lastX, lastY
function IsPositionSame()
    local x, y = GetNuiCursorPosition()
    if lastX and lastY then
        if lastX == x and lastY == y then
            return true
        end
    end
    lastX = x
    lastY = y
    return false
end

if afkTable.enabled then
CreateThread(function()
    while true do
        Wait(10000)
        local playerPed = PlayerPedId()
        local currentPos = GetEntityCoords(playerPed, true)
        if afkTable.previouspos then
            if currentPos == afkTable.previouspos and IsPositionSame() then
                if afkTable.time then
                    if afkTable.time > 0 then
                        if afkTable.timewarnings[afkTable.time] then
                            TriggerEvent('chat:addMessage', {
                                color = { 0, 0, 255 },
                                multiline = true,
                                args = { "Server", "You are afk for too long, you will be kicked in "..tostring(math.ceil(afkTable.time / 60)).." minutes." }
                            })
                        end
                        afkTable.time = afkTable.time - 10
                    else
                        TriggerServerEvent('KickForAFK')
                    end
                else
                    afkTable.time = 1800
                end
            else
                afkTable.time = 1800
            end
        end
        afkTable.previouspos = currentPos
    end
end)
end