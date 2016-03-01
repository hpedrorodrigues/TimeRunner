-- Reference: https://docs.coronalabs.com/daily/guide/system/composer/index.html

local composer = require("composer")

local function _goAbout()
    composer.gotoScene("src.scenes.about")
end

local function _goMenu()
    composer.gotoScene("src.scenes.menu")
end

local function _goGame()
    composer.gotoScene("src.scenes.game")
end

local function _goSettings()
    composer.gotoScene("src.scenes.settings")
end

return {
    goMenu = _goMenu,
    goAbout = _goAbout,
    goGame = _goGame,
    goSettings = _goSettings
}