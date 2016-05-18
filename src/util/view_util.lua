local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)

local function _createImage(object)
    local createdImage = display.newImageRect(object.imagePath, object.width, object.height)

    createdImage.x = object.x
    createdImage.y = object.y

    return createdImage
end

local function _createBackButton(action)
    local backButton = _createImage({
        imagePath = images.BACK_BUTTON,
        width = 79,
        height = 78,
        x = displayConstants.LEFT_SCREEN + 60,
        y = displayConstants.TOP_SCREEN + 60
    })

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
    return _createImage({
        imagePath = imagePath,
        width = width,
        height = height,
        x = displayConstants.CENTER_X,
        y = displayConstants.CENTER_Y
    })
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
    local menuButton = _createImage({
        imagePath = object.imagePath,
        width = 411,
        height = 102,
        x = object.x,
        y = object.y
    })

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
    distanceBetweenMenuButtons = 130,
    createImage = _createImage
}