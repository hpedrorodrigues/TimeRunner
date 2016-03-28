local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local listener = require(importations.LISTENER)
local gameRules = require(importations.GAME_RULES)
local images = require(importations.IMAGES)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local spriteManager = require(importations.CRAZY_SCIENTIST_SPRITE)

local scene = composer.newScene()
local defaultDisplayConfiguration = display.getDefault()

local initialTime
local finalTime

local sprite

function scene:create()

    initialTime = os.time()

    local sceneGroup = self.view

    display.setDefault('textureWrapX', 'mirroredRepeat')

    sprite = spriteManager.create()

    local navigationStatusBarSize = 300

    local background = display.newRect(display.contentCenterX,
        display.contentCenterY,
        display.contentWidth + navigationStatusBarSize,
        display.contentHeight)
    background.fill = { type = 'image', filename = images.FRENCH_REVOLUTION_SCENE }

    local function infinitelyScrollingBackground()
        transition.to(background.fill, {
            time = 5000,
            x = 1,
            delta = true,
            onComplete = infinitelyScrollingBackground
        })
    end

    infinitelyScrollingBackground()

    local backButtonDifference = 60

    local backButton = display.newImageRect(images.BACK_BUTTON, 100, 100)
    backButton.x = displayConstants.LEFT_SCREEN + backButtonDifference
    backButton.y = displayConstants.TOP_SCREEN + backButtonDifference
    backButton:addEventListener(listener.TAP, sceneManager.goMenu)

    sprite:play()

    sceneGroup:insert(background)
    sceneGroup:insert(sprite)
    sceneGroup:insert(backButton)

    gameRules.make(sprite, background, sceneGroup)

    eventUtil.setBackPressed(sceneManager.goMenu)
end

function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == 'will') then

        -- Called when the scene is still off screen (but is about to come on screen).
    elseif (phase == 'did') then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end

function scene:hide(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == 'will') then

        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to 'pause' the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif (phase == 'did') then

        -- Called immediately after scene goes off screen.
    end
end

function scene:destroy(event)

    finalTime = os.time()

    print(tostring(finalTime - initialTime) .. 's')

    gameRules.clear()

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