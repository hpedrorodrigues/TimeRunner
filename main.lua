IMPORTATIONS = 'src.constant.importations'

local importations = require(IMPORTATIONS)
local database = require(importations.DATABASE)
local sceneManager = require(importations.SCENE_MANAGER)
local defaults = require(importations.DEFAULTS)
local soundUtil = require(importations.SOUND_UTIL)
local fileUtil = require(importations.FILE_UTIL)
local constantUtil = require(importations.CONSTANT_UTIL)
local memoryUtil = require(importations.MEMORY_UTIL)
local googleAnalyticsManager = require(importations.GOOGLE_ANALYTICS_MANAGER)
local settings = require(importations.SETTINGS)
local adsManager = require(importations.ADS_MANAGER)

database.start()
settings.start()
defaults.set()
googleAnalyticsManager.start()
adsManager.start()

if (settings.hasFirstAccess()) then
    --    sceneManager.goMenu()
else
    database.printSqliteVersion()
    settings.showAllSettings()
    fileUtil.listKnownDirectories()
    constantUtil.listKnownConstantObjects()
    memoryUtil.showMemoryInfo()
    settings.insertInitialValues()
    --    sceneManager.goTutorial()
end

sceneManager.goMenu()

if (settings.isSoundEnabled()) then
    backgroundSound = soundUtil.playBackgroundSound()
end