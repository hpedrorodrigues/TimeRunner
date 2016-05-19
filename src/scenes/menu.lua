local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local sceneManager = require(importations.SCENE_MANAGER)
local viewUtil = require(importations.VIEW_UTIL)

local scene = composer.newScene()

function scene:create()
    local sceneGroup = self.view

    local background = viewUtil.createBackground(images.MENU_BACKGROUND, 1800, 900)

    local playButton = viewUtil.createMenuButton({
        imagePath = images.PLAY_BUTTON,
        x = displayConstants.CENTER_X,
        y = displayConstants.CENTER_Y + 20,
        action = sceneManager.goGame
    })

    local preferencesButton = viewUtil.createMenuButton({
        imagePath = images.PREFERENCES_BUTTON,
        x = playButton.x,
        y = playButton.y + viewUtil.distanceBetweenMenuButtons,
        action = sceneManager.goPreferences
    })

    local aboutButton = viewUtil.createMenuButton({
        imagePath = images.ABOUT_BUTTON,
        x = preferencesButton.x,
        y = preferencesButton.y + viewUtil.distanceBetweenMenuButtons,
        action = sceneManager.goAbout
    })

    viewUtil.addEndedTouchEventListener(background, function()
        playButton.alpha = viewUtil.alphaDefault
        preferencesButton.alpha = viewUtil.alphaDefault
        aboutButton.alpha = viewUtil.alphaDefault
    end)

    local gameTitle = viewUtil.createImage({
        imagePath = images.TITLE,
        width = 783,
        height = 183,
        x = displayConstants.CENTER_X,
        y = displayConstants.CENTER_Y - 250
    })

    sceneGroup:insert(background)
    sceneGroup:insert(preferencesButton)
    sceneGroup:insert(aboutButton)
    sceneGroup:insert(playButton)
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