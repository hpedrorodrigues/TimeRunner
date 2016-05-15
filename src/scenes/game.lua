local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local listener = require(importations.LISTENER)
local rules = require(importations.GAME_RULES)
local images = require(importations.IMAGES)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local spriteManager = require(importations.CRAZY_SCIENTIST_SPRITE)

local scene = composer.newScene()
local defaultDisplayConfiguration = display.getDefault()

local sprite

function scene:create()

    local sceneGroup = self.view

    display.setDefault('textureWrapX', 'mirroredRepeat')

    sprite = spriteManager.create()

    local navigationStatusBarSize = 300

    local background = display.newRect(display.contentCenterX,
        display.contentCenterY,
        display.contentWidth + navigationStatusBarSize,
        display.contentHeight)
    background.fill = { type = 'image', filename = images.FRENCH_REVOLUTION_SCENE }

    local transitionHandler

    local function infinitelyScrollingBackground()
        local fill = background.fill;

        if (rules.scoreManager().score() % 300 == 0) then

            local random = math.random(1, 3)

            if (random == 1) then
                fill.filename = images.FRENCH_REVOLUTION_SCENE;
            elseif (random == 2) then
                fill.filename = images.EGYPT_SCENE;
            else
                fill.filename = images.KINGDOM_SCENE;
            end
        end

        transitionHandler = transition.to(fill, {
            time = 3000,
            x = 1,
            delta = true,
            onComplete = function()
                transition.cancel(transitionHandler)
                infinitelyScrollingBackground()
            end
        })
    end

    infinitelyScrollingBackground()

    local backButtonDifference = 30

    local backButton = display.newImageRect(images.BACK_BUTTON, 40, 40)
    backButton.x = displayConstants.LEFT_SCREEN + backButtonDifference
    backButton.y = displayConstants.TOP_SCREEN + backButtonDifference
    backButton:addEventListener(listener.TAP, sceneManager.goMenu)

    local gameTitle = display.newText({
        text = 'Time Runner',
        x = display.contentCenterX,
        y = 25,
        font = (system.getInfo('environment') == 'simulator' and 'FFFTusj-Bold' or 'FFF_Tusj'),
        fontSize = 30
    })
    gameTitle:setFillColor(1, 0, 0)

    sprite:play()

    sceneGroup:insert(background)
    sceneGroup:insert(sprite)
    sceneGroup:insert(backButton)
    sceneGroup:insert(gameTitle)

    rules.apply(sceneGroup, sprite)

    eventUtil.setBackPressed(sceneManager.goMenu)
end

function scene:destroy(event)

    rules.clear()

    local sceneGroup = self.view
    sceneGroup:removeSelf()
    sceneGroup = nil

    -- Doing it because is needed but linter not known Corona SDK
    if (sceneGroup ~= nil) then
        print(sceneGroup)
    end

    display.setDefault(defaultDisplayConfiguration)
end

scene:addEventListener(listener.CREATE, scene)
scene:addEventListener(listener.DESTROY, scene)

return scene