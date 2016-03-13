local sceneManager = require("src.scenes.manager")
local sounds = require("src.constant.sounds")

audio.play(audio.loadSound(sounds.ADVENTURE), { duration = 0 })

sceneManager.goMenu()

display.setStatusBar(display.HiddenStatusBar)

native.setProperty("androidSystemUiVisibility", "immersive")