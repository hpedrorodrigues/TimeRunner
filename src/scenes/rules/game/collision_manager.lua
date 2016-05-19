local importations = require(IMPORTATIONS)
local sceneManager = require(importations.SCENE_MANAGER)
local settings = require(importations.SETTINGS)
local bodyNames = require(importations.BODY_NAMES)

local collisionDelayTime = 2

local lifeManager
local scoreManager
local bottomWallvsPlayerAction

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

local function _setBottomWallvsPlayerAction(action)
    bottomWallvsPlayerAction = action
end

local function _isBodies(event, firstBodyName, secondBodyName)
    return (event.object1.myName == firstBodyName and event.object2.myName == secondBodyName)
            or (event.object2.myName == firstBodyName and event.object1.myName == secondBodyName)
end

local function _getBody(event, bodyName)
    return (event.object1.myName == bodyName) and event.object1 or event.object2
end

local function _control(event)
    if (_isBodies(event, bodyNames.CRAZY_SCIENTIST, bodyNames.BOTTOM_WALL)) then

        local sprite = _getBody(event, bodyNames.CRAZY_SCIENTIST)

        sprite.inAir = false

    elseif (_isBodies(event, bodyNames.CRAZY_SCIENTIST, bodyNames.POWER_UP)) then

        local powerUp = _getBody(event, bodyNames.POWER_UP)

        powerUp.isDeleted = true

    elseif (_isBodies(event, bodyNames.CRAZY_SCIENTIST, bodyNames.OBSTACLE)) then

        local sprite = _getBody(event, bodyNames.CRAZY_SCIENTIST)
        local spriteObstacle = _getBody(event, bodyNames.OBSTACLE)

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

            timer.performWithDelay(collisionDelayTime, function()

                sceneManager.goGameOver(scoreManager.score())
            end)
        end

        spriteObstacle.isDeleted = true

    elseif (_isBodies(event, bodyNames.OBSTACLE, bodyNames.SHOT)) then

        local shot = _getBody(event, bodyNames.SHOT)
        local obstacle = _getBody(event, bodyNames.OBSTACLE)

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
    control = _control,
    start = _start,
    setBottomWallvsPlayerAction = _setBottomWallvsPlayerAction
}