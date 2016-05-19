local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local sceneManager = require(importations.SCENE_MANAGER)
local viewUtil = require(importations.VIEW_UTIL)
local i18n = require(importations.I18N)

local scene = composer.newScene()

function scene:create()
    local sceneGroup = self.view

    local background = viewUtil.createBackground(images.MENU_BACKGROUND, 1800, 900)

    local playView = viewUtil.createMenuItem({
        text = i18n.playTitle,
        x = displayConstants.CENTER_X,
        y = displayConstants.CENTER_Y + 20,
        action = sceneManager.goGame
    })

    local preferencesView = viewUtil.createMenuItem({
        text = i18n.preferencesTitle,
        x = playView.button.x,
        y = playView.button.y + viewUtil.distanceBetweenMenuButtons,
        action = sceneManager.goPreferences
    })

    local aboutView = viewUtil.createMenuItem({
        text = i18n.aboutTitle,
        x = preferencesView.button.x,
        y = preferencesView.button.y + viewUtil.distanceBetweenMenuButtons,
        action = sceneManager.goAbout
    })

    viewUtil.addEndedTouchEventListener(background, function()
        playView.button.alpha = viewUtil.alphaDefault
        preferencesView.button.alpha = viewUtil.alphaDefault
        aboutView.button.alpha = viewUtil.alphaDefault
    end)

    local gameTitle = viewUtil.createImage({
        imagePath = images.TITLE,
        width = 783,
        height = 183,
        x = displayConstants.CENTER_X,
        y = displayConstants.CENTER_Y - 250
    })

    sceneGroup:insert(background)
    sceneGroup:insert(preferencesView.button)
    sceneGroup:insert(preferencesView.text)
    sceneGroup:insert(aboutView.button)
    sceneGroup:insert(aboutView.text)
    sceneGroup:insert(playView.button)
    sceneGroup:insert(playView.text)
    sceneGroup:insert(gameTitle)
end

function scene:destroy()
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