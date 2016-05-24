local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local settings = require(importations.SETTINGS)
local soundUtil = require(importations.SOUND_UTIL)
local viewUtil = require(importations.VIEW_UTIL)
local i18n = require(importations.I18N)
local adsManager = require(importations.ADS_MANAGER)
local googleAnalyticsManager = require(importations.GOOGLE_ANALYTICS_MANAGER)

local scene = composer.newScene()

local soundView
local vibrationView
local largeSpritesView

function scene:create()
    local sceneGroup = self.view

    local background = viewUtil.createBackground(images.PREFERENCES_BACKGROUND, 1800, 900)
    local backButton = viewUtil.createBackButton(background, sceneManager.goMenu)

    soundView = viewUtil.createMenuItem({
        text = (settings.isSoundEnabled()) and i18n.yes or i18n.no,
        x = displayConstants.LEFT_SCREEN + 200,
        y = 200,
        action = function()
            if (settings.isSoundEnabled()) then
                soundView.text.text = i18n.no

                settings.disableSound()
                soundUtil.cancel(backgroundSound)
            else
                soundView.text.text = i18n.yes

                settings.enableSound()
                backgroundSound = soundUtil.playBackgroundSound()
            end

            googleAnalyticsManager.logEvent('UserAction', 'Sound', 'enable', settings.isSoundEnabled())
        end
    })

    local soundTitle = viewUtil.createText({
        text = i18n.enableSound,
        x = soundView.button.x + (i18n.isEnUS and 265 or 250),
        y = soundView.button.y,
        fontSize = 40
    })

    vibrationView = viewUtil.createMenuItem({
        text = (settings.isVibrationEnabled()) and i18n.yes or i18n.no,
        x = displayConstants.LEFT_SCREEN + 200,
        y = soundView.button.y + 100,
        action = function()
            if (settings.isVibrationEnabled()) then
                vibrationView.text.text = i18n.no

                settings.disableVibration()
            else
                vibrationView.text.text = i18n.yes

                settings.enableVibration()
                system.vibrate()
            end

            googleAnalyticsManager.logEvent('UserAction', 'Vibration', 'enable', settings.isVibrationEnabled())
        end
    })

    local vibrationTitle = viewUtil.createText({
        text = i18n.enableVibration,
        x = vibrationView.button.x + 290,
        y = vibrationView.button.y,
        fontSize = 40
    })

    largeSpritesView = viewUtil.createMenuItem({
        text = (settings.isLargeSpritesEnabled()) and i18n.yes or i18n.no,
        x = displayConstants.LEFT_SCREEN + 200,
        y = vibrationView.button.y + 100,
        action = function()
            if (settings.isLargeSpritesEnabled()) then
                largeSpritesView.text.text = i18n.no

                settings.disableLargeSprites()
            else
                largeSpritesView.text.text = i18n.yes

                settings.enableLargeSprites()
            end

            googleAnalyticsManager.logEvent('UserAction', 'Large Sprites', 'enable', settings.isLargeSpritesEnabled())
        end
    })

    local largeSpritesTitle = viewUtil.createText({
        text = i18n.enableLargeSprites,
        x = largeSpritesView.button.x + (i18n.isEnUS and 327 or 372),
        y = largeSpritesView.button.y,
        fontSize = 40
    })

    soundView.button.width = 205.5
    soundView.button.height = 51

    vibrationView.button.width = 205.5
    vibrationView.button.height = 51

    largeSpritesView.button.width = 205.5
    largeSpritesView.button.height = 51

    adsManager.set(adsManager.SUPPORTED_SCREENS.PREFERENCES)
    adsManager.start()

    viewUtil.addEndedTouchEventListener(background, function()
        soundView.button.alpha = viewUtil.alphaDefault
        vibrationView.button.alpha = viewUtil.alphaDefault
        largeSpritesView.button.alpha = viewUtil.alphaDefault
    end)

    sceneGroup:insert(background)
    sceneGroup:insert(backButton)
    sceneGroup:insert(soundView.button)
    sceneGroup:insert(soundView.text)
    sceneGroup:insert(soundTitle)
    sceneGroup:insert(vibrationView.button)
    sceneGroup:insert(vibrationView.text)
    sceneGroup:insert(vibrationTitle)
    sceneGroup:insert(largeSpritesView.button)
    sceneGroup:insert(largeSpritesView.text)
    sceneGroup:insert(largeSpritesTitle)

    eventUtil.setBackPressed(sceneManager.goMenu)
end

function scene:destroy()
    adsManager.hide()

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