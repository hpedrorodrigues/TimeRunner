local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local images = require(importations.IMAGES)
local viewUtil = require(importations.VIEW_UTIL)

local MAX_LIFES = 3

local currentLife
local lifeImages

local distance = {
    x = 50,
    y = displayConstants.TOP_SCREEN + 60
}

local function _reset()
    currentLife = MAX_LIFES
end

local function _hasLife()
    return currentLife ~= 0
end

local function _decrease()
    currentLife = currentLife - 1
end

local function _increase()
    currentLife = currentLife + 1
end

local function _current()
    return currentLife
end

local function _createImages(group)
    lifeImages = {}

    for i = 1, MAX_LIFES do

        lifeImages[i] = viewUtil.createImage({
            imagePath = images.LIFE,
            width = 40,
            height = 40,
            x = displayConstants.WIDTH_SCREEN - distance.y,
            y = distance.y
        })

        if (i ~= 1) then
            lifeImages[i].x = lifeImages[i - 1].x - distance.x
        end

        group:insert(lifeImages[i])
    end
end

local function _setVisibilityFromCurrentLife(value)
    lifeImages[_current()].isVisible = value
end

return {
    reset = _reset,
    hasLife = _hasLife,
    decrease = _decrease,
    increase = _increase,
    current = _current,
    MAX_LIFES = MAX_LIFES,
    createImages = _createImages,
    setVisibilityFromCurrentLife = _setVisibilityFromCurrentLife
}