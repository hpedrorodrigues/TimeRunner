local listener = require("src.constant.listener")

local objects
local action

local function _hasCollided(obj1, obj2)
    if (obj1 == nil or obj2 == nil) then
        return false
    end

    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin
            and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin
            and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin
            and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin
            and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

    return (left or right) and (up or down)
end

local function _collision()
    if (objects ~= nil and action ~= nil and _hasCollided(objects.object1, objects.object2)) then
        action(_collision)
    end
end

local function _register(obj, act)
    objects = obj
    action = act
    Runtime:addEventListener(listener.ENTER_FRAME, _collision)
end

return {
    hasCollided = _hasCollided,
    collision = _register
}