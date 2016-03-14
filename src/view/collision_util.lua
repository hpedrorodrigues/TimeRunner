local listener = require("src.constant.listener")

local objects
local action
local collisionActionToClear
local throttle = true

local function _hasCollided(obj1, obj2)
    if (obj1 == nil or obj2 == nil) then
        return false
    end

    local dx = math.pow(obj1.x - obj2.x, 2)
    local dy = math.pow(obj1.y - obj2.y, 2)

    local distance = math.sqrt(dx + dy)
    local objectSize = (obj2.contentWidth / 2) + (obj1.contentWidth / 2)

    if (distance < objectSize and throttle) then
        throttle = false
        timer.performWithDelay(1000, function()
            throttle = true
        end)
        return true
    end
    return false
end

local function _collision()
    if (objects ~= nil and action ~= nil and _hasCollided(objects.object1, objects.object2)) then
        action()
    end
end

local function _register(obj, act)
    objects = obj
    action = act
    collisionActionToClear = _collision
    Runtime:addEventListener(listener.ENTER_FRAME, collisionActionToClear)
end

local function _collisionAction()
    return collisionActionToClear
end

return {
    hasCollided = _hasCollided,
    collision = _register,
    action = _collisionAction
}