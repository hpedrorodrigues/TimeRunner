local importations = require(IMPORTATIONS)
local physics = require(importations.PHYSICS)
local listener = require(importations.LISTENER)
local filters = require(importations.FILTER_RULES)
local spritesManager = require(importations.SPRITES_MANAGER_RULES)
local lifeManager = require(importations.LIFE_MANAGER_RULES)
local collisionManager = require(importations.COLLISION_MANAGER_RULES)
local scoreManager = require(importations.SCORE_MANAGER_RULES)
local emitterManager = require(importations.EMITTER_MANAGER)
local images = require(importations.IMAGES)
local widget = require(importations.WIDGET)

local sprite
local throttleJump

local function _scoreManager()
    return scoreManager
end

local function _playerJump(event)
    if (throttleJump == nil or throttleJump == false) then
        throttleJump = true

        timer.performWithDelay(1000, function()
            throttleJump = false
        end)

        if (event.phase == 'began' and sprite.canJump == 0) then
            sprite.canJump = 1

            sprite:jump()

            timer.performWithDelay(500, function()
                if (sprite ~= nil) then
                    sprite.canJump = 0
                end
            end)
        end
    end
end

local function _clear()

    spritesManager.cancel()
    scoreManager.destroy()
    emitterManager.cancel()

    Runtime:removeEventListener(listener.COLLISION, collisionManager.control)

    if (sprite ~= nil) then

        physics.removeBody(sprite)
        sprite:removeSelf()
        sprite = nil
    end

    physics.stop()
end

local function _make(group, sp)
    sprite = sp

    lifeManager.reset()
    emitterManager.start()

    local bottomWall = display.newRect(display.contentWidth / 2, display.contentHeight, display.contentWidth, 0)

    sprite.angularVelocity = 0
    sprite.isFixedRotation = true

    sprite.canJump = 0

    physics.start()
    physics.setGravity(0, 9.8)
    --    physics.setDrawMode('hybrid')

    physics.addBody(bottomWall, 'static', { density = 1, friction = 0, bounce = 1, filter = filters.bottomWallCollision })
    physics.addBody(sprite, { density = 1, friction = 1, bounce = .2, filter = filters.playerCollision })

    lifeManager.createImages(group)

    spritesManager.setGroup(group)
    spritesManager.create()

    collisionManager.setLifeManager(lifeManager)
    collisionManager.setScoreManager(scoreManager)

    scoreManager.create(group)

    function sprite:jump()
        self:setLinearVelocity(0, 200)
    end

    local triggerFireButton = widget.newButton({
        x = display.contentWidth - 30,
        y = display.contentHeight - 30,
        defaultFile = images.ABOUT_BUTTON,
        onPress = function()
            emitterManager.shoot(sprite)
        end
    })

    local jumpButton = widget.newButton({
        x = display.screenOriginY + 30,
        y = display.contentHeight - 30,
        defaultFile = images.ABOUT_BUTTON,
        onPress = _playerJump
    })

    group:insert(jumpButton)
    group:insert(triggerFireButton)

    Runtime:addEventListener(listener.COLLISION, collisionManager.control)
end

return {
    apply = _make,
    clear = _clear,
    scoreManager = _scoreManager
}