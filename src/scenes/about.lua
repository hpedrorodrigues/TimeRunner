local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local fonts = require(importations.FONTS)

local scene = composer.newScene()
local titleFontSize = 60
local subtitleFontSize = 35

local firstDifference = 90
local difference = 60

local function _developedBy(group)
    local developedBy = display.newText({
        text = 'Developed by:',
        x = displayConstants.CENTER_X,
        y = displayConstants.TOP_SCREEN + 100,
        font = fonts.SYSTEM,
        fontSize = titleFontSize
    })

    local developer = display.newText({
        text = 'Pedro Rodrigues',
        x = developedBy.x,
        y = developedBy.y + firstDifference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    local githubDeveloper = display.newText({
        text = 'github.com/hpedrorodrigues',
        x = displayConstants.CENTER_X,
        y = developer.y + difference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    local emailDeveloper = display.newText({
        text = 'hs.pedro.rodrigues@gmail.com',
        x = displayConstants.CENTER_X,
        y = githubDeveloper.y + difference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    group:insert(developedBy)
    group:insert(developer)
    group:insert(githubDeveloper)
    group:insert(emailDeveloper)
end

local function _designedBy(group)
    local designedBy = display.newText({
        text = 'Designed by:',
        x = displayConstants.CENTER_X - 400,
        y = displayConstants.TOP_SCREEN + 400,
        font = fonts.SYSTEM,
        fontSize = titleFontSize
    })

    local firstDesigner = display.newText({
        text = 'Augusto Monteiro',
        x = designedBy.x,
        y = designedBy.y + firstDifference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    local githubFirstDesigner = display.newText({
        text = 'github.com/augustomna2010',
        x = firstDesigner.x,
        y = firstDesigner.y + difference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    local secondDesigner = display.newText({
        text = 'Pedro Rodrigues',
        x = githubFirstDesigner.x,
        y = githubFirstDesigner.y + difference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    local githubSecondDesigner = display.newText({
        text = 'github.com/hpedrorodrigues',
        x = secondDesigner.x,
        y = secondDesigner.y + difference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    group:insert(designedBy)
    group:insert(firstDesigner)
    group:insert(githubFirstDesigner)
    group:insert(secondDesigner)
    group:insert(githubSecondDesigner)
end

local function _songs(group)
    local songs = display.newText({
        text = 'Songs:',
        x = displayConstants.CENTER_X + 300,
        y = displayConstants.TOP_SCREEN + 400,
        font = fonts.SYSTEM,
        fontSize = titleFontSize
    })

    local songsUrl = display.newText({
        text = 'freemusicarchive.org/music/boxcat_games',
        x = songs.x,
        y = songs.y + firstDifference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    group:insert(songs)
    group:insert(songsUrl)
end

local function _images(group)
    local imagesText = display.newText({
        text = 'Images:',
        x = displayConstants.CENTER_X + 300,
        y = displayConstants.TOP_SCREEN + 580,
        font = fonts.SYSTEM,
        fontSize = titleFontSize
    })

    local imagesUrl = display.newText({
        text = 'wallpaper.zone/night-background-images',
        x = imagesText.x,
        y = imagesText.y + firstDifference,
        font = fonts.SYSTEM,
        fontSize = subtitleFontSize
    })

    group:insert(imagesText)
    group:insert(imagesUrl)
end

function scene:create(event)

    local sceneGroup = self.view
    local background = display.newImageRect(images.ABOUT_BACKGROUND, 1800, 900)
    background.x = displayConstants.CENTER_X
    background.y = displayConstants.CENTER_Y

    local backButtonConfiguration = {
        width = 79,
        height = 78,
        alphaNormal = .2,
        alphaClicked = .6,
        difference = 60
    }

    local backButton = display.newImageRect(images.BACK_BUTTON, backButtonConfiguration.width, backButtonConfiguration.height)
    backButton.x = displayConstants.LEFT_SCREEN + backButtonConfiguration.difference
    backButton.y = displayConstants.TOP_SCREEN + backButtonConfiguration.difference
    backButton:addEventListener(listener.TOUCH, function(eventButton)
        if (eventButton.phase == 'began') then
            backButton.alpha = backButtonConfiguration.alphaClicked
        elseif (eventButton.phase == 'ended') then
            backButton.alpha = backButtonConfiguration.alphaNormal
            sceneManager.goMenu()
        end
    end)

    sceneGroup:insert(background)
    sceneGroup:insert(backButton)

    _developedBy(sceneGroup)
    _designedBy(sceneGroup)
    _songs(sceneGroup)
    _images(sceneGroup)

    eventUtil.setBackPressed(sceneManager.goMenu)
end

function scene:destroy(event)

    local sceneGroup = self.view
    sceneGroup:removeSelf()
    sceneGroup = nil

    -- Doing it because is needed but linter not known Corona SDK
    if (sceneGroup ~= nil) then
        print(sceneGroup)
    end
end

scene:addEventListener(listener.CREATE, scene)
scene:addEventListener(listener.DESTROY, scene)

return scene