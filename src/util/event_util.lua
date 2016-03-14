local importations = require(IMPORTATIONS)
local listener = require(importations.LISTENER)
local composer = require(importations.COMPOSER)

local onBackPressed

local function _setBackPressed(backPressed)
    onBackPressed = backPressed
end

local function _onKeyEvent(event)
    local keyName = event.keyName
    local phase = event.phase
    local platformName = system.getInfo('platformName')

    if (keyName == 'back' and phase == 'up') then

        if (composer.getSceneName('current') ~= 'src.scenes.menu') then
            if (onBackPressed ~= nil) then
                onBackPressed()
            end

            if (platformName == 'Android') or (platformName == 'WinPhone') then
                return true
            end
        end
    end

    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

Runtime:addEventListener(listener.KEY, _onKeyEvent)

return {
    setBackPressed = _setBackPressed
}