local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local sceneManager = require(importations.SCENE_MANAGER)

local collisionThrottle = true
local collisionDelayTime = 2

local lifeManager
local bodyNames

local function _setLifeManager(lm)
    lifeManager = lm
end

local function _setBodyNames(bn)
    bodyNames = bn
end

local function _control(event)

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

            system.vibrate()

            lifeManager.setVisibilityFromCurrentLife(false)

            lifeManager.decrease()

            if (not lifeManager.hasLife()) then

                lifeManager.reset()

                timer.performWithDelay(collisionDelayTime, function()

                    sceneManager.goMenu()
                end)
            end

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

return {
    setLifeManager = _setLifeManager,
    setBodyNames = _setBodyNames,
    control = _control
}