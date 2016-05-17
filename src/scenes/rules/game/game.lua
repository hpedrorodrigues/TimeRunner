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
    sprite:applyLinearImpulse(0, 0, sprite.x, sprite.y)
    sprite:applyLinearImpulse(0, 120, sprite.x, sprite.y)
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

    sprite.canJump = 0

    physics.start()
    physics.setGravity(0, 9.8)

    physics.addBody(bottomWall, 'static', { density = 1, friction = 0, bounce = 1, filter = filters.bottomWallCollision })
    physics.addBody(sprite, { density = 1, friction = 1, bounce = .2, filter = filters.playerCollision })

    sprite.isFixedRotation = true

    lifeManager.createImages(group)

    spritesManager.setGroup(group)
    spritesManager.create()

    collisionManager.setLifeManager(lifeManager)
    collisionManager.setScoreManager(scoreManager)

    scoreManager.create(group)

    local jumpDifference = 50
    local largeButtonConfiguration = { size = 200, alpha = .2, alphaNormal = .2, alphaClicked = .6 }

    local triggerFireLargeButton = display.newCircle(100, 100, largeButtonConfiguration.size)
    triggerFireLargeButton.x = display.contentWidth - jumpDifference
    triggerFireLargeButton.y = display.contentHeight - jumpDifference
    triggerFireLargeButton:setFillColor(0, 0, 0, 1)

    local function triggerFireTouchListener(event)
        if (event.phase == 'began') then
            triggerFireLargeButton.alpha = largeButtonConfiguration.alphaClicked
        elseif (event.phase == 'ended') then
            triggerFireLargeButton.alpha = largeButtonConfiguration.alphaNormal
            emitterManager.shoot(sprite)
        end
    end

    triggerFireLargeButton:addEventListener(listener.TOUCH, triggerFireTouchListener)

    local triggerFireButton = widget.newButton({
        x = triggerFireLargeButton.x,
        y = triggerFireLargeButton.y,
        defaultFile = images.ATTACK_BUTTON
    })

    triggerFireButton:addEventListener(listener.TOUCH, triggerFireTouchListener)

    local jumpLargeButton = display.newCircle(100, 100, largeButtonConfiguration.size)
    jumpLargeButton.x = display.screenOriginY + jumpDifference
    jumpLargeButton.y = display.contentHeight - jumpDifference
    jumpLargeButton:setFillColor(0, 0, 0, 1)

    local function jumpTouchListener(event)
        if (event.phase == 'began') then
            jumpLargeButton.alpha = largeButtonConfiguration.alphaClicked
        elseif (event.phase == 'ended') then
            jumpLargeButton.alpha = largeButtonConfiguration.alphaNormal
            _playerJump(event)
        end
    end

    jumpLargeButton:addEventListener(listener.TOUCH, jumpTouchListener)

    local jumpButton = widget.newButton({
        x = jumpLargeButton.x,
        y = jumpLargeButton.y,
        defaultFile = images.JUMP_BUTTON
    })

    jumpButton:addEventListener(listener.TOUCH, jumpTouchListener)

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