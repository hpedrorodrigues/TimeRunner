local importations = require(IMPORTATIONS)
local databaseConstants = require(importations.DATABASE_CONSTANTS)
local databaseManager = require(importations.DATABASE)
local strings = require(importations.STRINGS)

local database

local FIRST_ACCESS_KEY = 'first_access'
local ENABLE_SOUND_KEY = 'enable_sound'
local ENABLE_VIBRATION_KEY = 'enable_vibration'
local ENABLE_LARGE_SPRITES_KEY = 'enable_large_sprites'

local TRUE = 1
local FALSE = 0

local function _start()
    database = databaseManager.database()
end

local function _insertInitialValues()
    database:exec(databaseConstants.formatInitialSettingsScript({
        firstAccessKey = FIRST_ACCESS_KEY,
        enableSoundKey = ENABLE_SOUND_KEY,
        enableVibrationKey = ENABLE_VIBRATION_KEY,
        enableLargeSpritesKey = ENABLE_LARGE_SPRITES_KEY
    }))
end

local function _getSettingByKey(key)
    for row in database:nrows(databaseConstants.formatSelectSettingsByKeyScript(key)) do
        return row.value
    end

    return FALSE
end

local function _setSettingByKey(key, value)
    database:exec(databaseConstants.formatDeleteSettingsByKeyScript(key))
    database:exec(databaseConstants.formatInsertSettingsByKeyScript(key, value))
end

local function _showAllSettings()
    print(strings.BREAK_LINES)
    print(strings.LONG_LINE)
    print('Existent settings on db')
    print(strings.BREAK_LINE)

    for row in database:nrows(databaseConstants.ALL_SETTINGS_SCRIPT) do

        print('Setting -> Id: ' .. tostring(row.id) .. ' - Key: ' .. row.key .. ' - Value: ' .. tostring(row.value))
    end

    print(strings.LONG_LINE)
    print(strings.BREAK_LINES)
end

-- First Access

local function _insertFirstAccess()
    _setSettingByKey(FIRST_ACCESS_KEY, TRUE)
end

local function _hasFirstAccess()
    return _getSettingByKey(FIRST_ACCESS_KEY) == TRUE
end

-- Enable Sound

local function _setEnableSound(value)
    _setSettingByKey(ENABLE_SOUND_KEY, value)
end

local function _enableSound()
    _setEnableSound(TRUE)
end

local function _disableSound()
    _setEnableSound(FALSE)
end

local function _isSoundEnabled()
    return _getSettingByKey(ENABLE_SOUND_KEY) == TRUE
end

-- Enable Vibration

local function _setEnableVibration(value)
    _setSettingByKey(ENABLE_VIBRATION_KEY, value)
end

local function _enableVibration()
    _setEnableVibration(TRUE)
end

local function _disableVibration()
    _setEnableVibration(FALSE)
end

local function _isVibrationEnabled()
    return _getSettingByKey(ENABLE_VIBRATION_KEY) == TRUE
end

-- Enable Large Sprites

local function _setEnableLargeSprites(value)
    _setSettingByKey(ENABLE_LARGE_SPRITES_KEY, value)
end

local function _enableLargeSprites()
    _setEnableLargeSprites(TRUE)
end

local function _disableLargeSprites()
    _setEnableLargeSprites(FALSE)
end

local function _isLargeSpritesEnabled()
    return _getSettingByKey(ENABLE_LARGE_SPRITES_KEY) == TRUE
end

return {
    start = _start,
    insertInitialValues = _insertInitialValues,
    enableSound = _enableSound,
    disableSound = _disableSound,
    isSoundEnabled = _isSoundEnabled,
    enableVibration = _enableVibration,
    disableVibration = _disableVibration,
    isVibrationEnabled = _isVibrationEnabled,
    enableLargeSprites = _enableLargeSprites,
    disableLargeSprites = _disableLargeSprites,
    isLargeSpritesEnabled = _isLargeSpritesEnabled,
    insertFirstAccess = _insertFirstAccess,
    hasFirstAccess = _hasFirstAccess,
    showAllSettings = _showAllSettings
}