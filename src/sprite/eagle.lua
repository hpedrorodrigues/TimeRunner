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

        imagePath = images.RSZ_EAGLE_SPRITE

        local frames = {
            { x = 0, y = 0, width = 364, height = 336 },
            { width = 372 },
            { width = 362 },
            { width = 372 },
            { width = 370 },
            { x = 0, y = 336, width = 364, height = 310 },
            { width = 370 },
            { width = 352 },
            { width = 368 },
            { width = 386 }
        }

        local framesCount = spriteUtil.fillNeededFrameFields(frames)

        sheetData = {
            frames = frames,
            sheetContentWidth = 1840,
            sheetContentHeight = 1840
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
        imagePath = images.EAGLE_SPRITE

        local frames = {
            { x = 0, y = 0, width = 192, height = 166 },
            { width = 174 },
            { width = 184 },
            { width = 200 },
            { width = 170 },
            { x = 0, y = 166, width = 178, height = 156 },
            { width = 192 },
            { width = 178 },
            { width = 186 },
            { width = 186 }
        }

        local framesCount = spriteUtil.fillNeededFrameFields(frames)

        sheetData = {
            frames = frames,
            sheetContentWidth = 920,
            sheetContentHeight = 920
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