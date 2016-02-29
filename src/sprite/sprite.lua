-- Reference: https://docs.coronalabs.com/api/library/graphics/newImageSheet.html

local spriteSequenceNames = require("src.constant.sprite-sequence")
local displayUtil = require("src.view.display-util")

local imageSheetOptions = {
    sheetData = {
        frames = {
            {
                name = "1",
                x = 260,
                y = 0,
                width = 70,
                height = 125,
                sourceX = 0,
                sourceY = 0,
                sourceWidth = 53,
                sourceHeight = 128
            }, {
                name = "2",
                x = 205,
                y = 0,
                width = 53,
                height = 128,
                sourceX = 0,
                sourceY = 0,
                sourceWidth = 53,
                sourceHeight = 128
            }, {
                name = "3",
                x = 144,
                y = 0,
                width = 59,
                height = 128,
                sourceX = 0,
                sourceY = 0,
                sourceWidth = 59,
                sourceHeight = 128
            }, {
                name = "4",
                x = 0,
                y = 130,
                width = 78,
                height = 123,
                sourceX = 4,
                sourceY = 2,
                sourceWidth = 88,
                sourceHeight = 128
            }, {
                name = "5",
                x = 0,
                y = 130,
                width = 78,
                height = 123,
                sourceX = 4,
                sourceY = 2,
                sourceWidth = 88,
                sourceHeight = 128
            }, {
                name = "6",
                x = 0,
                y = 130,
                width = 78,
                height = 123,
                sourceX = 4,
                sourceY = 2,
                sourceWidth = 88,
                sourceHeight = 128
            }, {
                name = "7",
                x = 0,
                y = 130,
                width = 78,
                height = 123,
                sourceX = 4,
                sourceY = 2,
                sourceWidth = 88,
                sourceHeight = 128
            }, {
                name = "8",
                x = 0,
                y = 130,
                width = 78,
                height = 123,
                sourceX = 4,
                sourceY = 2,
                sourceWidth = 88,
                sourceHeight = 128
            }, {
                name = "9",
                x = 0,
                y = 130,
                width = 80,
                height = 130,
                sourceX = 2,
                sourceY = 2,
                sourceWidth = 30,
                sourceHeight = 140
            }, {
                name = "10",
                x = 0,
                y = 130,
                width = 78,
                height = 123,
                sourceX = 4,
                sourceY = 2,
                sourceWidth = 88,
                sourceHeight = 128
            }
        },
        sheetContentWidth = 512,
        sheetContentHeight = 256
    }
}

local spriteSequence = {
    {
        name = spriteSequenceNames.STOPPED,
        frames = { 1, 2, 3 },
        time = 3000,
        loopCount = 0
    }, {
        name = spriteSequenceNames.RUNNING,
        frames = { 4, 5, 6, 7, 8, 9, 10 },
        time = 3000,
        loopCount = 0
    }
}

local healthSheet = graphics.newImageSheet("./assets/images/Running.png", imageSheetOptions.sheetData)
local sprite = display.newSprite(healthSheet, spriteSequence)

sprite:setSequence(spriteSequenceNames.STOPPED)

sprite.x = displayUtil.LEFT_SCREEN + 100
sprite.y = displayUtil.HEIGHT_SCREEN - 80

return sprite