local importations = require(IMPORTATIONS)
local bearSpriteManager = require(importations.BEAR_SPRITE)
local tigerSpriteManager = require(importations.TIGER_SPRITE)
local physics = require(importations.PHYSICS)
local listener = require(importations.LISTENER)
local filters = require(importations.FILTER_RULES)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local bodyNames = require(importations.BODY_NAMES)

local sprites = {}
local spritesQuantity = 0
local delay = 800
local group = {}
local spritesTimer
local translateVelocity = -18

local buttonsDifference = 130

local function _setGroup(gp)
    group = gp
end

local function _createBearSprite()
    return bearSpriteManager.create()
end

local function _createTigerSprite()
    return tigerSpriteManager.create()
end

local function _createRandomSprites()
    local randomNumber = math.random(1, 3)

    if (randomNumber == 1 or randomNumber == 2) then
        spritesQuantity = spritesQuantity + 1

        if (randomNumber == 1) then
            sprites[spritesQuantity] = _createBearSprite()
            sprites[spritesQuantity].animalName = bodyNames.BEAR_ANIMAL
            sprites[spritesQuantity].x = displayConstants.WIDTH_SCREEN - buttonsDifference
            sprites[spritesQuantity].y = displayConstants.HEIGHT_SCREEN - 70
        elseif (randomNumber == 2) then
            sprites[spritesQuantity] = _createTigerSprite()
            sprites[spritesQuantity].animalName = bodyNames.TIGER_ANIMAL
            sprites[spritesQuantity].x = displayConstants.WIDTH_SCREEN - buttonsDifference
            sprites[spritesQuantity].y = displayConstants.HEIGHT_SCREEN - 55
        end

        local sprite = sprites[spritesQuantity]

        sprite.myName = bodyNames.OBSTACLE
        sprite:play()

        physics.addBody(sprite, { friction = 0.5, bounce = 0, filter = filters.earthObstacleCollision })

        sprite:translate(translateVelocity, 0)
    end
end

local function _spriteUpdate()
    for i = 1, spritesQuantity do

        local currentPosition = i
        local child = sprites[currentPosition]

        if (child ~= nil) then

            child:translate(translateVelocity, 0)

            if (child.x <= (displayConstants.TOP_SCREEN + buttonsDifference) or child.isDeleted) then

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
    timer.cancel(spritesTimer)
    Runtime:removeEventListener(listener.ENTER_FRAME, _spriteUpdate)

    _removeAllSprites()
end

return {
    create = _create,
    setGroup = _setGroup,
    cancel = _cancel
}