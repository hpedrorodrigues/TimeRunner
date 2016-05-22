local importations = require(IMPORTATIONS)
local spriteSequenceNames = require(importations.SPRITE_SEQUENCE)
local images = require(importations.IMAGES)
local spriteUtil = require(importations.SPRITE_UTIL)
local spriteSize = require(importations.SPRITE_SIZE)

local spriteTime = 1000

local function _create(size)
    local sheetData
    local spriteSequence
    local imagePath

    if (size == spriteSize.LARGE) then

        imagePath = images.RSZ_BEAR_SPRITE

        local frames = {
            { x = 0, y = 0, width = 332, height = 188 },
            { width = 338 },
            { width = 334 },
            { width = 334 },
            { width = 334 },
            { width = 340 },
            { width = 330 },
            { width = 336 }
        }

        local framesCount = spriteUtil.fillNeededFrameFields(frames)

        sheetData = {
            frames = frames,
            sheetContentWidth = 2688,
            sheetContentHeight = 188
        }

        spriteSequence = {
            {
                name = spriteSequenceNames.RUNNING,
                start = 1,
                count = framesCount - 1,
                time = spriteTime,
                loopCount = 0
            }
        }

    else
        imagePath = images.BEAR_SPRITE

        local frames = {
            { x = 0, y = 0, width = 168, height = 94 },
            { width = 168 },
            { width = 168 },
            { width = 164 },
            { width = 170 },
            { width = 170 },
            { width = 164 },
            { width = 170 }
        }

        local framesCount = spriteUtil.fillNeededFrameFields(frames)

        sheetData = {
            frames = frames,
            sheetContentWidth = 1344,
            sheetContentHeight = 94
        }

        spriteSequence = {
            {
                name = spriteSequenceNames.RUNNING,
                start = 1,
                count = framesCount - 1,
                time = spriteTime,
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