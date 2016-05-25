local importations = require(IMPORTATIONS)
local bearSpriteManager = require(importations.BEAR_SPRITE)
local birdSpriteManager = require(importations.BIRD_SPRITE)
local eagleSpriteManager = require(importations.EAGLE_SPRITE)
local tigerSpriteManager = require(importations.TIGER_SPRITE)
local physics = require(importations.PHYSICS)
local listener = require(importations.LISTENER)
local filters = require(importations.FILTER_RULES)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local bodyManager = require(importations.BODY_MANAGER)
local crazyScientistSpriteManager = require(importations.CRAZY_SCIENTIST_SPRITE)
local spriteSize = require(importations.SPRITE_SIZE)
local settings = require(importations.SETTINGS)

local sprites = {}
local spritesQuantity = 0
local delay = 800
local group = {}
local spritesTimer
local translateVelocity = -18

local function _setGroup(gp)
    group = gp
end

local function _largeSpritesValue()
    return settings.isLargeSpritesEnabled() and spriteSize.LARGE or spriteSize.SMALL
end

local function _createCrazyScientist()
    return crazyScientistSpriteManager.create(_largeSpritesValue())
end

local function _createBearSprite()
    return bearSpriteManager.create(_largeSpritesValue())
end

local function _createBirdSprite()
    return birdSpriteManager.create(_largeSpritesValue())
end

local function _createEagleSprite()
    return eagleSpriteManager.create(_largeSpritesValue())
end

local function _createTigerSprite()
    return tigerSpriteManager.create(_largeSpritesValue())
end

local function _createRandomSprites()
    local max = 5
    local randomNumber = math.random(1, max)

    if (randomNumber < max) then
        spritesQuantity = spritesQuantity + 1

        if (randomNumber == 1) then

            sprites[spritesQuantity] = _createBearSprite()
            sprites[spritesQuantity].animalName = bodyManager.ANIMAL_NAME.BEAR
            sprites[spritesQuantity].x = displayConstants.WIDTH_SCREEN
            sprites[spritesQuantity].y = displayConstants.HEIGHT_SCREEN - 70
            sprites[spritesQuantity].type = bodyManager.TYPE.EARTH
        elseif (randomNumber == 2) then

            sprites[spritesQuantity] = _createTigerSprite()
            sprites[spritesQuantity].animalName = bodyManager.ANIMAL_NAME.TIGER
            sprites[spritesQuantity].x = displayConstants.WIDTH_SCREEN
            sprites[spritesQuantity].y = displayConstants.HEIGHT_SCREEN - 80
            sprites[spritesQuantity].type = bodyManager.TYPE.EARTH
        elseif (randomNumber == 3) then

            sprites[spritesQuantity] = _createBirdSprite()
            sprites[spritesQuantity].animalName = bodyManager.ANIMAL_NAME.BIRD
            sprites[spritesQuantity].x = displayConstants.WIDTH_SCREEN
            sprites[spritesQuantity].y = math.random(displayConstants.TOP_SCREEN + 200, displayConstants.HEIGHT_SCREEN - 300)
            sprites[spritesQuantity].initialY = sprites[spritesQuantity].y
            sprites[spritesQuantity].type = bodyManager.TYPE.AIR

        elseif (randomNumber == 4) then

            sprites[spritesQuantity] = _createEagleSprite()
            sprites[spritesQuantity].animalName = bodyManager.ANIMAL_NAME.EAGLE
            sprites[spritesQuantity].x = displayConstants.WIDTH_SCREEN
            sprites[spritesQuantity].y = math.random(displayConstants.TOP_SCREEN + 200, displayConstants.HEIGHT_SCREEN - 300)
            sprites[spritesQuantity].initialY = sprites[spritesQuantity].y
            sprites[spritesQuantity].type = bodyManager.TYPE.AIR
        end

        local sprite = sprites[spritesQuantity]

        sprite.myName = bodyManager.NAME.OBSTACLE
        sprite:play()

        local filter

        if (sprite.type == bodyManager.TYPE.AIR) then
            filter = filters.airObstacleCollision
        else
            filter = filters.earthObstacleCollision
        end

        physics.addBody(sprite, { friction = 0.5, bounce = 0, filter = filter })

        sprite:translate(translateVelocity, 0)
    end
end

local function _spriteUpdate()
    for i = 1, spritesQuantity do

        local currentPosition = i
        local child = sprites[currentPosition]

        if (child ~= nil) then

            child:translate(translateVelocity, 0)

            if (child.animalName == bodyManager.ANIMAL_NAME.TIGER) then

                child.y = displayConstants.HEIGHT_SCREEN - 80
            elseif (child.type == bodyManager.TYPE.AIR) then

                child.y = child.initialY
            end

            if (child.x <= displayConstants.LEFT_SCREEN or child.isDeleted) then

                physics.removeBody(child)
                group:remove(child)
                child:removeSelf()
                child = nil
                sprites[i] = nil

                -- Doing it because is needed but linter not known Corona SDK
                if (child ~= nil) then
                    print(child)
                end
            end
        end
    end
end

local function _removeAllSprites()
    for i = 1, spritesQuantity do

        local child = sprites[i]

        if (child ~= nil) then

            physics.removeBody(child)
            group:remove(child)
            child:removeSelf()
            child = nil
            sprites[i] = nil

            -- Doing it because is needed but linter not known Corona SDK
            if (child ~= nil) then
                print(child)
            end
        end
    end

    spritesQuantity = 0
    sprites = {}
end

local function _create()
    spritesTimer = timer.performWithDelay(delay, _createRandomSprites, 0)
    Runtime:addEventListener(listener.ENTER_FRAME, _spriteUpdate)
end

local function _cancel()
    if (spritesTimer ~= nil) then
        timer.cancel(spritesTimer)
    end

    Runtime:removeEventListener(listener.ENTER_FRAME, _spriteUpdate)

    _removeAllSprites()
end

return {
    create = _create,
    setGroup = _setGroup,
    cancel = _cancel,
    createCrazyScientist = _createCrazyScientist
}