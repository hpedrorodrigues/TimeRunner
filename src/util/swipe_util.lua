local importations = require(IMPORTATIONS)
local listener = require(importations.LISTENER)

local events = {}

local function _handleSwipe(event)
    if (events ~= nil and event.phase == 'moved') then

        local dY = event.y - event.yStart
        local dX = event.x - event.xStart

        if (dX < -10) then
            -- Swipe LEFT

            if (events.left ~= nil) then
                events.left()
            end
        elseif (dX > 10) then
            -- Swipe RIGHT

            if (events.right ~= nil) then
                events.right()
            end
        elseif (dY > 10) then
            -- Swipe DOWN

            if (events.down ~= nil) then
                events.down()
            end
        elseif (dY < -10) then
            -- Swipe UP

            if (events.up ~= nil) then
                events.up()
            end
        end
    end

    return true
end

local function _swipe(object, evs)
    events = evs

    object:addEventListener(listener.TOUCH, _handleSwipe)
end

return {
    swipe = _swipe
}