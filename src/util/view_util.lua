local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local widget = require(importations.WIDGET)

local function _setTheme()
    widget.setTheme('widget_theme_android_holo_dark')
end

local function _start()
    _setTheme()
end

local function _createImage(object)
    local createdImage = display.newImageRect(object.imagePath, object.width, object.height)

    createdImage.x = object.x
    createdImage.y = object.y

    return createdImage
end

local function _createWidgetImage(object)
    return widget.newButton({
        x = object.x,
        y = object.y,
        defaultFile = object.imagePath
    })
end

local function _createButtonCircle(object)
    local circleButton = display.newCircle(object.size, object.size, object.radius)

    circleButton.x = object.x
    circleButton.y = object.y

    circleButton:setFillColor(0, 0, 0, 1)

    return circleButton
end

local function _createText(object)
    return display.newText({
        text = object.text,
        x = object.x,
        y = object.y,
        font = 'Quicksand-BoldItalic',
        fontSize = object.fontSize
    })
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

local function _addTouchEventWithAlphaEffectListener(object, objectToChange, action)
    object:addEventListener(listener.TOUCH, function(eventButton)
        if (eventButton.phase == 'began') then

            objectToChange.alpha = .6
        elseif (eventButton.phase == 'ended') then

            objectToChange.alpha = .2

            if (action ~= nil) then
                action(eventButton)
            end
        end
    end)
end

local function _createMenuButton(object)
    local menuButton = _createImage({
        imagePath = object.imagePath,
        width = 411,
        height = 102,
        x = object.x,
        y = object.y
    })

    menuButton.action = object.action

    menuButton:addEventListener(listener.TOUCH, function(eventButton)
        if (eventButton.phase == 'began') then

            menuButton.alpha = .5
        elseif (eventButton.phase == 'ended') then
            menuButton.alpha = 1

            if (menuButton.action ~= nil) then
                menuButton.action(eventButton)
            end
        end
    end)

    return menuButton
end

local function _createMenuItem(object)
    object.imagePath = images.BUTTON
    object.fontSize = 40

    local menuButton = _createMenuButton(object)
    local menuText = _createText(object)

    menuText:setTextColor(.8, .8, .8)

    return {
        button = menuButton,
        text = menuText
    }
end

local function _createBackButton(background, action)
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

    _addEndedTouchEventListener(background, function()
        backButton.alpha = 1
    end)

    return backButton
end

return {
    createBackButton = _createBackButton,
    createBackground = _createBackground,
    addBeganTouchEventListener = _addBeganTouchEventListener,
    addEndedTouchEventListener = _addEndedTouchEventListener,
    addTouchEventWithAlphaEffectListener = _addTouchEventWithAlphaEffectListener,
    createMenuButton = _createMenuButton,
    alphaDefault = 1,
    distanceBetweenMenuButtons = 130,
    createImage = _createImage,
    createWidgetImage = _createWidgetImage,
    createButtonCircle = _createButtonCircle,
    createText = _createText,
    createMenuItem = _createMenuItem,
    setTheme = _setTheme,
    start = _start
}