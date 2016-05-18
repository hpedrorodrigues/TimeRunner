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
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local viewUtil = require(importations.VIEW_UTIL)

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

local function _playerJump()
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

local function _createButtons(group)
    local buttonsConfiguration = { size = 100, radius = 200, alpha = .2, difference = 50 }

    local shootLargeButton = viewUtil.createButtonCircle({
        size = buttonsConfiguration.size,
        radius = buttonsConfiguration.radius,
        x = display.contentWidth - buttonsConfiguration.difference,
        y = display.contentHeight - buttonsConfiguration.difference
    })

    local shootButton = viewUtil.createWidgetImage({
        x = shootLargeButton.x,
        y = shootLargeButton.y,
        imagePath = images.ATTACK_BUTTON
    })

    local shootAction = function()
        emitterManager.shoot(sprite)
    end

    viewUtil.addTouchEventWithAlphaEffectListener(shootLargeButton, shootLargeButton, shootAction)
    viewUtil.addTouchEventWithAlphaEffectListener(shootButton, shootLargeButton, shootAction)

    local jumpLargeButton = viewUtil.createButtonCircle({
        size = buttonsConfiguration.size,
        radius = buttonsConfiguration.radius,
        x = displayConstants.TOP_SCREEN + buttonsConfiguration.difference,
        y = display.contentHeight - buttonsConfiguration.difference
    })

    local jumpButton = viewUtil.createWidgetImage({
        x = jumpLargeButton.x,
        y = jumpLargeButton.y,
        imagePath = images.JUMP_BUTTON
    })

    viewUtil.addTouchEventWithAlphaEffectListener(jumpLargeButton, jumpLargeButton, _playerJump)
    viewUtil.addTouchEventWithAlphaEffectListener(jumpButton, jumpLargeButton, _playerJump)

    local changeAlphaTimer = timer.performWithDelay(100, function(event)
        local alpha = .6

        if (event.count % 2 == 0) then
            alpha = buttonsConfiguration.alpha
        end

        shootLargeButton.alpha = alpha
        jumpLargeButton.alpha = alpha
    end, 10)

    timer.performWithDelay(2000, function()
        timer.cancel(changeAlphaTimer)
        shootLargeButton.alpha = buttonsConfiguration.alpha
        jumpLargeButton.alpha = buttonsConfiguration.alpha
    end)

    group:insert(jumpButton)
    group:insert(jumpLargeButton)
    group:insert(shootButton)
    group:insert(shootLargeButton)
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

    _createButtons(group)

    Runtime:addEventListener(listener.COLLISION, collisionManager.control)
end

return {
    apply = _make,
    clear = _clear,
    scoreManager = _scoreManager
}