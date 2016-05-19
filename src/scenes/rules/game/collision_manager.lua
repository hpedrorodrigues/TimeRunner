local importations = require(IMPORTATIONS)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local settings = require(importations.SETTINGS)
local bodyNames = require(importations.BODY_NAMES)

local collisionDelayTime = 2

local lifeManager
local scoreManager

local isVibrationEnabled

local function _start()
    isVibrationEnabled = settings.isVibrationEnabled()
end

local function _setLifeManager(lm)
    lifeManager = lm
end

local function _setScoreManager(sm)
    scoreManager = sm
end

local function _control(event)
    if ((event.object1.myName == bodyNames.CRAZY_SCIENTIST and event.object2.myName == bodyNames.POWER_UP)
            or (event.object2.myName == bodyNames.CRAZY_SCIENTIST and event.object1.myName == bodyNames.POWER_UP)) then

        local powerUp = (event.object1.myName == bodyNames.POWER_UP) and event.object1 or event.object2

        powerUp.isDeleted = true

    elseif ((event.object1.myName == bodyNames.OBSTACLE and event.object2.myName == bodyNames.SHOT)
            or (event.object2.myName == bodyNames.OBSTACLE and event.object1.myName == bodyNames.SHOT)) then

        local shot = (event.object1.myName == bodyNames.SHOT) and event.object1 or event.object2
        local obstacle = (event.object1.myName == bodyNames.OBSTACLE) and event.object1 or event.object2

        if (isVibrationEnabled) then
            system.vibrate()
        end

        shot.isDeleted = true
        obstacle.isDeleted = true

    elseif ((event.object1.myName == bodyNames.OBSTACLE and event.object2.myName == bodyNames.CRAZY_SCIENTIST)
            or (event.object2.myName == bodyNames.OBSTACLE and event.object1.myName == bodyNames.CRAZY_SCIENTIST)) then

        local sprite = (event.object1.myName == bodyNames.CRAZY_SCIENTIST) and event.object1 or event.object2
        local spriteObstacle = (event.object1.myName == bodyNames.OBSTACLE) and event.object1 or event.object2

        if (sprite.died == false) then
            sprite.died = true
        end

        timer.performWithDelay(200, function()
            transition.to(sprite, { alpha = 1, timer = 250 })
            sprite.x = displayConstants.LEFT_SCREEN + 150
            sprite.died = false
        end)

        if (isVibrationEnabled) then
            system.vibrate()
        end

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
    control = _control,
    start = _start
}