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
local fonts = require(importations.FONTS)

local scene = composer.newScene()

function scene:create(event)

    local sceneGroup = self.view
    local background = display.newImageRect(images.PREFERENCES_BACKGROUND, 1800, 900)
    background.x = displayConstants.CENTER_X
    background.y = displayConstants.CENTER_Y

    local backButtonConfiguration = {
        width = 79,
        height = 78,
        alphaNormal = .2,
        alphaClicked = .6,
        difference = 60
    }

    local backButton = display.newImageRect(images.BACK_BUTTON, backButtonConfiguration.width, backButtonConfiguration.height)
    backButton.x = displayConstants.LEFT_SCREEN + backButtonConfiguration.difference
    backButton.y = displayConstants.TOP_SCREEN + backButtonConfiguration.difference
    backButton:addEventListener(listener.TOUCH, function(eventButton)
        if (eventButton.phase == 'began') then
            backButton.alpha = backButtonConfiguration.alphaClicked
        elseif (eventButton.phase == 'ended') then
            backButton.alpha = backButtonConfiguration.alphaNormal
            sceneManager.goMenu()
        end
    end)

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

    local soundTitle = display.newText({
        text = 'Enable sound',
        x = soundSwitch.x + 200,
        y = soundSwitch.y,
        font = fonts.SYSTEM,
        fontSize = 40
    })

    sceneGroup:insert(background)
    sceneGroup:insert(backButton)
    sceneGroup:insert(soundSwitch)
    sceneGroup:insert(soundTitle)

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