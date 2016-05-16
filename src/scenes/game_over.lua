local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local fonts = require(importations.FONTS)

local scene = composer.newScene()
local screenTime = 5000
local someButtonClicked = false

function scene:create(event)

    local sceneGroup = self.view
    local background = display.newImageRect(images.GAME_OVER_BACKGROUND, 1440, 790)
    background.x = displayConstants.CENTER_X
    background.y = displayConstants.CENTER_Y

    local backButtonDifference = 60

    local backButton = display.newImageRect(images.BACK_BUTTON, 72, 71)
    backButton.x = displayConstants.LEFT_SCREEN + backButtonDifference
    backButton.y = displayConstants.TOP_SCREEN + backButtonDifference
    backButton:addEventListener(listener.TAP, function()
        sceneManager.goMenu()
        someButtonClicked = true
    end)

    local gameOverTitle = display.newImageRect(images.GAME_OVER_BUTTON, 680, 168)
    gameOverTitle.x = displayConstants.CENTER_X
    gameOverTitle.y = display.screenOriginY + 200

    local scoreDifference = 80

    local scoreTitle = display.newImageRect(images.SCORE_BUTTON, 237, 104)
    scoreTitle.x = gameOverTitle.x - scoreDifference
    scoreTitle.y = gameOverTitle.y + 150

    local scoreText = display.newText({
        text = event.params.score .. 's',
        x = gameOverTitle.x + scoreDifference,
        y = gameOverTitle.y + 135,
        font = fonts.SYSTEM,
        fontSize = 70
    })
    scoreText:setFillColor(0, 0, 0, 0.5)

    local buttons = { width = 411, height = 102 }

    local playButton = display.newImageRect(images.PLAY_BUTTON, buttons.width, buttons.height)
    playButton.x = displayConstants.CENTER_X
    playButton.y = scoreText.y + 180
    playButton:addEventListener(listener.TAP, function()
        sceneManager.goGame()
        someButtonClicked = true
    end)

    local menuButton = display.newImageRect(images.MENU_BUTTON, buttons.width, buttons.height)
    menuButton.x = playButton.x
    menuButton.y = playButton.y + 130
    menuButton:addEventListener(listener.TAP, function()
        sceneManager.goMenu()
        someButtonClicked = true
    end)

    sceneGroup:insert(background)
    sceneGroup:insert(gameOverTitle)
    sceneGroup:insert(scoreTitle)
    sceneGroup:insert(playButton)
    sceneGroup:insert(menuButton)
    sceneGroup:insert(backButton)
    sceneGroup:insert(scoreText)

    timer.performWithDelay(screenTime, function()
        if (not someButtonClicked) then
            sceneManager.goMenu()
        end
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