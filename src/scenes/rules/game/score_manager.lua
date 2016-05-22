local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local viewUtil = require(importations.VIEW_UTIL)
local i18n = require(importations.I18N)

local BEAR_SCORE = 5
local TIGER_SCORE = 10
local BIRD_SCORE = 15

local scoreText
local currentScore

local function _increase(score)
    currentScore = currentScore + score
    scoreText.text = i18n.score .. ': ' .. tostring(currentScore)
end

local function _start()
    currentScore = 0
    _increase(currentScore)
end

local function _increaseBearScore()
    _increase(BEAR_SCORE)
end

local function _increaseTigerScore()
    _increase(TIGER_SCORE)
end

local function _increaseBirdScore()
    _increase(BIRD_SCORE)
end

local function _createScoreView(group)
    scoreText = viewUtil.createText({
        text = i18n.score,
        x = displayConstants.LEFT_SCREEN + 250,
        y = displayConstants.TOP_SCREEN + 50,
        fontSize = 35
    })

    group:insert(scoreText)
end

local function _currentScore()
    return currentScore
end

return {
    start = _start,
    createScoreView = _createScoreView,
    currentScore = _currentScore,
    increaseBearScore = _increaseBearScore,
    increaseTigerScore = _increaseTigerScore,
    increaseBirdScore = _increaseBirdScore
}