local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local displayUtil = require(importations.DISPLAY_UTIL)
local widget = require(importations.WIDGET)
local settings = require(importations.SETTINGS)
local soundUtil = require(importations.SOUND_UTIL)

local scene = composer.newScene()

function scene:create(event)

    local sceneGroup = self.view
    local background = display.newImage(images.SETTINGS_BACKGROUND, 700, 400, true)

    local backButtonDifference = 60

    local backButton = display.newImageRect(images.BACK_BUTTON, 100, 100)
    backButton.x = displayUtil.LEFT_SCREEN + backButtonDifference
    backButton.y = displayUtil.TOP_SCREEN + backButtonDifference
    backButton:addEventListener(listener.TAP, sceneManager.goMenu)

    local leftSwitches = displayUtil.LEFT_SCREEN + 100

    local soundSwitch = widget.newSwitch({
        left = leftSwitches,
        top = 200,
        style = "onOff",
        id = "soundSwitch",
        initialSwitchState = settings.isSoundEnabled(),
        onPress = function(event)
            local switch = event.target

            if (switch.isOn) then

                settings.disableSound()
                soundUtil.cancel(backgroundSound)
            else

                settings.enableSound()
                backgroundSound = soundUtil.playBackgroundSound()
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

    local logsSwitch = widget.newSwitch({
        left = leftSwitches,
        top = soundSwitch.y + 50,
        style = "onOff",
        id = "logsSwitch",
        initialSwitchState = settings.isLogsEnabled(),
        onPress = function(event)
            local switch = event.target

            if (switch.isOn) then

                settings.disableLogs()
            else

                native.showAlert("Configurações", "Habilitar Logs\n\nIsso pode causar lentidão no jogo", { "OK" })

                settings.enableLogs()
            end
        end
    })

    local logsTitle = display.newText({
        text = "Habilitar logs",
        x = logsSwitch.x + 200,
        y = logsSwitch.y,
        font = native.systemFontBold,
        fontSize = 40
    })

    sceneGroup:insert(background)
    sceneGroup:insert(backButton)
    sceneGroup:insert(soundSwitch)
    sceneGroup:insert(soundTitle)
    sceneGroup:insert(logsSwitch)
    sceneGroup:insert(logsTitle)

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