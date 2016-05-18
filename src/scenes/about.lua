local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local images = require(importations.IMAGES)
local listener = require(importations.LISTENER)
local eventUtil = require(importations.EVENT_UTIL)
local sceneManager = require(importations.SCENE_MANAGER)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local viewUtil = require(importations.VIEW_UTIL)
local aboutCreator = require(importations.ABOUT_CREATOR)

local scene = composer.newScene()

function scene:create()

    local sceneGroup = self.view
    local background = display.newImageRect(images.ABOUT_BACKGROUND, 1800, 900)

    background.x = displayConstants.CENTER_X
    background.y = displayConstants.CENTER_Y

    local backButton = viewUtil.createBackButton(sceneManager.goMenu)

    sceneGroup:insert(background)
    sceneGroup:insert(backButton)

    aboutCreator.developedByGroup(sceneGroup)
    aboutCreator.designedByGroup(sceneGroup)
    aboutCreator.songsGroup(sceneGroup)
    aboutCreator.imagesGroup(sceneGroup)

    eventUtil.setBackPressed(sceneManager.goMenu)
end

function scene:destroy()

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