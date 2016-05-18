local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local info = require(importations.INFO)
local viewUtil = require(importations.VIEW_UTIL)

local titleFontSize = 60
local subtitleFontSize = 35

local firstDifference = 90
local difference = 60

local function _developedByGroup(group)
    local developedBy = viewUtil.createText({
        text = info.developedByTitle,
        x = displayConstants.CENTER_X,
        y = displayConstants.TOP_SCREEN + 100,
        fontSize = titleFontSize
    })

    local developerName = viewUtil.createText({
        text = info.developerName,
        x = developedBy.x,
        y = developedBy.y + firstDifference,
        fontSize = subtitleFontSize
    })

    local developerGithubLink = viewUtil.createText({
        text = info.developerGithubLink,
        x = displayConstants.CENTER_X,
        y = developerName.y + difference,
        fontSize = subtitleFontSize
    })

    local developerEmail = viewUtil.createText({
        text = info.developerEmail,
        x = displayConstants.CENTER_X,
        y = developerGithubLink.y + difference,
        fontSize = subtitleFontSize
    })

    group:insert(developedBy)
    group:insert(developerName)
    group:insert(developerGithubLink)
    group:insert(developerEmail)
end

local function _designedByGroup(group)
    local designedBy = viewUtil.createText({
        text = info.designedByTitle,
        x = displayConstants.CENTER_X - 400,
        y = displayConstants.TOP_SCREEN + 400,
        fontSize = titleFontSize
    })

    local firstDesignerName = viewUtil.createText({
        text = info.firstDesignerName,
        x = designedBy.x,
        y = designedBy.y + firstDifference,
        fontSize = subtitleFontSize
    })

    local firstDesignerGithub = viewUtil.createText({
        text = info.firstDesignerGithub,
        x = firstDesignerName.x,
        y = firstDesignerName.y + difference,
        fontSize = subtitleFontSize
    })

    local secondDesignerName = viewUtil.createText({
        text = info.secondDesignerName,
        x = firstDesignerGithub.x,
        y = firstDesignerGithub.y + difference,
        fontSize = subtitleFontSize
    })

    local secondDesignerGithub = viewUtil.createText({
        text = info.secondDesignerGithub,
        x = secondDesignerName.x,
        y = secondDesignerName.y + difference,
        fontSize = subtitleFontSize
    })

    group:insert(designedBy)
    group:insert(firstDesignerName)
    group:insert(firstDesignerGithub)
    group:insert(secondDesignerName)
    group:insert(secondDesignerGithub)
end

local function _songsGroup(group)
    local songs = viewUtil.createText({
        text = info.songsTitle,
        x = displayConstants.CENTER_X + 300,
        y = displayConstants.TOP_SCREEN + 400,
        fontSize = titleFontSize
    })

    local songsLink = viewUtil.createText({
        text = info.songsLink,
        x = songs.x - 10,
        y = songs.y + firstDifference,
        fontSize = subtitleFontSize
    })

    group:insert(songs)
    group:insert(songsLink)
end

local function _imagesGroup(group)
    local images = viewUtil.createText({
        text = info.imagesTitle,
        x = displayConstants.CENTER_X + 300,
        y = displayConstants.TOP_SCREEN + 580,
        fontSize = titleFontSize
    })

    local imagesLink = viewUtil.createText({
        text = info.imagesLink,
        x = images.x,
        y = images.y + firstDifference,
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