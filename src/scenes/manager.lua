local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)

local transitionConfiguration = { time = 500, effect = 'crossFade' }

local function _removeCurrentScene()
    local currentScene = composer.getSceneName('current')

    if (currentScene ~= nil) then
        composer.removeScene(currentScene)
    end
end

local function _goAbout()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.about', transitionConfiguration)
end

local function _goMenu()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.menu', transitionConfiguration)
end

local function _goGameOver(sc)
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.game_over', {
        time = 500,
        effect = 'crossFade',
        params = { score = sc }
    })
end

local function _goGame()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.game', transitionConfiguration)
end

local function _goSettings()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.settings', transitionConfiguration)
end

local function _goTutorial()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.tutorial', transitionConfiguration)
end

return {
    goMenu = _goMenu,
    goGameOver = _goGameOver,
    goAbout = _goAbout,
    goGame = _goGame,
    goSettings = _goSettings,
    goTutorial = _goTutorial,
    removeCurrentScene = _removeCurrentScene
}