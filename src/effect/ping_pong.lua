local importations = require(IMPORTATIONS)
local physics = require(importations.PHYSICS)

local topWall
local bottomWall
local leftWall
local rightWall
local object

local function _makeEffect(obj)
    object = obj

    physics.start()
    physics.setScale(10)
    physics.setGravity(0, 0)

    local verticalDistance = 50
    local horizontalDistance = verticalDistance

    local wallConfiguration = { density = 1, friction = 0, bounce = 1, isSensor = false }

    local halfWidth = display.contentWidth / 2
    local halfHeight = display.contentHeight / 2

    topWall = display.newRect(halfWidth, verticalDistance, display.contentWidth, 0)
    bottomWall = display.newRect(halfWidth, display.contentHeight - verticalDistance, display.contentWidth, 0)
    leftWall = display.newRect(horizontalDistance, halfHeight, 0, display.contentHeight)
    rightWall = display.newRect(display.contentWidth - horizontalDistance, halfHeight, 0, display.contentHeight)

    physics.addBody(topWall, 'static', wallConfiguration)
    physics.addBody(bottomWall, 'static', wallConfiguration)
    physics.addBody(leftWall, 'static', wallConfiguration)
    physics.addBody(rightWall, 'static', wallConfiguration)

    physics.addBody(object, 'dynamic', { density = 1, friction = 0, radius = 0, isSensor = false, bounce = 1 })

    local launchx = math.random(10, 15)
    local launchy = math.random(10, 15)

    if (math.random(0, 5) == 0) then
        launchx = -launchx
    end

    if (math.random(0, 5) == 0) then
        launchy = -launchy
    end

    object:applyLinearImpulse(launchx, launchy)
end

local function _cancel()
    local walls = { topWall, leftWall, rightWall, bottomWall, object }

    for i, wall in ipairs(walls) do

        if (wall ~= nil) then
            physics.removeBody(wall)

            wall = nil

            -- Doing it because is needed but linter not known Corona SDK
            if (wall ~= nil) then
                print(wall)
            end
        end
    end

    physics.stop()
end

return {
    make = _makeEffect,
    cancel = _cancel
}