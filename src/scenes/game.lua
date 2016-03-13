local composer = require("composer")
local snowMaker = require("src.effect.snow")
local listener = require("src.constant.listener")
local sprite = require("src.sprite.crazy_scientist")
local spriteControl = require("src.sprite.control.crazy_scientist")
local images = require("src.constant.images")
local eventUtil = require("src.view.event_util")
local sceneManager = require("src.scenes.manager")
local displayUtil = require("src.view.display_util")

local scene = composer.newScene()
local defaultDisplayConfiguration = display.getDefault()

function scene:create()

    local sceneGroup = self.view

    display.setDefault("textureWrapX", "mirroredRepeat")

    local navigationStatusBarSize = 300

    local background = display.newRect(display.contentCenterX,
        display.contentCenterY,
        display.contentWidth + navigationStatusBarSize,
        display.contentHeight)
    background.fill = { type = "image", filename = images.KINGDOM_SCENE }

    local function infinitelyScrollingBackground()
        transition.to(background.fill, { time = 5000, x = 1, delta = true, onComplete = infinitelyScrollingBackground })
    end

    infinitelyScrollingBackground()

    local backButtonDifference = 60

    local backButton = display.newImageRect(images.BACK_BUTTON, 100, 100)
    backButton.x = displayUtil.LEFT_SCREEN + backButtonDifference
    backButton.y = displayUtil.TOP_SCREEN + backButtonDifference
    backButton:addEventListener(listener.TAP, sceneManager.goMenu)

    sprite:play()

    spriteControl.make(sprite, background)

    sceneGroup:insert(background)
    sceneGroup:insert(sprite)
    sceneGroup:insert(backButton)

    eventUtil.setBackPressed(sceneManager.goMenu)

    Runtime:addEventListener(listener.ENTER_FRAME, snowMaker.make)
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

    Runtime:removeEventListener(listener.ENTER_FRAME, snowMaker.make)

    spriteControl.clear()

    local sceneGroup = self.view
    sceneGroup:removeSelf()
    sceneGroup = nil

    display.setDefault(defaultDisplayConfiguration)
end

scene:addEventListener(listener.CREATE, scene)
scene:addEventListener(listener.SHOW, scene)
scene:addEventListener(listener.HIDE, scene)
scene:addEventListener(listener.DESTROY, scene)

return scene