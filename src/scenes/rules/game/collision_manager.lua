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

        local crazyScientist = _getBody(event, bodyManager.NAME.CRAZY_SCIENTIST)

        crazyScientist.inAir = false

    elseif (_isBodies(event, bodyManager.NAME.CRAZY_SCIENTIST, bodyManager.NAME.POWER_UP)) then

        local powerUp = _getBody(event, bodyManager.NAME.POWER_UP)

        powerUp.isDeleted = true

        shootManager.increase()

    elseif (_isBodies(event, bodyManager.NAME.CRAZY_SCIENTIST, bodyManager.NAME.OBSTACLE)) then

        local crazyScientist = _getBody(event, bodyManager.NAME.CRAZY_SCIENTIST)
        local enemy = _getBody(event, bodyManager.NAME.OBSTACLE)

        if (crazyScientist.died == false) then
            crazyScientist.died = true
        end

        timer.performWithDelay(200, function()
            transition.to(crazyScientist, { alpha = 1, timer = 250 })
            crazyScientist.died = false
        end)

        if (isVibrationEnabled) then
            system.vibrate()
        end

        lifeManager.setVisibilityFromCurrentLife(false)

        lifeManager.decrease()

        if (not lifeManager.hasLife()) then

            timer.performWithDelay(200, function()
                lifeManager.reset()
                sceneManager.goGameOver(scoreManager.currentScore())
            end)
        end

        enemy.isDeleted = true

    elseif (_isBodies(event, bodyManager.NAME.OBSTACLE, bodyManager.NAME.SHOT)) then

        local shot = _getBody(event, bodyManager.NAME.SHOT)
        local enemy = _getBody(event, bodyManager.NAME.OBSTACLE)

        scoreManager.increaseByAnimalName(enemy.animalName)

        shot.isDeleted = true
        enemy.isDeleted = true
    end
end

return {
    setLifeManager = _setLifeManager,
    setScoreManager = _setScoreManager,
    setShootManager = _setShootManager,
    control = _control,
    start = _start
}