local sceneManager = require("src.scenes.manager")
local sounds = require("src.constant.sounds")

audio.play(audio.loadStream(sounds.ADVENTURE), { loops = -1, fadein = 5000 })

sceneManager.goMenu()

display.setStatusBar(display.HiddenStatusBar)

native.setProperty("androidSystemUiVisibility", "immersive")