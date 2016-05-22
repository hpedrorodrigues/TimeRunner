local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local viewUtil = require(importations.VIEW_UTIL)
local i18n = require(importations.I18N)
local adsManager = require(importations.ADS_MANAGER)

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local background = viewUtil.createBackground(images.GAME_OVER_BACKGROUND, 1440, 790)
    local backButton = viewUtil.createBackButton(background, sceneManager.goMenu)

    local gameOverTitle = viewUtil.createImage({
        imagePath = images.GAME_OVER_BUTTON,
        width = 680,
        height = 168,
        x = displayConstants.CENTER_X,
        y = displayConstants.LEFT_SCREEN + 200
    })

    local scoreText = viewUtil.createText({
        text = i18n.score .. ': ' .. event.params.score,
        x = gameOverTitle.x,
        y = gameOverTitle.y + 135,
        fontSize = 80
    })
    scoreText:setFillColor(248, 248, 255)

    local playView = viewUtil.createMenuItem({
        text = i18n.playTitle,
        x = displayConstants.CENTER_X,
        y = scoreText.y + 180,
        action = sceneManager.goGame
    })

    local menuView = viewUtil.createMenuItem({
        text = i18n.menuTitle,
        x = playView.button.x,
        y = playView.button.y + viewUtil.distanceBetweenMenuButtons,
        action = sceneManager.goMenu
    })

    adsManager.set(adsManager.SUPPORTED_SCREENS.GAME_OVER)
    adsManager.start()

    sceneGroup:insert(background)
    sceneGroup:insert(gameOverTitle)
    sceneGroup:insert(playView.button)
    sceneGroup:insert(playView.text)
    sceneGroup:insert(menuView.button)
    sceneGroup:insert(menuView.text)
    sceneGroup:insert(backButton)
    sceneGroup:insert(scoreText)

    eventUtil.setBackPressed(sceneManager.goMenu)
end

function scene:destroy()
    adsManager.hide()

    local sceneGroup = self.view

    sceneGroup:removeSelf()
    sceneGroup = nil

    -- Doing it because is needed but linter not known Corona SDK
    if (sceneGroup ~= nil) then
        print(sceneGroup)
    end
end

scene:addEventListener(listener.CREATE, scene)
scene:addEventListener(listener.DESTROY, scene)

return scene