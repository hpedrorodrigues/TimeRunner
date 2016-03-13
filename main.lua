require('src.db.db')

local sceneManager = require("src.scenes.manager")
local defaults = require("defaults")
local sounds = require("src.constant.sounds")
local settings = require('src.db.settings')

settings.showAllSettings()

if (not settings.hasFirstAccess()) then
    settings.insertFirstAccess()
end

defaults.set()

if (settings.isSoundEnabled()) then
    backgroundSound = audio.play(audio.loadStream(sounds.ADVENTURE), { loops = -1, fadein = 5000 })
end

sceneManager.goMenu()