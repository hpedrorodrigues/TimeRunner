local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local fonts = require(importations.FONTS)
local viewUtil = require(importations.VIEW_UTIL)

local scene = composer.newScene()
local screenTime = 5000
local someButtonClicked = false

function scene:create(event)

    local sceneGroup = self.view
    local background = viewUtil.createBackground(images.GAME_OVER_BACKGROUND, 1440, 790)
    local backButton = viewUtil.createBackButton(function()
        sceneManager.goMenu()
        someButtonClicked = true
    end)

    local gameOverTitle = viewUtil.createImage({
        imagePath = images.GAME_OVER_BUTTON,
        width = 680,
        height = 168,
        x = displayConstants.CENTER_X,
        y = displayConstants.LEFT_SCREEN + 200
    })

    local scoreText = display.newText({
        text = 'Score: ' .. event.params.score .. 's',
        x = gameOverTitle.x,
        y = gameOverTitle.y + 135,
        font = fonts.SYSTEM,
        fontSize = 80
    })
    scoreText:setFillColor(248, 248, 255)

    local playButton = viewUtil.createMenuButton({
        imagePath = images.PLAY_BUTTON,
        x = displayConstants.CENTER_X,
        y = scoreText.y + 180,
        action = function()
            sceneManager.goGame()
            someButtonClicked = true
        end
    })

    local menuButton = viewUtil.createMenuButton({
        imagePath = images.MENU_BUTTON,
        x = playButton.x,
        y = playButton.y + 130,
        action = function()
            sceneManager.goMenu()
            someButtonClicked = true
        end
    })

    sceneGroup:insert(background)
    sceneGroup:insert(gameOverTitle)
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