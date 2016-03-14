require('src.db.db')

local sceneManager = require("src.scenes.manager")
local defaults = require("defaults")
local soundUtil = require("src.sound.sound_util")
local settings = require('src.db.settings')
local fileUtil = require('src.file.file_util')
local constantUtil = require('src.constant.constant_util')

defaults.set()

if (settings.hasFirstAccess()) then
    sceneManager.goMenu()
else
    settings.insertInitialValues()
    sceneManager.goTutorial()
end

if (settings.isLogsEnabled()) then

    settings.showAllSettings()
    fileUtil.listKnownDirectories()
    constantUtil.listKnownConstantObjects()
end

if (settings.isSoundEnabled()) then
    backgroundSound = soundUtil.playBackgroundSound()
end