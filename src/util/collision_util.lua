local importations = require(IMPORTATIONS)
local listener = require(importations.LISTENER)

local INITIAL_SIZE = 1

local action
local collisionActionToClear
local objects = {}
local throttle = {}
local size = INITIAL_SIZE

local function _clearFields()
    size = INITIAL_SIZE
    objects = {}
    throttle = {}
end

local function _hasCollided(obj1, obj2)
    if (obj1 == nil or obj2 == nil) then
        return false
    end

    local dx = math.pow(obj1.x - obj2.x, 2)
    local dy = math.pow(obj1.y - obj2.y, 2)

    local distance = math.sqrt(dx + dy)
    local objectSize = (obj2.contentWidth / 2) + (obj1.contentWidth / 2)

    local throttlePosition = obj1.myName .. obj2.myName

    if (distance < objectSize and (throttle[throttlePosition] == nil or throttle[throttlePosition] == false)) then
        throttle[throttlePosition] = true
        timer.performWithDelay(1000, function()
            throttle[throttlePosition] = false
        end)
        return true
    end
    return false
end

local function _collision()
    if (size >= INITIAL_SIZE) then

        for i = INITIAL_SIZE, size - 1 do

            if (objects ~= nil and objects[i] ~= nil) then

                local obj1 = objects[i].object1
                local obj2 = objects[i].object2

                if (action ~= nil and _hasCollided(obj1, obj2)) then
                    action()
                end
            end
        end
    end
end

local function _register(obj, act)
    objects[size] = obj
    size = size + 1
    action = act
    collisionActionToClear = _collision
    Runtime:addEventListener(listener.ENTER_FRAME, collisionActionToClear)
end

local function _collisionAction()
    _clearFields()
    return collisionActionToClear
end

return {
    hasCollided = _hasCollided,
    collision = _register,
    action = _collisionAction
}