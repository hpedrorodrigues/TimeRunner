local physics = require("physics")
local displayUtil = require("src.view.display_util")
local collisionUtil = require("src.view.collision_util")
local swipeUtil = require("src.view.swipe_util")
local sceneManager = require("src.scenes.manager")
local listener = require("src.constant.listener")
local images = require("src.constant.images")

local INITIAL_LIFE = 3

local randomObstaclesTimer
local obstacle
local sprite
local life = INITIAL_LIFE

local function _controlScientistJump()
    if (sprite ~= nil) then

        local spriteLocationY = displayUtil.HEIGHT_SCREEN - 55
        local roundedSpriteY = math.floor(sprite.y)
        local maxDifferencePermitted = 2

        if (sprite.y < 550) then

            sprite:setLinearVelocity(0, 0)
            sprite:setLinearVelocity(0, 700)
        elseif (roundedSpriteY == spriteLocationY
                or roundedSpriteY + maxDifferencePermitted == spriteLocationY
                or roundedSpriteY - maxDifferencePermitted == spriteLocationY) then

            sprite:setLinearVelocity(0, 0)
            sprite.y = displayUtil.HEIGHT_SCREEN - 55
        end
    end
end

local function _clear()

    Runtime:removeEventListener(listener.ENTER_FRAME, collisionUtil.action())
    Runtime:removeEventListener(listener.ENTER_FRAME, _controlScientistJump)

    timer.cancel(randomObstaclesTimer)

    if (obstacle ~= nil) then
        physics.removeBody(obstacle)

        obstacle:removeSelf()
        obstacle = nil
    end
end

local function _make(sp, background, group)
    sprite = sp

    physics.start()

    obstacle = display.newRect(0, 0, 75, 75)
    obstacle.x = displayUtil.WIDTH_SCREEN + 75
    obstacle.y = displayUtil.HEIGHT_SCREEN

    physics.addBody(obstacle, "kinematic", { density = 1, isSensor = false })
    physics.addBody(sprite, "dynamic", { density = 1, friction = 0, radius = 0, bounce = 1, isSensor = false })

    local distance = { x = 100, y = 60 }
    local lifeImages = {}

    for i = 1, 3 do
        lifeImages[i] = display.newImageRect(images.LIFE, 100, 100)
        lifeImages[i].y = distance.y

        if (i == 1) then
            lifeImages[i].x = displayUtil.WIDTH_SCREEN - distance.y
        else
            lifeImages[i].x = lifeImages[i - 1].x - distance.x
        end

        group:insert(lifeImages[i])
    end

    local function translationObstacle()

        obstacle:setLinearVelocity(-500, 0);

        if (obstacle.x < displayUtil.LEFT_SCREEN) then

            obstacle.x = displayUtil.WIDTH_SCREEN + 75
        end
    end

    randomObstaclesTimer = timer.performWithDelay(500, translationObstacle, -1);

    collisionUtil.collision({ object1 = sprite, object2 = obstacle }, function()
        system.vibrate()

        sprite:setLinearVelocity(0, 0)
        sprite.y = displayUtil.HEIGHT_SCREEN - 55

        lifeImages[life].isVisible = false

        life = life - 1

        if (life == 0) then

            life = INITIAL_LIFE

            _clear()
            sceneManager.goMenu()
        end
    end)

    swipeUtil.swipe(background, {
        down = function()
            sprite:setLinearVelocity(0, 0)
            sprite:setLinearVelocity(0, 500)
        end,
        up = function()
            sprite:setLinearVelocity(0, -500)
        end
    })

    Runtime:addEventListener(listener.ENTER_FRAME, _controlScientistJump)
end

return {
    make = _make,
    clear = _clear
}