local physics = require("physics")
local displayUtil = require("src.view.display_util")
local collisionUtil = require("src.view.collision_util")
local swipeUtil = require("src.view.swipe_util")
local sceneManager = require("src.scenes.manager")
local listener = require("src.constant.listener")

local randomObstaclesTimer
local obstacle
local sprite

local function _clear()

    Runtime:removeEventListener(listener.ENTER_FRAME, collisionUtil.action())

    timer.cancel(randomObstaclesTimer)

    if (obstacle ~= nil) then
        physics.removeBody(obstacle)

        obstacle:removeSelf()
        obstacle = nil
    end
end

local function _make(sp, background)
    sprite = sp

    physics.start()

    obstacle = display.newRect(0, 0, 100, 100)
    obstacle.x = displayUtil.WIDTH_SCREEN + 75
    obstacle.y = displayUtil.HEIGHT_SCREEN

    physics.addBody(obstacle, "kinematic", { density = 1, isSensor = false })
    physics.addBody(sprite, "dynamic", { density = 1, friction = 0, radius = 0, bounce = 1, isSensor = false })

    local function translationObstacle()

        obstacle:setLinearVelocity(-500, 0);

        if (obstacle.x < displayUtil.LEFT_SCREEN) then

            obstacle.x = displayUtil.WIDTH_SCREEN + 75
        end
    end

    randomObstaclesTimer = timer.performWithDelay(500, translationObstacle, -1);

    collisionUtil.collision({ object1 = sprite, object2 = obstacle }, function()
        _clear()
        sceneManager.goMenu()
    end)

    swipeUtil.swipe(background, {
        left = function()
            sprite:setLinearVelocity(0, 0)
            sprite.x = displayUtil.LEFT_SCREEN + 100
            sprite.y = displayUtil.HEIGHT_SCREEN - 80
        end,
        right = function()
            sprite:setLinearVelocity(0, 0)
            sprite.x = displayUtil.LEFT_SCREEN + 100
            sprite.y = displayUtil.HEIGHT_SCREEN - 80
        end,
        down = function()
            sprite:setLinearVelocity(0, 0)
            sprite:setLinearVelocity(0, 500)
        end,
        up = function()
            sprite:setLinearVelocity(0, -500)
        end
    })

    local function controlScientistJump()
        print(sprite.x, sprite.y)
    end

    Runtime:addEventListener(listener.ENTER_FRAME, controlScientistJump)
end

return {
    make = _make,
    clear = _clear
}