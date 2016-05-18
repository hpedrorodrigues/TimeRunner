local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local i18n = require(importations.I18N)
local viewUtil = require(importations.VIEW_UTIL)

local titleFontSize = 60
local subtitleFontSize = 35

local firstDifference = 90
local difference = 60

local function _developedByGroup(group)
    local developedBy = viewUtil.createText({
        text = i18n.developedByTitle,
        x = displayConstants.CENTER_X,
        y = displayConstants.TOP_SCREEN + 100,
        fontSize = titleFontSize
    })

    local developerName = viewUtil.createText({
        text = i18n.developerName,
        x = developedBy.x,
        y = developedBy.y + firstDifference,
        fontSize = subtitleFontSize
    })

    local developerGithubLink = viewUtil.createText({
        text = i18n.developerGithubLink,
        x = displayConstants.CENTER_X,
        y = developerName.y + difference,
        fontSize = subtitleFontSize
    })

    local developerEmail = viewUtil.createText({
        text = i18n.developerEmail,
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
        text = i18n.designedByTitle,
        x = displayConstants.CENTER_X - 400,
        y = displayConstants.TOP_SCREEN + 400,
        fontSize = titleFontSize
    })

    local firstDesignerName = viewUtil.createText({
        text = i18n.firstDesignerName,
        x = designedBy.x,
        y = designedBy.y + firstDifference,
        fontSize = subtitleFontSize
    })

    local firstDesignerGithub = viewUtil.createText({
        text = i18n.firstDesignerGithub,
        x = firstDesignerName.x,
        y = firstDesignerName.y + difference,
        fontSize = subtitleFontSize
    })

    local secondDesignerName = viewUtil.createText({
        text = i18n.secondDesignerName,
        x = firstDesignerGithub.x,
        y = firstDesignerGithub.y + difference,
        fontSize = subtitleFontSize
    })

    local secondDesignerGithub = viewUtil.createText({
        text = i18n.secondDesignerGithub,
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
        text = i18n.songsTitle,
        x = displayConstants.CENTER_X + 300,
        y = displayConstants.TOP_SCREEN + 400,
        fontSize = titleFontSize
    })

    local songsLink = viewUtil.createText({
        text = i18n.songsLink,
        x = songs.x - 10,
        y = songs.y + firstDifference,
        fontSize = subtitleFontSize
    })

    group:insert(songs)
    group:insert(songsLink)
end

local function _imagesGroup(group)
    local images = viewUtil.createText({
        text = i18n.imagesTitle,
        x = displayConstants.CENTER_X + 300,
        y = displayConstants.TOP_SCREEN + 580,
        fontSize = titleFontSize
    })

    local imagesLink = viewUtil.createText({
        text = i18n.imagesLink,
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