local physics = require("physics")
local displayUtil = require("src.view.display_util")
local collisionUtil = require("src.view.collision_util")
local swipeUtil = require("src.view.swipe_util")
local sceneManager = require("src.scenes.manager")
local listener = require("src.constant.listener")
local images = require("src.constant.images")

local MAX_LIFES = 3

local randomObstaclesTimer
local earthObstacle
local airObstacle
local sprite
local life = MAX_LIFES

local bodyNames = {
    sprite = "sprite",
    airObstacle = "airObstacle",
    earthObstacle = "earthObstacle"
}

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

    if (earthObstacle ~= nil) then
        physics.removeBody(earthObstacle)

        earthObstacle:removeSelf()
        earthObstacle = nil
    end
    if (airObstacle ~= nil) then
        physics.removeBody(airObstacle)

        airObstacle:removeSelf()
        airObstacle = nil
    end
end

local function _make(sp, background, group)
    sprite = sp

    physics.start()

    local obstacleSize = 50

    earthObstacle = display.newRect(0, 0, obstacleSize, obstacleSize)
    earthObstacle.x = displayUtil.WIDTH_SCREEN + 75
    earthObstacle.y = displayUtil.HEIGHT_SCREEN - (obstacleSize / 2)

    airObstacle = display.newRect(0, 0, obstacleSize, obstacleSize)
    airObstacle.x = displayUtil.WIDTH_SCREEN + 75
    airObstacle.y = earthObstacle.y - (obstacleSize * 3)

    physics.addBody(airObstacle, "kinematic", { density = 1, isSensor = false })
    physics.addBody(earthObstacle, "kinematic", { density = 1, isSensor = false })
    physics.addBody(sprite, "dynamic", { density = 1, friction = 0, radius = 0, bounce = 1, isSensor = false })

    local distance = { x = 120, y = 60 }
    local lifeImages = {}

    for i = 1, MAX_LIFES do
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

        airObstacle:setLinearVelocity(-200, 0);
        earthObstacle:setLinearVelocity(-500, 0);

        if (earthObstacle.x < displayUtil.LEFT_SCREEN) then

            earthObstacle.x = displayUtil.WIDTH_SCREEN + 75
        end
        if (airObstacle.x < displayUtil.LEFT_SCREEN) then

            airObstacle.x = displayUtil.WIDTH_SCREEN + 75
        end
    end

    sprite.myName = bodyNames.sprite
    earthObstacle.myName = bodyNames.earthObstacle
    airObstacle.myName = bodyNames.airObstacle

    local function spriteCollision(self, event)
        if (event.phase == "ended") then
            print(self.myName, ": collision ended with ", event.other.myName)
        end
    end

    sprite.collision = spriteCollision
    sprite:addEventListener("collision", sprite)

    randomObstaclesTimer = timer.performWithDelay(500, translationObstacle, -1);

    local function collisionAction()
        system.vibrate()

        sprite:setLinearVelocity(0, 0)
        sprite.y = displayUtil.HEIGHT_SCREEN - 55

        lifeImages[life].isVisible = false

        life = life - 1

        if (life == 0) then

            life = MAX_LIFES

            _clear()
            sceneManager.goMenu()
        end
    end

    collisionUtil.collision({ object1 = sprite, object2 = airObstacle }, collisionAction)
    collisionUtil.collision({ object1 = sprite, object2 = earthObstacle }, collisionAction)

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