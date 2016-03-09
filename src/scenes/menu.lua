local composer = require("composer")
local displayUtil = require("src.view.display_util")
local images = require("src.constant.images")
local listener = require("src.constant.listener")
local sceneManager = require("src.scenes.manager")
local pingPong = require("src.effect.ping_pong")
local snowMaker = require("src.effect.snow")

local scene = composer.newScene()

function scene:create(event)

    Runtime:addEventListener(listener.ENTER_FRAME, snowMaker.make)

    local sceneGroup = self.view
    local background = display.newImage(images.MENU_BACKGROUND, 300, 200, true)
    local distance = { x = 400, y = 250 }

    local playButton = display.newImageRect(images.PLAY_BUTTON, 100, 100)
    playButton.x = displayUtil.CENTER_X
    playButton.y = displayUtil.CENTER_Y
    playButton:addEventListener(listener.TAP, sceneManager.goGame)

    local settingsButton = display.newImageRect(images.SETTINGS_BUTTON, 100, 100)
    settingsButton.x = displayUtil.CENTER_X + distance.x
    settingsButton.y = displayUtil.CENTER_Y
    settingsButton:addEventListener(listener.TAP, sceneManager.goSettings)

    local aboutButton = display.newImageRect(images.ABOUT_BUTTON, 100, 100)
    aboutButton.x = displayUtil.CENTER_X - distance.x
    aboutButton.y = displayUtil.CENTER_Y
    aboutButton:addEventListener(listener.TAP, sceneManager.goAbout)

    pingPong.make(playButton)

    local gameTitle = display.newText({
        text = "Time Runner",
        x = displayUtil.CENTER_X,
        y = displayUtil.CENTER_Y - distance.y,
        font = (system.getInfo("environment") == "simulator" and "FFFTusj-Bold" or "FFF_Tusj"),
        fontSize = 100
    })

    sceneGroup:insert(background)
    sceneGroup:insert(settingsButton)
    sceneGroup:insert(aboutButton)
    sceneGroup:insert(playButton)
    sceneGroup:insert(gameTitle)
end

function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

        -- Called when the scene is still off screen (but is about to come on screen).
    elseif (phase == "did") then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end

function scene:hide(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif (phase == "did") then

        -- Called immediately after scene goes off screen.
    end
end

function scene:destroy(event)

    Runtime:addEventListener(listener.ENTER_FRAME, snowMaker.cancel)

    local sceneGroup = self.view
    sceneGroup:removeSelf()
    sceneGroup = nil
end

scene:addEventListener(listener.CREATE, scene)
scene:addEventListener(listener.SHOW, scene)
scene:addEventListener(listener.HIDE, scene)
scene:addEventListener(listener.DESTROY, scene)

return scene