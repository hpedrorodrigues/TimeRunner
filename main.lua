local sceneManager = require("src.scenes.manager")
local sounds = require("src.constant.sounds")

audio.play(audio.loadStream(sounds.ADVENTURE), { loops = -1, fadein = 5000 })

sceneManager.goMenu()

display.setStatusBar(display.HiddenStatusBar)

native.setProperty("androidSystemUiVisibility", "immersive")

math.randomseed(os.time())

display.setDefault("anchorX", 0.5)
display.setDefault("anchorY", 0.5)