local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local fonts = require(importations.FONTS)
local info = require(importations.INFO)

local titleFontSize = 60
local subtitleFontSize = 35

local firstDifference = 90
local difference = 60

local function _developedByGroup(group)
    local developedBy = display.newText({
        text = info.developedByTitle,
        x = displayConstants.CENTER_X,
        y = displayConstants.TOP_SCREEN + 100,
        font = fonts.SYSTEM,
        fontSize = titleFontSize
    })

    local developerName = display.newText({
        text = info.developerName,
        x = developedBy.x,
        y = developedBy.y + firstDifference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    local developerGithubLink = display.newText({
        text = info.developerGithubLink,
        x = displayConstants.CENTER_X,
        y = developerName.y + difference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    local developerEmail = display.newText({
        text = info.developerEmail,
        x = displayConstants.CENTER_X,
        y = developerGithubLink.y + difference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    group:insert(developedBy)
    group:insert(developerName)
    group:insert(developerGithubLink)
    group:insert(developerEmail)
end

local function _designedByGroup(group)
    local designedBy = display.newText({
        text = info.designedByTitle,
        x = displayConstants.CENTER_X - 400,
        y = displayConstants.TOP_SCREEN + 400,
        font = fonts.SYSTEM,
        fontSize = titleFontSize
    })

    local firstDesignerName = display.newText({
        text = info.firstDesignerName,
        x = designedBy.x,
        y = designedBy.y + firstDifference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    local firstDesignerGithub = display.newText({
        text = info.firstDesignerGithub,
        x = firstDesignerName.x,
        y = firstDesignerName.y + difference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    local secondDesignerName = display.newText({
        text = info.secondDesignerName,
        x = firstDesignerGithub.x,
        y = firstDesignerGithub.y + difference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    local secondDesignerGithub = display.newText({
        text = info.secondDesignerGithub,
        x = secondDesignerName.x,
        y = secondDesignerName.y + difference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    group:insert(designedBy)
    group:insert(firstDesignerName)
    group:insert(firstDesignerGithub)
    group:insert(secondDesignerName)
    group:insert(secondDesignerGithub)
end

local function _songsGroup(group)
    local songs = display.newText({
        text = info.songsTitle,
        x = displayConstants.CENTER_X + 300,
        y = displayConstants.TOP_SCREEN + 400,
        font = fonts.SYSTEM,
        fontSize = titleFontSize
    })

    local songsLink = display.newText({
        text = info.songsLink,
        x = songs.x,
        y = songs.y + firstDifference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    group:insert(songs)
    group:insert(songsLink)
end

local function _imagesGroup(group)
    local images = display.newText({
        text = info.imagesTitle,
        x = displayConstants.CENTER_X + 300,
        y = displayConstants.TOP_SCREEN + 580,
        font = fonts.SYSTEM,
        fontSize = titleFontSize
    })

    local imagesLink = display.newText({
        text = info.imagesLink,
        x = images.x,
        y = images.y + firstDifference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    group:insert(images)
    group:insert(imagesLink)
end

return {
    developedByGroup = _developedByGroup,
    designedByGroup = _designedByGroup,
    songsGroup = _songsGroup,
    imagesGroup = _imagesGroup
}