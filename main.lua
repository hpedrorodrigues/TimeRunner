local sceneManager = require("src.scenes.manager")

sceneManager.goMenu()

display.setStatusBar(display.HiddenStatusBar)

native.setProperty("androidSystemUiVisibility", "immersive")