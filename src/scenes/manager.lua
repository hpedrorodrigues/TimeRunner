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
    googleAnalytics.logScreenName('About')
end

local function _goMenu()
    collectgarbage('collect')
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.menu', transitionConfiguration)
    googleAnalytics.logScreenName('Menu')
end

local function _goGameOver(score)
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.game_over', {
        time = transitionConfiguration.time,
        effect = transitionConfiguration.effect,
        params = { score = score }
    })
    googleAnalytics.logScreenName('Game Over')
end

local function _goGame()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.game', transitionConfiguration)
    googleAnalytics.logScreenName('Game')
end

local function _goPreferences()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.preferences', transitionConfiguration)
    googleAnalytics.logScreenName('Preferences')
end

local function _goTutorial()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.tutorial', transitionConfiguration)
    googleAnalytics.logScreenName('Tutorial')
end

return {
    goMenu = _goMenu,
    goGameOver = _goGameOver,
    goAbout = _goAbout,
    goGame = _goGame,
    goPreferences = _goPreferences,
    goTutorial = _goTutorial,
    removeCurrentScene = _removeCurrentScene
}