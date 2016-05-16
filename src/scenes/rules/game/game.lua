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
    emitter.y = sp.y + 50

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
    local largeButtonConfiguration = { size = 200, alpha = .2 }

    local triggerFireLargeButton = display.newCircle(100, 100, largeButtonConfiguration.size)
    triggerFireLargeButton.x = display.contentWidth - jumpDifference
    triggerFireLargeButton.y = display.contentHeight - jumpDifference
    triggerFireLargeButton:setFillColor(0, 0, 0, 1)

    triggerFireLargeButton:addEventListener(listener.TOUCH, function(event)
        if (event.phase == 'began') then
            emitterManager.shoot(sprite)
        end
    end)

    local triggerFireButton = widget.newButton({
        x = triggerFireLargeButton.x,
        y = triggerFireLargeButton.y,
        defaultFile = images.ATTACK_BUTTON
    })

    local jumpLargeButton = display.newCircle(100, 100, largeButtonConfiguration.size)
    jumpLargeButton.x = display.screenOriginY + jumpDifference
    jumpLargeButton.y = display.contentHeight - jumpDifference
    jumpLargeButton:setFillColor(0, 0, 0, 1)

    jumpLargeButton:addEventListener(listener.TOUCH, _playerJump)

    local jumpButton = widget.newButton({
        x = jumpLargeButton.x,
        y = jumpLargeButton.y,
        defaultFile = images.JUMP_BUTTON
    })

    local changeAlphaTimer = timer.performWithDelay(100, function(event)
        local alpha = .6

        if (event.count % 2 == 0) then
            alpha = largeButtonConfiguration.alpha
        end

        triggerFireLargeButton.alpha = alpha
        jumpLargeButton.alpha = alpha
    end, 10)

    timer.performWithDelay(2000, function()
        timer.cancel(changeAlphaTimer)
        triggerFireLargeButton.alpha = largeButtonConfiguration.alpha
        jumpLargeButton.alpha = largeButtonConfiguration.alpha
    end)

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