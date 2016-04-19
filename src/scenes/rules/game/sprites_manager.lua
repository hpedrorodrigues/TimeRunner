local importations = require(IMPORTATIONS)
local bearSpriteManager = require(importations.BEAR_SPRITE)
local tigerSpriteManager = require(importations.TIGER_SPRITE)
local physics = require(importations.PHYSICS)
local listener = require(importations.LISTENER)
local filters = require(importations.FILTER_RULES)

local sprites = {}
local spritesQuantity = 0
local delay = 1200
local group = {}
local spritesTimer

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
    if (math.random(1, 2) == 1) then
        sprites[spritesQuantity] = _createBearSprite()
    else
        sprites[spritesQuantity] = _createTigerSprite()
    end

    local sprite = sprites[spritesQuantity]
    sprite.myName = 'obstacle'
    sprite:play()

    physics.addBody(sprite, { density = 1, friction = 0.4, bounce = 1, filter = filters.earthObstacleCollision })

    sprite:setLinearVelocity(200, 0)

    spritesQuantity = spritesQuantity + 1
end

local function _spriteUpdate()

    for i = 1, spritesQuantity do

        local child = sprites[i]

        if (child ~= nil) then

            child:translate(-12, 0)

            if (child.x <= -20 or child.isDeleted) then

                physics.removeBody(child)
                group:remove(child)
                child:removeSelf()
                child = nil
                sprites[i] = nil

                spritesQuantity = spritesQuantity - 1
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