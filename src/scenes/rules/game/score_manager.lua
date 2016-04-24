local importations = require(IMPORTATIONS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)
local listener = require(importations.LISTENER)

local scoreText
local group
local lifeManager
local initialTime

local function _refresh()
    scoreText.text = 'Score: ' .. tostring(os.time() - initialTime)
end

local function _setLifeManager(lf)
    lifeManager = lf
end

local function _createScore(gp)
    group = gp

    initialTime = os.time()

    scoreText = display.newText({
        text = 'Score',
        x = displayConstants.WIDTH_SCREEN - ((lifeManager.MAX_LIFES + 1) * 130),
        y = 60,
        font = (system.getInfo('environment') == 'simulator' and 'FFFTusj-Bold' or 'FFF_Tusj'),
        fontSize = 30
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
    setLifeManager = _setLifeManager
}