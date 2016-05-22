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
local bodyManager = require(importations.BODY_MANAGER)
local shootManager = require(importations.SHOOT_MANAGER_RULES)

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

local function _clear()
    spritesManager.cancel()
    emitterManager.cancel()

    Runtime:removeEventListener(listener.COLLISION, collisionManager.control)

    if (sprite ~= nil) then

        physics.removeBody(sprite)
        sprite:removeSelf()
        sprite = nil
    end

    physics.stop()
end

local function _createButtons(group, background)
    local buttonsConfiguration = { size = 100, radius = 200, alpha = .2, difference = 50 }

    local shootLargeButton = viewUtil.createButtonCircle({
        size = buttonsConfiguration.size,
        radius = buttonsConfiguration.radius,
        x = displayConstants.WIDTH_SCREEN - buttonsConfiguration.difference,
        y = displayConstants.HEIGHT_SCREEN - buttonsConfiguration.difference
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
        y = displayConstants.HEIGHT_SCREEN - buttonsConfiguration.difference
    })

    local jumpButton = viewUtil.createWidgetImage({
        x = jumpLargeButton.x,
        y = jumpLargeButton.y,
        imagePath = images.JUMP_BUTTON
    })

    local function playerJump(event)
        if (sprite.inAir == false) then
            sprite.inAir = true
            sprite:setLinearVelocity(0, -350)
        end
    end

    viewUtil.addTouchEventWithAlphaEffectListener(jumpLargeButton, jumpLargeButton, playerJump)
    viewUtil.addTouchEventWithAlphaEffectListener(jumpButton, jumpLargeButton, playerJump)

    viewUtil.addEndedTouchEventListener(background, function()
        shootLargeButton.alpha = buttonsConfiguration.alpha
        jumpLargeButton.alpha = buttonsConfiguration.alpha
    end)

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

local function _apply(group, background, sp)
    sprite = sp

    lifeManager.reset()
    emitterManager.start()

    _displayPortal(sprite)

    local bottomWallInfo = {
        x = displayConstants.WIDTH_SCREEN / 2,
        y = displayConstants.HEIGHT_SCREEN - 20,
        width = displayConstants.WIDTH_SCREEN,
        height = 0
    }

    local bottomWall = display.newRect(bottomWallInfo.x, bottomWallInfo.y, bottomWallInfo.width, bottomWallInfo.height)
    bottomWall.myName = bodyManager.NAME.BOTTOM_WALL

    local leftWallInfo = {
        x = displayConstants.LEFT_SCREEN + 120,
        y = displayConstants.CENTER_Y,
        width = 0,
        height = displayConstants.HEIGHT_SCREEN
    }

    local leftWall = display.newRect(leftWallInfo.x, leftWallInfo.y, leftWallInfo.width, leftWallInfo.height)
    leftWall.myName = bodyManager.NAME.LEFT_WALL

    physics.start()
    physics.setGravity(0, 9.8)
    --    physics.setDrawMode('hybrid')

    physics.addBody(bottomWall, 'static', { friction = 0.5, bounce = 0.3, filter = filters.bottomWallCollision })
    physics.addBody(leftWall, 'static', { friction = 0.5, bounce = 0.3, filter = filters.leftWallCollision })
    physics.addBody(sprite, 'dynamic', { density = 50, friction = 0.3, bounce = 0, filter = filters.playerCollision })

    sprite.isFixedRotation = true
    sprite.inAir = true

    shootManager.start()
    shootManager.createProgressView(group)

    lifeManager.createImages(group)

    spritesManager.setGroup(group)
    spritesManager.create()

    collisionManager.start()
    collisionManager.setLifeManager(lifeManager)
    collisionManager.setScoreManager(scoreManager)
    collisionManager.setShootManager(shootManager)

    emitterManager.setShootManager(shootManager)

    scoreManager.createScoreView(group)
    scoreManager.start()

    _createButtons(group, background)

    Runtime:addEventListener(listener.COLLISION, collisionManager.control)
end

return {
    apply = _apply,
    clear = _clear,
    scoreManager = _scoreManager
}