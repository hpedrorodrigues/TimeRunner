local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)

local function _createBackButton(action)
    local backButton = display.newImageRect(images.BACK_BUTTON, 79, 78)

    local difference = 60

    backButton.x = displayConstants.LEFT_SCREEN + difference
    backButton.y = displayConstants.TOP_SCREEN + difference

    backButton:addEventListener(listener.TOUCH, function(eventButton)
        if (eventButton.phase == 'began') then

            backButton.alpha = .6
        elseif (eventButton.phase == 'ended') then

            backButton.alpha = .2

            if (action ~= nil) then
                action()
            end
        end
    end)

    return backButton
end

local function _createBackground(imagePath, width, height)
    local background = display.newImageRect(imagePath, width, height)

    background.x = displayConstants.CENTER_X
    background.y = displayConstants.CENTER_Y

    return background
end

local function _addTouchEventListener(object, action, eventName)
    object:addEventListener(listener.TOUCH, function(eventButton)
        if (eventButton.phase == eventName) then
            if (action ~= nil) then
                action(eventButton)
            end
        end
    end)
end

local function _addBeganTouchEventListener(object, action)
    _addTouchEventListener(object, action, 'began')
end

local function _addEndedTouchEventListener(object, action)
    _addTouchEventListener(object, action, 'ended')
end

local function _createMenuButton(object)
    local menuButton = display.newImageRect(object.imagePath, 411, 102)

    menuButton.x = object.x
    menuButton.y = object.y

    menuButton:addEventListener(listener.TOUCH, function(eventButton)
        if (eventButton.phase == 'began') then

            menuButton.alpha = .5
        elseif (eventButton.phase == 'ended') then
            menuButton.alpha = 1

            if (object.action ~= nil) then
                object.action(eventButton)
            end
        end
    end)

    return menuButton
end

return {
    createBackButton = _createBackButton,
    createBackground = _createBackground,
    addBeganTouchEventListener = _addBeganTouchEventListener,
    addEndedTouchEventListener = _addEndedTouchEventListener,
    createMenuButton = _createMenuButton,
    alphaDefault = 1,
    distanceBetweenMenuButtons = 130
}