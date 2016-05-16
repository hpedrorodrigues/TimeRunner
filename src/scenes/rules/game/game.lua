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

local function _displayPortal(sp)
    local emitter = emitterManager.newPortal()
    emitter.x = sp.x
    emitter.y = sp.y

    timer.performWithDelay(2000, function()
        emitter:stop()
    end)
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

    _displayPortal(sprite)

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

    local jumpDifference = 50

    local triggerFireLargeButton = display.newCircle(100, 100, 170)
    triggerFireLargeButton.x = display.contentWidth - jumpDifference
    triggerFireLargeButton.y = display.contentHeight - jumpDifference
    triggerFireLargeButton:setFillColor(0, 0, 0, .2)

    triggerFireLargeButton:addEventListener(listener.TOUCH, function()
        emitterManager.shoot(sprite)
    end)

    local triggerFireButton = widget.newButton({
        x = triggerFireLargeButton.x,
        y = triggerFireLargeButton.y,
        defaultFile = images.ATTACK_BUTTON
    })

    local jumpLargeButton = display.newCircle(100, 100, 170)
    jumpLargeButton.x = display.screenOriginY + jumpDifference
    jumpLargeButton.y = display.contentHeight - jumpDifference
    jumpLargeButton:setFillColor(0, 0, 0, .2)

    jumpLargeButton:addEventListener(listener.TOUCH, _playerJump)

    local jumpButton = widget.newButton({
        x = jumpLargeButton.x,
        y = jumpLargeButton.y,
        defaultFile = images.JUMP_BUTTON
    })

    group:insert(jumpButton)
    group:insert(jumpLargeButton)
    group:insert(triggerFireButton)
    group:insert(triggerFireLargeButton)

    Runtime:addEventListener(listener.COLLISION, collisionManager.control)
end

return {
    apply = _make,
    clear = _clear,
    scoreManager = _scoreManager
}