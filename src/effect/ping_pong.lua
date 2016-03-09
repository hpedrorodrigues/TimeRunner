local physics = require('physics')

physics.start()
physics.setScale(10)
physics.setGravity(0, 0)

local verticalDistance = 50
local horizontalDistance = verticalDistance

local wallConfiguration = { density = 1, friction = 0, bounce = 1, isSensor = false }

local halfWidth = display.contentWidth / 2
local halfHeight = display.contentHeight / 2

local topWall = display.newRect(halfWidth, verticalDistance, display.contentWidth, 0)
local bottomWall = display.newRect(halfWidth, display.contentHeight - verticalDistance, display.contentWidth, 0)
local leftWall = display.newRect(horizontalDistance, halfHeight, 0, display.contentHeight)
local rightWall = display.newRect(display.contentWidth - horizontalDistance, halfHeight, 0, display.contentHeight)

physics.addBody(topWall, "static", wallConfiguration)
physics.addBody(bottomWall, "static", wallConfiguration)
physics.addBody(leftWall, "static", wallConfiguration)
physics.addBody(rightWall, "static", wallConfiguration)

local function _makeEffect(object)
    physics.addBody(object, "dynamic", { density = 1, friction = 0, radius = 0, isSensor = false, bounce = 1 })

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

return {
    make = _makeEffect
}