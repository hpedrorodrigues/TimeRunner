local importations = require(IMPORTATIONS)
local spriteSequenceNames = require(importations.SPRITE_SEQUENCE)
local images = require(importations.IMAGES)

local function _create()

    local imageSheetOptions = { width = 168.8, height = 94, numFrames = 8 }

    local spriteSequence = {
        {
            name = spriteSequenceNames.RUNNING,
            start = 1,
            count = 8,
            time = 1000,
            loopCount = 0
        }
    }

    local healthSheet = graphics.newImageSheet(images.BEAR_SPRITE, imageSheetOptions)
    local sprite = display.newSprite(healthSheet, spriteSequence)

    sprite:setSequence(spriteSequenceNames.RUNNING)

    return sprite
end

return {
    create = _create
}