local sceneManager = require("src.scenes.manager")
local defaults = require("defaults")
local sounds = require("src.constant.sounds")

defaults.set()

--audio.play(audio.loadStream(sounds.ADVENTURE), { loops = -1, fadein = 5000 })

sceneManager.goMenu()