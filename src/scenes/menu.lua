local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local sceneManager = require(importations.SCENE_MANAGER)
local pingPong = require(importations.PING_PONG)

local scene = composer.newScene()

function scene:create(event)

    local sceneGroup = self.view
    local background = display.newImage(images.MENU_BACKGROUND, 700, 300, true)
    local distance = { x = 400, y = 250 }

    local playButton = display.newImageRect(images.PLAY_BUTTON, 100, 100)
    playButton.x = displayConstants.CENTER_X
    playButton.y = displayConstants.CENTER_Y
    playButton:addEventListener(listener.TAP, sceneManager.goGame)

    local settingsButton = display.newImageRect(images.SETTINGS_BUTTON, 100, 100)
    settingsButton.x = displayConstants.CENTER_X + distance.x
    settingsButton.y = displayConstants.CENTER_Y
    settingsButton:addEventListener(listener.TAP, sceneManager.goSettings)

    local aboutButton = display.newImageRect(images.ABOUT_BUTTON, 100, 100)
    aboutButton.x = displayConstants.CENTER_X - distance.x
    aboutButton.y = displayConstants.CENTER_Y
    aboutButton:addEventListener(listener.TAP, sceneManager.goAbout)

    pingPong.make(playButton)

    local gameTitle = display.newText({
        text = 'Time Runner',
        x = displayConstants.CENTER_X,
        y = displayConstants.CENTER_Y - distance.y,
        font = (system.getInfo('environment') == 'simulator' and 'FFFTusj-Bold' or 'FFF_Tusj'),
        fontSize = 100
    })

    sceneGroup:insert(background)
    sceneGroup:insert(settingsButton)
    sceneGroup:insert(aboutButton)
    sceneGroup:insert(playButton)
    sceneGroup:insert(gameTitle)
end

function scene:destroy(event)

    pingPong.cancel()

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