local importations = require(IMPORTATIONS)
local physics = require(importations.PHYSICS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local collisionUtil = require(importations.COLLISION_UTIL)
local swipeUtil = require(importations.SWIPE_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local listener = require(importations.LISTENER)
local images = require(importations.IMAGES)

local MAX_LIFES = 3

local randomObstaclesTimer
local earthObstacle
local airObstacle
local sprite
local life = MAX_LIFES

local bodyNames = {
    sprite = 'sprite',
    airObstacle = 'airObstacle',
    earthObstacle = 'earthObstacle'
}

local function _controlScientistJump()
    if (sprite ~= nil) then

        local spriteLocationY = displayConstants.HEIGHT_SCREEN - 55
        local roundedSpriteY = math.floor(sprite.y)
        local maxDifferencePermitted = 2

        if (sprite.y < 550) then

            sprite:setLinearVelocity(0, 0)
            sprite:setLinearVelocity(0, 700)
        elseif (roundedSpriteY == spriteLocationY
                or roundedSpriteY + maxDifferencePermitted == spriteLocationY
                or roundedSpriteY - maxDifferencePermitted == spriteLocationY) then

            sprite:setLinearVelocity(0, 0)
            sprite.y = displayConstants.HEIGHT_SCREEN - 55
        end
    end
end

local function _clear()

    Runtime:removeEventListener(listener.ENTER_FRAME, collisionUtil.action())
    Runtime:removeEventListener(listener.ENTER_FRAME, _controlScientistJump)

    timer.cancel(randomObstaclesTimer)

    if (airObstacle ~= nil) then
        physics.removeBody(airObstacle)

        airObstacle:removeSelf()
        airObstacle = nil
    end

    if (earthObstacle ~= nil) then
        physics.removeBody(earthObstacle)

        earthObstacle:removeSelf()
        earthObstacle = nil
    end
end

local function _make(sp, background, group)
    sprite = sp

    physics.start()

    local obstacleSize = 50
    local defaultObstacleX = displayConstants.WIDTH_SCREEN + 75

    airObstacle = display.newRect(0, 0, obstacleSize, obstacleSize)
    airObstacle.x = defaultObstacleX
    airObstacle.y = displayConstants.HEIGHT_SCREEN - (obstacleSize * 3)

    earthObstacle = display.newRect(0, 0, obstacleSize, obstacleSize)
    earthObstacle.x = defaultObstacleX
    earthObstacle.y = displayConstants.HEIGHT_SCREEN - (obstacleSize / 2)

    physics.addBody(airObstacle, 'kinematic', { density = 1, isSensor = false })
    physics.addBody(earthObstacle, 'kinematic', { density = 1, isSensor = false })
    physics.addBody(sprite, 'dynamic', { density = 1, friction = 0, radius = 0, bounce = 1, isSensor = false })

    local distance = { x = 120, y = 60 }
    local lifeImages = {}

    for i = 1, MAX_LIFES do
        lifeImages[i] = display.newImageRect(images.LIFE, 100, 100)
        lifeImages[i].y = distance.y

        if (i == 1) then
            lifeImages[i].x = displayConstants.WIDTH_SCREEN - distance.y
        else
            lifeImages[i].x = lifeImages[i - 1].x - distance.x
        end

        group:insert(lifeImages[i])
    end

    local function translationObstacle()

        airObstacle:setLinearVelocity(-200, 0);
        earthObstacle:setLinearVelocity(-500, 0);

        if (airObstacle.x < displayConstants.LEFT_SCREEN) then

            airObstacle.x = defaultObstacleX
        end

        if (earthObstacle.x < displayConstants.LEFT_SCREEN) then

            earthObstacle.x = defaultObstacleX
        end
    end

    sprite.myName = bodyNames.sprite
    airObstacle.myName = bodyNames.airObstacle
    earthObstacle.myName = bodyNames.earthObstacle

    local function spriteCollision(self, event)
        if (event.phase == 'ended') then
            print(self.myName, ': collision ended with ', event.other.myName)
        end
    end

    sprite.collision = spriteCollision
    sprite:addEventListener('collision', sprite)

    randomObstaclesTimer = timer.performWithDelay(500, translationObstacle, -1);

    local function collisionAction()
        system.vibrate()

        sprite:setLinearVelocity(0, 0)
        sprite.y = displayConstants.HEIGHT_SCREEN - 55

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