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

        imagePath = images.RSZ_BIRD_SPRITE

        local frames = {
            { x = 0, y = 0, width = 244, height = 328 },
            { width = 246 },
            { width = 236 },
            { width = 230 },
            { width = 244 },
            { x = 0, y = 328, width = 244, height = 254 },
            { width = 252 },
            { width = 224 },
            { width = 250 },
            { width = 230 },
            { x = 0, y = 582, width = 244, height = 340 },
            { width = 240 },
            { width = 248 },
            { width = 238 },
            { width = 230 },
            { x = 0, y = 922, width = 258, height = 332 },
            { width = 236 },
            { width = 236 },
            { width = 236 },
            { width = 234 }
        }

        local framesCount = spriteUtil.fillNeededFrameFields(frames)

        sheetData = {
            frames = frames,
            sheetContentWidth = 1200,
            sheetContentHeight = 1256
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
        imagePath = images.BIRD_SPRITE

        local frames = {
            { x = 0, y = 0, width = 120, height = 164 },
            { width = 124 },
            { width = 118 },
            { width = 120 },
            { width = 119 },
            { x = 0, y = 164, width = 124, height = 128 },
            { width = 118 },
            { width = 126 },
            { width = 114 },
            { width = 118 },
            { x = 0, y = 292, width = 122, height = 172 },
            { width = 124 },
            { width = 116 },
            { width = 124 },
            { width = 114 },
            { x = 0, y = 464, width = 128, height = 162 },
            { width = 116 },
            { width = 116 },
            { width = 116 },
            { width = 118 }
        }

        local framesCount = spriteUtil.fillNeededFrameFields(frames)

        sheetData = {
            frames = frames,
            sheetContentWidth = 600,
            sheetContentHeight = 628
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