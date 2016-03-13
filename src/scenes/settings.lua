local composer = require("composer")
local images = require("src.constant.images")
local listener = require("src.constant.listener")
local eventUtil = require("src.view.event_util")
local sceneManager = require("src.scenes.manager")
local displayUtil = require("src.view.display_util")
local widget = require("widget")
local settings = require('src.db.settings')
local sounds = require("src.constant.sounds")

local scene = composer.newScene()

function scene:create(event)

    local sceneGroup = self.view
    local background = display.newImage(images.SETTINGS_BACKGROUND, 700, 400, true)

    local backButtonDifference = 60

    local backButton = display.newImageRect(images.BACK_BUTTON, 100, 100)
    backButton.x = displayUtil.LEFT_SCREEN + backButtonDifference
    backButton.y = displayUtil.TOP_SCREEN + backButtonDifference
    backButton:addEventListener(listener.TAP, sceneManager.goMenu)

    local soundSwitch = widget.newSwitch({
        left = displayUtil.LEFT_SCREEN + 100,
        top = 200,
        style = "onOff",
        id = "soundSwitch",
        initialSwitchState = settings.isSoundEnabled(),
        onPress = function(event)
            local switch = event.target

            if (backgroundSound ~= nil) then
                audio.stop(backgroundSound)
            end

            if (switch.isOn) then

                settings.disableSound()
            else

                settings.enableSound()
                backgroundSound = audio.play(audio.loadStream(sounds.ADVENTURE), { loops = -1, fadein = 5000 })
            end
        end
    })

    local soundTitle = display.newText({
        text = "Habilitar som",
        x = soundSwitch.x + 200,
        y = soundSwitch.y,
        font = native.systemFontBold,
        fontSize = 40
    })

    sceneGroup:insert(background)
    sceneGroup:insert(backButton)
    sceneGroup:insert(soundSwitch)
    sceneGroup:insert(soundTitle)

    eventUtil.setBackPressed(sceneManager.goMenu)
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

    local sceneGroup = self.view
    sceneGroup:removeSelf()
    sceneGroup = nil
end

scene:addEventListener(listener.CREATE, scene)
scene:addEventListener(listener.SHOW, scene)
scene:addEventListener(listener.HIDE, scene)
scene:addEventListener(listener.DESTROY, scene)

return scene