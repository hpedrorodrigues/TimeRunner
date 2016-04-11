local importations = require(IMPORTATIONS)
local physics = require(importations.PHYSICS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local swipeUtil = require(importations.SWIPE_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local listener = require(importations.LISTENER)
local images = require(importations.IMAGES)
local bearSpriteManager = require(importations.BEAR_SPRITE)
local tigerSpriteManager = require(importations.TIGER_SPRITE)

local MAX_LIFES = 3

local earthObstacle
local airObstacle
local life = MAX_LIFES

local sprite

local bodyNames = {
    sprite = 'sprite',
    airObstacle = 'airObstacle',
    earthObstacle = 'earthObstacle'
}

local playerCollisionFilter = { categoryBits = 1, maskBits = 14 }
local airObstacleCollisionFilter = { categoryBits = 2, maskBits = 9 }
local earthObstacleCollisionFilter = { categoryBits = 4, maskBits = 9 }
local bottomWallCollisionFilter = { categoryBits = 8, maskBits = 7 }

local lifeImages

local _collisionFunction

local defaultObstacleX = displayConstants.WIDTH_SCREEN + 75
local collisionThrottle = true
local collisionDelayTime = 2

local function _translationObstacle()

    if (airObstacle ~= nil) then

        if (airObstacle.x < displayConstants.LEFT_SCREEN) then

            airObstacle.x = defaultObstacleX
        else
            airObstacle:setLinearVelocity(-500, 0)
        end
    end

    if (earthObstacle ~= nil) then

        if (earthObstacle.x < displayConstants.LEFT_SCREEN) then

            earthObstacle.x = defaultObstacleX

            if (earthObstacle.myName == bodyNames.earthObstacle) then
                local randomNumber = math.random(1, 2)

                if (randomNumber == 1) then
                    earthObstacle = bearSpriteManager.create()
                elseif (randomNumber == 2) then
                    earthObstacle = tigerSpriteManager.create()
                else
                    earthObstacle = tigerSpriteManager.create()
                end

                earthObstacle:play()

                physics.addBody(earthObstacle, 'dynamic', { density = 1, friction = 1, bounce = .2, filter = earthObstacleCollisionFilter })
            end
        else

            earthObstacle:setLinearVelocity(-500, 0)
        end
    end
end

local function _clear()

    Runtime:removeEventListener(listener.ENTER_FRAME, _translationObstacle)
    Runtime:removeEventListener(listener.COLLISION, _collisionFunction)

    if (sprite ~= nil) then
        physics.removeBody(sprite)

        sprite:removeSelf()
        sprite = nil
    end

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

    physics.stop()
end

local function _collisionAction(obstacle, sprite)
    system.vibrate()

    lifeImages[life].isVisible = false

    life = life - 1

    if (life == 0) then

        life = MAX_LIFES

        timer.performWithDelay(collisionDelayTime, function()

            sceneManager.goMenu()
        end)
    end
end

_collisionFunction = function(event)

    local obstacle = event.object1
    local isObstacle = obstacle ~= nil and (obstacle.myName == bodyNames.airObstacle or obstacle.myName == bodyNames.earthObstacle)
    local sprite = event.object2
    local isSprite = sprite ~= nil and sprite.myName == bodyNames.sprite

    if (isObstacle and isSprite and collisionThrottle) then

        collisionThrottle = false

        timer.performWithDelay(1000, function()
            collisionThrottle = true
        end)

        if (event.phase == 'began') then

            _collisionAction(obstacle, sprite)

            obstacle.isVisible = false
        elseif (event.phase == 'ended') then

            timer.performWithDelay(collisionDelayTime, function()
                if (obstacle ~= nil) then
                    obstacle.isVisible = true
                end
            end)
        end

        timer.performWithDelay(1000, function()
            sprite.x = displayConstants.LEFT_SCREEN + 100
            sprite.y = displayConstants.HEIGHT_SCREEN - 55
        end)
    end
end

local function _make(sp, background, group)
    local halfWidth = display.contentWidth / 2
    local bottomWall = display.newRect(halfWidth, display.contentHeight, display.contentWidth, 0)

    sprite = sp

    physics.start()

    physics.setGravity(0, 9.8)

    physics.setDrawMode('hybrid')

    local obstacleSize = 50

    airObstacle = display.newRect(0, 0, obstacleSize, obstacleSize)
    airObstacle.x = defaultObstacleX
    airObstacle.y = displayConstants.HEIGHT_SCREEN - (obstacleSize * 3)

    --    earthObstacle = display.newRect(0, 0, obstacleSize, obstacleSize)
    earthObstacle = bearSpriteManager.create()
    earthObstacle.x = defaultObstacleX
    earthObstacle.y = displayConstants.HEIGHT_SCREEN - 50
    earthObstacle:play()

    physics.addBody(bottomWall, 'static', { density = 1, friction = 0, bounce = 1, filter = bottomWallCollisionFilter })
    physics.addBody(airObstacle, 'dynamic', { density = 1, friction = 1, bounce = .2, filter = airObstacleCollisionFilter })
    physics.addBody(earthObstacle, 'dynamic', { density = 1, friction = 1, bounce = .2, filter = earthObstacleCollisionFilter })
    physics.addBody(sprite, 'dynamic', { density = 1, friction = 1, bounce = .2, filter = playerCollisionFilter })

    local distance = { x = 120, y = 60 }
    lifeImages = {}

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

    sprite.myName = bodyNames.sprite
    airObstacle.myName = bodyNames.airObstacle
    earthObstacle.myName = bodyNames.earthObstacle

    swipeUtil.swipe(background, {
        down = function()
            sprite:setLinearVelocity(0, -200)
        end,
        up = function()
            sprite:setLinearVelocity(0, 200)
        end
    })

    Runtime:addEventListener(listener.ENTER_FRAME, _translationObstacle)
    Runtime:addEventListener(listener.COLLISION, _collisionFunction)
end

return {
    make = _make,
    clear = _clear
}