local importations = require(IMPORTATIONS)
local googleAnalytics = require(importations.GOOGLE_ANALYTICS)

local function _start()
    googleAnalytics.init('Time Runner', 'UA-66231011-2')
end

local function _logScreenName(name)
    googleAnalytics.logScreenName(name)
end

local function _logAboutScreen()
    _logScreenName('About')
end

local function _logMenuScreen()
    _logScreenName('Menu')
end

local function _logGameOverScreen()
    _logScreenName('Game Over')
end

local function _logGameScreen()
    _logScreenName('Game')
end

local function _logPreferencesScreen()
    _logScreenName('Preferences')
end

local function _logTutorialScreen()
    _logScreenName('Tutorial')
end

local function _logEvent(action, feature, field, value)
    googleAnalytics.logEvent(action, feature, field, value and 1 or 0)
end

return {
    start = _start,
    logAboutScreen = _logAboutScreen,
    logMenuScreen = _logMenuScreen,
    logGameOverScreen = _logGameOverScreen,
    logGameScreen = _logGameScreen,
    logPreferencesScreen = _logPreferencesScreen,
    logTutorialScreen = _logTutorialScreen,
    logEvent = _logEvent
}