-- Reference: https://docs.coronalabs.com/daily/guide/system/composer/index.html

local composer = require("composer")

local function _removeCurrentScene()
    local currentScene = composer.getSceneName("current")

    if (currentScene ~= nil) then
        composer.removeScene(currentScene)
    end
end

local function _goAbout()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene("src.scenes.about", { time = 500, effect = "crossFade" })
end

local function _goMenu()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene("src.scenes.menu", { time = 500, effect = "crossFade" })
end

local function _goGame()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene("src.scenes.game", { time = 500, effect = "crossFade" })
end

local function _goSettings()
    _removeCurrentScene()
    composer.removeHidden()
    composer.gotoScene("src.scenes.settings", { time = 500, effect = "crossFade" })
end

return {
    goMenu = _goMenu,
    goAbout = _goAbout,
    goGame = _goGame,
    goSettings = _goSettings,
    removeCurrentScene = _removeCurrentScene
}