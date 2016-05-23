local importations = require(IMPORTATIONS)
local spriteSequenceNames = require(importations.SPRITE_SEQUENCE)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local images = require(importations.IMAGES)
local bodyManager = require(importations.BODY_MANAGER)
local spriteUtil = require(importations.SPRITE_UTIL)

local spriteTime = 1000

local function _create()
    local imagePath = images.RSZ_CRAZY_SCIENTIST_SPRITE

    local frames = {
        { x = 58, y = 0, width = 60, height = 122 },
        { width = 78 },
        { width = 96 },
        { width = 78 },
        { x = 0, y = 122, width = 58, height = 126 },
        { width = 74 },
        { width = 94 },
        { width = 82 }
    }

    local framesCount = spriteUtil.fillNeededFrameFields(frames)

    local sheetData = {
        frames = frames,
        sheetContentWidth = 370,
        sheetContentHeight = 265
    }

    local spriteSequence = {
        {
            name = spriteSequenceNames.RUNNING,
            start = 1,
            count = framesCount - 1,
            time = spriteTime,
            loopCount = 0
        }
    }

    local healthSheet = graphics.newImageSheet(imagePath, sheetData)
    local sprite = display.newSprite(healthSheet, spriteSequence)

    sprite:setSequence(spriteSequenceNames.RUNNING)

    sprite.myName = bodyManager.NAME.CRAZY_SCIENTIST
    sprite.died = false

    sprite.x = displayConstants.LEFT_SCREEN + 150
    sprite.y = displayConstants.HEIGHT_SCREEN - 55

    return sprite
end

return {
    create = _create
}