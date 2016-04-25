local importations = require(IMPORTATIONS)
local physics = require(importations.PHYSICS)
local listener = require(importations.LISTENER)
local filters = require(importations.FILTER_RULES)
local spritesManager = require(importations.SPRITES_MANAGER_RULES)
local lifeManager = require(importations.LIFE_MANAGER_RULES)
local collisionManager = require(importations.COLLISION_MANAGER_RULES)
local scoreManager = require(importations.SCORE_MANAGER_RULES)

local sprite
local jumpVelocity = 500

local function _scoreManager()
    return scoreManager
end

local function _controlScientistJump()
    if (sprite ~= nil) then

        sprite.angularVelocity = 0
        sprite.isFixedRotation = true

        if (sprite.y < 450) then
            sprite:setLinearVelocity(0, 0)
            sprite:setLinearVelocity(0, jumpVelocity)
        end
    end
end

local function _clear()

    spritesManager.cancel()
    scoreManager.destroy()

    Runtime:removeEventListener(listener.ENTER_FRAME, _controlScientistJump)
    Runtime:removeEventListener(listener.COLLISION, collisionManager.control)

    if (sprite ~= nil) then

        physics.removeBody(sprite)
        sprite:removeSelf()
        sprite = nil
    end

    physics.stop()
end

local function _make(sp, background, group)
    lifeManager.reset()

    local bottomWall = display.newRect(display.contentWidth / 2, display.contentHeight, display.contentWidth, 0)

    sprite = sp

    physics.start()
    physics.setGravity(0, 9.8)
    physics.setDrawMode('hybrid')

    physics.addBody(bottomWall, 'static', { density = 1, friction = 0, bounce = 1, filter = filters.bottomWallCollision })
    physics.addBody(sprite, { density = 1, friction = 1, bounce = .2, filter = filters.playerCollision })

    lifeManager.createImages(group)

    background:addEventListener(listener.TOUCH, function()
        sprite:setLinearVelocity(0, 0)
        sprite:setLinearVelocity(0, jumpVelocity)
    end)

    spritesManager.setGroup(group)
    spritesManager.create()

    collisionManager.setLifeManager(lifeManager)

    scoreManager.create(group)

    Runtime:addEventListener(listener.COLLISION, collisionManager.control)
    Runtime:addEventListener(listener.ENTER_FRAME, _controlScientistJump)
end

return {
    make = _make,
    clear = _clear,
    scoreManager = _scoreManager
}