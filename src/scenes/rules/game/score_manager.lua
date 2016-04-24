local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local listener = require(importations.LISTENER)

local scoreText
local group
local initialTime
local score

local function _refresh()
    score = os.time() - initialTime
    scoreText.text = 'Score: ' .. tostring(score)
end

local function _score()
    if (score == nil) then
        return 0
    else
        return score
    end
end

local function _createScore(gp)
    group = gp

    initialTime = os.time()

    scoreText = display.newText({
        text = 'Score',
        x = displayConstants.LEFT_SCREEN + 250,
        y = 60,
        font = (system.getInfo('environment') == 'simulator' and 'FFFTusj-Bold' or 'FFF_Tusj'),
        fontSize = 40
    })

    group:insert(scoreText)

    Runtime:addEventListener(listener.ENTER_FRAME, _refresh)
end

local function _destroyScore()
    group:remove(scoreText)
    scoreText:removeSelf()
    scoreText = nil

    -- Doing it because is needed but linter not known Corona SDK
    if (scoreText ~= nil) then
        print(scoreText)
    end

    Runtime:removeEventListener(listener.ENTER_FRAME, _refresh)
end

return {
    create = _createScore,
    destroy = _destroyScore,
    score = _score
}