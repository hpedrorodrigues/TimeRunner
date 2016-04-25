local importations = require(IMPORTATIONS)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)

local collisionDelayTime = 2

local lifeManager
local scoreManager

local function _setLifeManager(lm)
    lifeManager = lm
end

local function _setScoreManager(sm)
    scoreManager = sm
end

local function _control(event)

    if ((event.object1.myName == 'obstacle' and event.object2.myName == 'crazy_scientist')
            or (event.object2.myName == 'obstacle' and event.object1.myName == 'crazy_scientist')) then

        local sprite = (event.object1.myName == 'crazy_scientist') and event.object1 or event.object2
        local spriteObstacle = (event.object1.myName == 'obstacle') and event.object1 or event.object2

        if (sprite.died == false) then
            sprite.died = true
        end

        timer.performWithDelay(200, function()
            transition.to(sprite, { alpha = 1, timer = 250 })
            sprite.x = displayConstants.LEFT_SCREEN + 100
            sprite.died = false
        end)

        system.vibrate()

        lifeManager.setVisibilityFromCurrentLife(false)

        lifeManager.decrease()

        if (not lifeManager.hasLife()) then

            lifeManager.reset()

            timer.performWithDelay(collisionDelayTime, function()

                sceneManager.goGameOver(scoreManager.score())
            end)
        end

        spriteObstacle.isDeleted = true
    end
end

return {
    setLifeManager = _setLifeManager,
    setScoreManager = _setScoreManager,
    control = _control
}