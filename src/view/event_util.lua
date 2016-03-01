local listener = require("src.constant.listener")

local onBackPressed

local function _setBackPressed(backPressed)
    onBackPressed = backPressed
end

local function _onKeyEvent(event)
    local phase = event.phase
    local keyName = event.keyName

    if ("back" == keyName and phase == "up") then
        if (onBackPressed ~= nil) then
            onBackPressed()
        end
    end
end

Runtime:addEventListener(listener.KEY, _onKeyEvent)

return {
    setBackPressed = _setBackPressed
}