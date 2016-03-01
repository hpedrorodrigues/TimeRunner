local composer = require("composer")
local viewUtil = require("src.view.view_util")
local images = require("src.constant.images")
local listener = require("src.constant.listener")

local scene = composer.newScene()

function scene:create(event)

    local sceneGroup = self.view
    local background = viewUtil.setBackground(images.MENU_BACKGROUND)

    sceneGroup:insert(background)
end

function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

        -- Called when the scene is still off screen (but is about to come on screen).
    elseif (phase == "did") then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end

function scene:hide(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif (phase == "did") then

        -- Called immediately after scene goes off screen.
    end
end

function scene:destroy(event)

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

scene:addEventListener(listener.CREATE, scene)
scene:addEventListener(listener.SHOW, scene)
scene:addEventListener(listener.HIDE, scene)
scene:addEventListener(listener.DESTROY, scene)

return scene