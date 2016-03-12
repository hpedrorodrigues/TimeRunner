local physics = require("physics")
local displayUtil = require("src.view.display_util")

function _make(sprite, background)

    physics.start()

    physics.addBody(sprite, "dynamic", { density = 1, friction = 0, radius = 0, isSensor = false, bounce = 1 })

    rectangle = display.newRect(0, 0, 100, 100)

    rectangle.x = displayUtil.WIDTH_SCREEN + 75
    rectangle.y = displayUtil.HEIGHT_SCREEN

    physics.addBody(rectangle, "kinematic", { isSensor = true })

    function moveRandomly()
        rectangle:setLinearVelocity(-200, 0);
        if (rectangle.x < displayUtil.LEFT_SCREEN) then
            rectangle.x = displayUtil.WIDTH_SCREEN + 75
        end
    end

    timer.performWithDelay(500, moveRandomly, -1);

    local function handleSwipe(event)
        -- Reference - https://coronalabs.com/blog/2014/09/16/tutorial-swiping-an-object-to-fixed-points/
        if (event.phase == "moved") then

            local dY = event.y - event.yStart
            local dX = event.x - event.xStart

            if (dX < -10) then
                -- Swipe LEFT

                sprite:setLinearVelocity(0, 0)
                sprite.x = displayUtil.LEFT_SCREEN + 100
                sprite.y = displayUtil.HEIGHT_SCREEN - 80
            elseif (dY > 10) then
                -- Swipe DOWN

                sprite:setLinearVelocity(0, 500)
            elseif (dY < -10) then
                -- Swipe UP

                sprite:setLinearVelocity(0, -500)
            end
        end
        return true
    end

    background:addEventListener("touch", handleSwipe)
end

return {
    make = _make
}