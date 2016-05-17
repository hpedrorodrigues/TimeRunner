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
local transitionTime = 2000

function scene:create()

    local sceneGroup = self.view

    display.setDefault('textureWrapX', 'mirroredRepeat')

    sprite = spriteManager.create()

    local navigationStatusBarSize = 300

    local background = display.newRect(display.contentCenterX,
        display.contentCenterY,
        display.contentWidth + navigationStatusBarSize,
        display.contentHeight)
    background.fill = { type = 'image', filename = images.MAIN_SCENE }

    local transitionHandler

    local function infinitelyScrollingBackground()
        local fill = background.fill;

        if (rules.scoreManager().score() % 300 == 0) then

            transitionTime = transitionTime - 100

            local random = math.random(1, 3)

            if (random == 1) then
                fill.filename = images.MAIN_SCENE
            elseif (random == 2) then
                fill.filename = images.MAIN_SCENE
            else
                fill.filename = images.MAIN_SCENE
            end
        end

        transitionHandler = transition.to(fill, {
            time = transitionTime,
            x = 1,
            delta = true,
            onComplete = function()
                transition.cancel(transitionHandler)
                infinitelyScrollingBackground()
            end
        })
    end

    infinitelyScrollingBackground()

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

    local gameTitle = display.newImageRect(images.TITLE, 261, 61)
    gameTitle.x = displayConstants.CENTER_X
    gameTitle.y = displayConstants.TOP_SCREEN + 50

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