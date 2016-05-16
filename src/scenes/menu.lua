local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local sceneManager = require(importations.SCENE_MANAGER)

local scene = composer.newScene()

function scene:create(event)

    local sceneGroup = self.view
    local background = display.newImageRect(images.MENU_BACKGROUND, 1800, 900)
    background.x = displayConstants.CENTER_X
    background.y = displayConstants.CENTER_Y

    local distance = { y = 130 }
    local buttons = { width = 411, height = 102 }

    local playButton = display.newImageRect(images.PLAY_BUTTON, buttons.width, buttons.height)
    playButton.x = displayConstants.CENTER_X
    playButton.y = displayConstants.CENTER_Y + 20
    playButton:addEventListener(listener.TAP, sceneManager.goGame)

    local preferencesButton = display.newImageRect(images.PREFERENCES_BUTTON, buttons.width, buttons.height)
    preferencesButton.x = playButton.x
    preferencesButton.y = playButton.y + distance.y
    preferencesButton:addEventListener(listener.TAP, sceneManager.goPreferences)

    local aboutButton = display.newImageRect(images.ABOUT_BUTTON, buttons.width, buttons.height)
    aboutButton.x = preferencesButton.x
    aboutButton.y = preferencesButton.y + distance.y
    aboutButton:addEventListener(listener.TAP, sceneManager.goAbout)

    local gameTitle = display.newImageRect(images.TITLE, 783, 183)
    gameTitle.x = displayConstants.CENTER_X
    gameTitle.y = displayConstants.CENTER_Y - 250

    sceneGroup:insert(background)
    sceneGroup:insert(preferencesButton)
    sceneGroup:insert(aboutButton)
    sceneGroup:insert(playButton)
    sceneGroup:insert(gameTitle)
end

function scene:destroy(event)

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