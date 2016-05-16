local importations = require(IMPORTATIONS)
local spriteSequenceNames = require(importations.SPRITE_SEQUENCE)
local images = require(importations.IMAGES)

local function _create()

    local imageSheetOptions = { width = 122, height = 44, numFrames = 6 }

    local spriteSequence = {
        {
            name = spriteSequenceNames.RUNNING,
            start = 1,
            count = 6,
            time = 1000,
            loopCount = 0
        }
    }

    local healthSheet = graphics.newImageSheet(images.TIGER_SPRITE, imageSheetOptions)
    local sprite = display.newSprite(healthSheet, spriteSequence)

    sprite:setSequence(spriteSequenceNames.RUNNING)

    return sprite
end

return {
    create = _create
}