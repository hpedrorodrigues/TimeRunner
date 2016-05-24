local importations = require(IMPORTATIONS)
local composer = require(importations.COMPOSER)
local googleAnalyticsManager = require(importations.GOOGLE_ANALYTICS_MANAGER)

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
    googleAnalyticsManager.logAboutScreen()
end

local function _goMenu()
    collectgarbage('collect')
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.menu', transitionConfiguration)
    googleAnalyticsManager.logMenuScreen()
end

local function _goGameOver(score)
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.game_over', {
        time = transitionConfiguration.time,
        effect = transitionConfiguration.effect,
        params = { score = score }
    })
    googleAnalyticsManager.logGameOverScreen()
end

local function _goGame()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.game', transitionConfiguration)
    googleAnalyticsManager.logGameScreen()
end

local function _goPreferences()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.preferences', transitionConfiguration)
    googleAnalyticsManager.logPreferencesScreen()
end

local function _goTutorial()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene('src.scenes.tutorial', transitionConfiguration)
    googleAnalyticsManager.logTutorialScreen()
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