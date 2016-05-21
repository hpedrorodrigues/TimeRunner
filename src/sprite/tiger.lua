local importations = require(IMPORTATIONS)
local spriteSequenceNames = require(importations.SPRITE_SEQUENCE)
local images = require(importations.IMAGES)
local spriteUtil = require(importations.SPRITE_UTIL)
local spriteSize = require(importations.SPRITE_SIZE)

local function _create(size)
    size = (size == nil) and spriteSize.SMALL or size

    local sheetData
    local spriteSequence
    local imagePath

    if (size == spriteSize.LARGE) then

        imagePath = images.RSZ_TIGER_SPRITE

        local frames = {
            { x = 0, y = 0, width = 244, height = 88 },
            { width = 242 },
            { width = 240 },
            { width = 276 },
            { width = 240 },
            { width = 228 }
        }

        local framesCount = spriteUtil.fillNeededFrameFields(frames)

        sheetData = {
            frames = frames,
            sheetContentWidth = 1470,
            sheetContentHeight = 88
        }

        spriteSequence = {
            {
                name = spriteSequenceNames.RUNNING,
                start = 1,
                count = framesCount - 1,
                time = 1000,
                loopCount = 0
            }
        }

    else
        imagePath = images.TIGER_SPRITE

        local frames = {
            { x = 0, y = 0, width = 122, height = 44 },
            { width = 122 },
            { width = 120 },
            { width = 138 },
            { width = 118 },
            { width = 115 }
        }

        local framesCount = spriteUtil.fillNeededFrameFields(frames)

        sheetData = {
            frames = frames,
            sheetContentWidth = 735,
            sheetContentHeight = 44
        }

        spriteSequence = {
            {
                name = spriteSequenceNames.RUNNING,
                start = 1,
                count = framesCount - 1,
                time = 1000,
                loopCount = 0
            }
        }
    end

    local healthSheet = graphics.newImageSheet(imagePath, sheetData)
    local sprite = display.newSprite(healthSheet, spriteSequence)

    sprite:setSequence(spriteSequenceNames.RUNNING)

    return sprite
end

return {
    create = _create
}