local physics = require('physics')

physics.start()
physics.setScale(10)
physics.setGravity(0, 0)

local topWall = display.newRect(display.contentWidth / 2, 0, display.contentWidth, 0)
physics.addBody(topWall, "static", { density = 1, friction = 0, bounce = 1, isSensor = false })

local bottomWall = display.newRect(display.contentWidth / 2, display.contentHeight, display.contentWidth, 0)
physics.addBody(bottomWall, "static", { density = 1, friction = 0, bounce = 1, isSensor = false })

local leftWall = display.newRect(2.5, display.contentHeight / 2, 0, display.contentHeight)
physics.addBody(leftWall, "static", { density = 1, friction = 0, bounce = 1, isSensor = false })

local rightWall = display.newRect(display.contentWidth - 2.5, display.contentHeight / 2, 0, display.contentHeight)
physics.addBody(rightWall, "static", { density = 1, friction = 0, bounce = 1, isSensor = false })

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