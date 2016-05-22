local importations = require(IMPORTATIONS)
local widget = require(importations.WIDGET)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local viewUtil = require(importations.VIEW_UTIL)

local INITIAL_POWER_UP_VALUE = 50
local POWER_UP_VALUE = 10
local MAX_POWER_UP_VALUE = 100

local currentPowerUpValue
local shootProgressView
local shootTextView

local function _start()
    currentPowerUpValue = INITIAL_POWER_UP_VALUE
    viewUtil.setTheme()
end

local function _current()
    return currentPowerUpValue
end

local function _setProgress(value)
    shootProgressView:setProgress(value * 0.01)
    shootTextView.text = tostring(value)
end

local function _reset()
    currentPowerUpValue = INITIAL_POWER_UP_VALUE

    _setProgress(currentPowerUpValue)
end

local function _decrease()
    if (currentPowerUpValue > 0) then
        currentPowerUpValue = currentPowerUpValue - 1
    end

    _setProgress(currentPowerUpValue)
end

local function _increase()
    if (currentPowerUpValue + POWER_UP_VALUE > MAX_POWER_UP_VALUE) then
        currentPowerUpValue = MAX_POWER_UP_VALUE
    else
        currentPowerUpValue = currentPowerUpValue + POWER_UP_VALUE
    end

    _setProgress(currentPowerUpValue)
end

local function _createProgressView(group)
    shootProgressView = widget.newProgressView({
        x = displayConstants.WIDTH_SCREEN - 350,
        y = displayConstants.TOP_SCREEN + 60,
        width = 220,
        isAnimated = true,
        fillXOffset = 0,
        fillYOffset = 0
    })

    shootProgressView.height = 50

    shootTextView = viewUtil.createText({
        text = tostring(INITIAL_POWER_UP_VALUE),
        x = shootProgressView.x,
        y = shootProgressView.y,
        fontSize = 40
    })

    _setProgress(INITIAL_POWER_UP_VALUE)

    group:insert(shootProgressView)
    group:insert(shootTextView)
end

return {
    reset = _reset,
    decrease = _decrease,
    increase = _increase,
    current = _current,
    start = _start,
    createProgressView = _createProgressView
}