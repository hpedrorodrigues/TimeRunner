local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)

local backButtonConfiguration = {
    width = 79,
    height = 78,
    alphaNormal = .2,
    alphaClicked = .6,
    difference = 60
}

local function _createBackButton(action)

    local backButton = display.newImageRect(images.BACK_BUTTON, backButtonConfiguration.width, backButtonConfiguration.height)

    backButton.x = displayConstants.LEFT_SCREEN + backButtonConfiguration.difference
    backButton.y = displayConstants.TOP_SCREEN + backButtonConfiguration.difference

    backButton:addEventListener(listener.TOUCH, function(eventButton)
        if (eventButton.phase == 'began') then

            backButton.alpha = backButtonConfiguration.alphaClicked

        elseif (eventButton.phase == 'ended') then

            backButton.alpha = backButtonConfiguration.alphaNormal

            if (action ~= nil) then

                action()
            end
        end
    end)

    return backButton
end

return {
    createBackButton = _createBackButton
}