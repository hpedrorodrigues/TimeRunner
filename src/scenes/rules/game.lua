local importations = require(IMPORTATIONS)
local physics = require(importations.PHYSICS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local swipeUtil = require(importations.SWIPE_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local listener = require(importations.LISTENER)
local images = require(importations.IMAGES)
local bearSpriteManager = require(importations.BEAR_SPRITE)

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

local playerCollisionFilter = { categoryBits = 1, maskBits = 6 }
local airObstacleCollisionFilter = { categoryBits = 2, maskBits = 1 }
local earthObstacleCollisionFilter = { categoryBits = 4, maskBits = 1 }

local lifeImages

local _collisionFunction

local defaultObstacleX = displayConstants.WIDTH_SCREEN + 75

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

local function _translationObstacle()

    local obstacles = { airObstacle, earthObstacle }

    for i, obstacle in ipairs(obstacles) do

        if (obstacle ~= nil) then

            if (obstacle.x < displayConstants.LEFT_SCREEN) then

                obstacle.x = defaultObstacleX
            else
                obstacle:setLinearVelocity(-500, 0);
            end
        end
    end
end

local function _clear()

    Runtime:removeEventListener(listener.ENTER_FRAME, _translationObstacle)
    Runtime:removeEventListener(listener.COLLISION, _collisionFunction)
    Runtime:removeEventListener(listener.ENTER_FRAME, _controlScientistJump)

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

        timer.performWithDelay(2, function()

            sceneManager.goMenu()
        end)
    end
end

_collisionFunction = function(event)

    local obstacle = event.object1
    local isObstacle = obstacle ~= nil and (obstacle.myName == bodyNames.airObstacle or obstacle.myName == bodyNames.earthObstacle)
    local sprite = event.object2
    local isSprite = sprite ~= nil and sprite.myName == bodyNames.sprite

    if (isObstacle and isSprite) then

        if (event.phase == 'began') then

            _collisionAction(obstacle, sprite)

            if (obstacle.isVisible) then
                obstacle.isVisible = false
            end
        elseif (event.phase == 'ended') then

            timer.performWithDelay(500, function()
                if (obstacle ~= nil) then
                    obstacle.isVisible = true
                end
            end, 1)
        end
    end
end

local function _make(sp, background, group)
    sprite = sp

    physics.start()

    physics.setGravity(0, 9.8)

--    physics.setDrawMode('hybrid')

    local obstacleSize = 50

    airObstacle = display.newRect(0, 0, obstacleSize, obstacleSize)
    airObstacle.x = defaultObstacleX
    airObstacle.y = displayConstants.HEIGHT_SCREEN - (obstacleSize * 3)

    --    earthObstacle = display.newRect(0, 0, obstacleSize, obstacleSize)
    earthObstacle = bearSpriteManager.create()
    earthObstacle.x = defaultObstacleX
    earthObstacle.y = displayConstants.HEIGHT_SCREEN - (obstacleSize / 2)
    earthObstacle:play()

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
            sprite:applyForce(0, 0)
            sprite:applyForce(0, 4.5, sprite.x, sprite.y)
        end,
        up = function()
            sprite:applyForce(0, 0)
            sprite:applyForce(0, -4.5, sprite.x, sprite.y)
        end
    })

    Runtime:addEventListener(listener.ENTER_FRAME, _translationObstacle)
    Runtime:addEventListener(listener.COLLISION, _collisionFunction)
    Runtime:addEventListener(listener.ENTER_FRAME, _controlScientistJump)
end

return {
    make = _make,
    clear = _clear
}