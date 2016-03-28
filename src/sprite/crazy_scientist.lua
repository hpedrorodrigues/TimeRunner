local importations = require(IMPORTATIONS)
local spriteSequenceNames = require(importations.SPRITE_SEQUENCE)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local images = require(importations.IMAGES)

local function _create()

    local imageSheetOptions = { width = 90, height = 128, numFrames = 16 }

    local spriteSequence = {
        {
            name = spriteSequenceNames.STOPPED,
            start = 9,
            count = 1,
            time = 1000,
            loopCount = 0
        }, {
            name = spriteSequenceNames.RUNNING,
            start = 10,
            count = 3,
            time = 1000,
            loopCount = 0
        }
    }

    local healthSheet = graphics.newImageSheet(images.CRAZY_SCIENTIST_SPRITE, imageSheetOptions)
    local sprite = display.newSprite(healthSheet, spriteSequence)

    sprite:setSequence(spriteSequenceNames.RUNNING)

    sprite.x = displayConstants.LEFT_SCREEN + 100
    sprite.y = displayConstants.HEIGHT_SCREEN - 55

    return sprite
end

return {
    create = _create
}