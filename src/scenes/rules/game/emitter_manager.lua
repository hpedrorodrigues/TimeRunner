local importations = require(IMPORTATIONS)
local json = require(importations.JSON)
local emitters = require(importations.EMITTERS)
local physics = require(importations.PHYSICS)
local listener = require(importations.LISTENER)

local emittersQuantity = 0
local emittersList = {}

local function _loadParams(filename, baseDir)

    local path = system.pathForFile(filename, baseDir)

    local file = io.open(path, 'r')

    local data = file:read('*a')

    file:close()

    return json.decode(data)
end

local function _newEmitter(filename, baseDir)
    return display.newEmitter(_loadParams(filename, baseDir))
end

local function _newShot()
    return _newEmitter(emitters.SHOT)
end

local function _newPortal()
    return _newEmitter(emitters.PORTAL)
end

local function _shoot(sprite)

    local group = display.newGroup()
    group.x = sprite.x
    group.y = sprite.y

    local emitterFireshot = _newShot()
    emitterFireshot.x = group.x
    emitterFireshot.y = group.y

    emittersQuantity = emittersQuantity + 1

    group:insert(emitterFireshot)

    physics.addBody(group, { density = 1, friction = 0 })

    group.isbullet = true
    group.anchorChildren = true
    group.gravityScale = 0

    transition.to(group, { x = display.contentWidth + 150, time = 800 })

    group.myName = 'shot'

    emittersList[emittersQuantity] = group
end

local function _emitterUpdate()

    for i = 1, emittersQuantity do

        local currentPosition = i
        local child = emittersList[currentPosition]

        if (child ~= nil) then

            if (child.x >= display.contentWidth or child.isDeleted) then

                physics.removeBody(child)
                child:removeSelf()
                child = nil
                emittersList[currentPosition] = nil

                -- Doing it because is needed but linter not known Corona SDK
                if (child ~= nil) then
                    print(child)
                end
            end
        end
    end
end

local function _removeAllEmitters()
    for i = 1, emittersQuantity do

        local child = emittersList[i]

        if (child ~= nil) then

            physics.removeBody(child)
            child:removeSelf()
            child = nil
            emittersList[i] = nil

            -- Doing it because is needed but linter not known Corona SDK
            if (child ~= nil) then
                print(child)
            end
        end
    end

    emittersQuantity = 0
    emittersList = {}
end

local function _start()
    Runtime:addEventListener(listener.ENTER_FRAME, _emitterUpdate)
end

local function _cancel()
    Runtime:removeEventListener(listener.ENTER_FRAME, _emitterUpdate)

    _removeAllEmitters()
end

return {
    loadParams = _loadParams,
    newEmitter = _newEmitter,
    shoot = _shoot,
    start = _start,
    cancel = _cancel,
    newPortal = _newPortal,
    newShot = _newShot
}