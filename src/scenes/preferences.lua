local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local widget = require(importations.WIDGET)
local settings = require(importations.SETTINGS)
local soundUtil = require(importations.SOUND_UTIL)
local viewUtil = require(importations.VIEW_UTIL)

local scene = composer.newScene()

function scene:create()

    local sceneGroup = self.view
    local background = viewUtil.createBackground(images.PREFERENCES_BACKGROUND, 1800, 900)
    local backButton = viewUtil.createBackButton(background, sceneManager.goMenu)

    local leftSwitches = displayConstants.LEFT_SCREEN + 100

    local soundSwitch = widget.newSwitch({
        left = leftSwitches,
        top = 200,
        style = 'onOff',
        id = 'soundSwitch',
        initialSwitchState = settings.isSoundEnabled(),
        onPress = function(onPressEvent)
            local switch = onPressEvent.target

            if (switch.isOn) then

                settings.disableSound()
                soundUtil.cancel(backgroundSound)
            else

                settings.enableSound()
                backgroundSound = soundUtil.playBackgroundSound()
            end
        end
    })

    local soundTitle = viewUtil.createText({
        text = 'Enable sound',
        x = soundSwitch.x + 200,
        y = soundSwitch.y,
        fontSize = 40
    })

    sceneGroup:insert(background)
    sceneGroup:insert(backButton)
    sceneGroup:insert(soundSwitch)
    sceneGroup:insert(soundTitle)

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