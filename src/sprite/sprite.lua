-- Reference: https://docs.coronalabs.com/api/library/graphics/newImageSheet.html

local spriteSequenceNames = require("src.constant.sprite_sequence")
local displayUtil = require("src.view.display_util")
local images = require("src.constant.images")

local imageSheetOptions = {
    sheetData = {
        frames = {
            { name = "1", x = 230, y = 0, width = 80, height = 120, sourceX = 1, sourceY = 0, sourceWidth = 53, sourceHeight = 128 },
            { name = "2", x = 225, y = 0, width = 90, height = 125, sourceX = 1, sourceY = 0, sourceWidth = 53, sourceHeight = 128 },
            { name = "3", x = 220, y = 0, width = 100, height = 125, sourceX = 1, sourceY = 0, sourceWidth = 53, sourceHeight = 128 },
            { name = "4", x = 215, y = 0, width = 110, height = 125, sourceX = 1, sourceY = 0, sourceWidth = 53, sourceHeight = 128 },
            { name = "5", x = 210, y = 0, width = 120, height = 125, sourceX = 1, sourceY = 0, sourceWidth = 53, sourceHeight = 128 },
            { name = "6", x = 260, y = 0, width = 70, height = 125, sourceX = 1, sourceY = 0, sourceWidth = 53, sourceHeight = 128 },
            { name = "7", x = 260, y = 0, width = 70, height = 125, sourceX = 1, sourceY = 0, sourceWidth = 53, sourceHeight = 128 },
            { name = "8", x = 260, y = 0, width = 70, height = 125, sourceX = 1, sourceY = 0, sourceWidth = 53, sourceHeight = 128 },
            { name = "9", x = 260, y = 0, width = 220, height = 290, sourceX = 1, sourceY = 0, sourceWidth = 53, sourceHeight = 128 }
        },
        sheetContentWidth = 512,
        sheetContentHeight = 256
    }
}

local spriteSequence = {
    {
        name = spriteSequenceNames.STOPPED,
        frames = { 1, 2, 3, 4, 5 },
        time = 500,
        loopCount = 0
    }, {
        name = spriteSequenceNames.RUNNING,
        frames = { 6, 7, 8, 9 },
        time = 3000,
        loopCount = 0
    }
}

local healthSheet = graphics.newImageSheet(images.RUNNING, imageSheetOptions.sheetData)
local sprite = display.newSprite(healthSheet, spriteSequence)

sprite:setSequence(spriteSequenceNames.STOPPED)

sprite.x = displayUtil.LEFT_SCREEN + 100
sprite.y = displayUtil.HEIGHT_SCREEN - 80

return sprite