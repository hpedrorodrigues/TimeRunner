local importations = require(IMPORTATIONS)
local physics = require(importations.PHYSICS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local swipeUtil = require(importations.SWIPE_UTIL)
local listener = require(importations.LISTENER)
local filters = require(importations.FILTER_RULES)
local spritesManager = require(importations.SPRITES_MANAGER_RULES)
local lifeManager = require(importations.LIFE_MANAGER_RULES)
local collisionManager = require(importations.COLLISION_MANAGER_RULES)

local earthObstacle
local airObstacle

local sprite

local bodyNames = {
    sprite = 'sprite',
    airObstacle = 'airObstacle',
    earthObstacle = 'earthObstacle'
}

local defaultObstacleX = displayConstants.WIDTH_SCREEN + 75

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
                    earthObstacle = spritesManager.createBearSprite()
                elseif (randomNumber == 2) then
                    earthObstacle = spritesManager.createTigerSprite()
                else
                    earthObstacle = spritesManager.createTigerSprite()
                end

                earthObstacle:play()

                physics.addBody(earthObstacle, 'dynamic', { density = 1, friction = 1, bounce = .2, filter = filters.earthObstacleCollision })
            end
        else

            earthObstacle:setLinearVelocity(-500, 0)
        end
    end
end

local function _clear()

    Runtime:removeEventListener(listener.ENTER_FRAME, _translationObstacle)
    Runtime:removeEventListener(listener.COLLISION, collisionManager.control)

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

local function _make(sp, background, group)
    lifeManager.reset()

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
    earthObstacle = spritesManager.createBearSprite()
    earthObstacle.x = defaultObstacleX
    earthObstacle.y = displayConstants.HEIGHT_SCREEN - 50
    earthObstacle:play()

    physics.addBody(bottomWall, 'static', { density = 1, friction = 0, bounce = 1, filter = filters.bottomWallCollision })
    physics.addBody(airObstacle, 'dynamic', { density = 1, friction = 1, bounce = .2, filter = filters.airObstacleCollision })
    physics.addBody(earthObstacle, 'dynamic', { density = 1, friction = 1, bounce = .2, filter = filters.earthObstacleCollision })
    physics.addBody(sprite, 'dynamic', { density = 1, friction = 1, bounce = .2, filter = filters.playerCollision })

    lifeManager.createImages(group)

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

    collisionManager.setLifeManager(lifeManager)
    collisionManager.setBodyNames(bodyNames)

    Runtime:addEventListener(listener.ENTER_FRAME, _translationObstacle)
    Runtime:addEventListener(listener.COLLISION, collisionManager.control)
end

return {
    make = _make,
    clear = _clear
}