local importations = require(IMPORTATIONS)
local sceneManager = require(importations.SCENE_MANAGER)
local settings = require(importations.SETTINGS)
local bodyManager = require(importations.BODY_MANAGER)

local lifeManager
local scoreManager
local shootManager

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

local function _setShootManager(sm)
    shootManager = sm
end

local function _isBodies(event, firstBodyName, secondBodyName)
    return (event.object1.myName == firstBodyName and event.object2.myName == secondBodyName)
            or (event.object2.myName == firstBodyName and event.object1.myName == secondBodyName)
end

local function _getBody(event, bodyName)
    return (event.object1.myName == bodyName) and event.object1 or event.object2
end

local function _control(event)
    if (_isBodies(event, bodyManager.NAME.CRAZY_SCIENTIST, bodyManager.NAME.BOTTOM_WALL)) then

        local sprite = _getBody(event, bodyManager.NAME.CRAZY_SCIENTIST)

        sprite.inAir = false

    elseif (_isBodies(event, bodyManager.NAME.CRAZY_SCIENTIST, bodyManager.NAME.POWER_UP)) then

        local powerUp = _getBody(event, bodyManager.NAME.POWER_UP)

        powerUp.isDeleted = true

        shootManager.increase()

    elseif (_isBodies(event, bodyManager.NAME.CRAZY_SCIENTIST, bodyManager.NAME.OBSTACLE)) then

        local sprite = _getBody(event, bodyManager.NAME.CRAZY_SCIENTIST)
        local spriteObstacle = _getBody(event, bodyManager.NAME.OBSTACLE)

        if (sprite.died == false) then
            sprite.died = true
        end

        timer.performWithDelay(200, function()
            transition.to(sprite, { alpha = 1, timer = 250 })
            sprite.died = false
        end)

        if (isVibrationEnabled) then
            system.vibrate()
        end

        lifeManager.setVisibilityFromCurrentLife(false)

        lifeManager.decrease()

        if (not lifeManager.hasLife()) then

            lifeManager.reset()
            sceneManager.goGameOver(scoreManager.currentScore())
        end

        spriteObstacle.isDeleted = true

    elseif (_isBodies(event, bodyManager.NAME.OBSTACLE, bodyManager.NAME.SHOT)) then

        local shot = _getBody(event, bodyManager.NAME.SHOT)
        local obstacle = _getBody(event, bodyManager.NAME.OBSTACLE)

        if (obstacle.animalName == bodyManager.ANIMAL_NAME.TIGER) then

            scoreManager.increaseTigerScore()
        elseif (obstacle.animalName == bodyManager.ANIMAL_NAME.BEAR) then

            scoreManager.increaseBearScore()

        elseif (obstacle.animalName == bodyManager.ANIMAL_NAME.BIRD) then

            scoreManager.increaseBirdScore()
        end

        if (isVibrationEnabled) then
            system.vibrate()
        end

        shot.isDeleted = true
        obstacle.isDeleted = true
    end
end

return {
    setLifeManager = _setLifeManager,
    setScoreManager = _setScoreManager,
    setShootManager = _setShootManager,
    control = _control,
    start = _start
}