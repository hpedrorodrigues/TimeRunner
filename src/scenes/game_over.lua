local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)

local scene = composer.newScene()
local screenTime = 5000

function scene:create(event)

    local sceneGroup = self.view
    local background = display.newImage(images.GAME_OVER_BACKGROUND, 650, 400, true)

    local backButtonDifference = 60

    local backButton = display.newImageRect(images.BACK_BUTTON, 72, 71)
    backButton.x = displayConstants.LEFT_SCREEN + backButtonDifference
    backButton.y = displayConstants.TOP_SCREEN + backButtonDifference
    backButton:addEventListener(listener.TAP, sceneManager.goMenu)

    local scoreText = display.newText({
        text = 'Score: ' .. event.params.score,
        x = displayConstants.CENTER_X,
        y = displayConstants.CENTER_Y + 180,
        font = (system.getInfo('environment') == 'simulator' and 'FFFTusj-Bold' or 'FFF_Tusj'),
        fontSize = 100
    })

    sceneGroup:insert(background)
    sceneGroup:insert(backButton)
    sceneGroup:insert(scoreText)

    timer.performWithDelay(screenTime, function()
        sceneManager.goMenu()
    end)

    eventUtil.setBackPressed(sceneManager.goMenu)
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