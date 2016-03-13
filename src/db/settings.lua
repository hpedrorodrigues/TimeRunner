local databaseConstants = require('src.constant.database')
local databaseManager = require('src.db.db')

local database = databaseManager.database

local FIRST_ACCESS_KEY = "first_access"
local ENABLE_SOUND_KEY = "enable_sound"

local TRUE = 1
local FALSE = 0

local function _insertInitialValues()
    database:exec(databaseConstants.formatInitialSettings({
        firstAccessKey = FIRST_ACCESS_KEY,
        enableSoundKey = ENABLE_SOUND_KEY
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
    for row in database:nrows(databaseConstants.ALL_SETTINGS_SCRIPT) do
        print('Setting -> Id: ' .. tostring(row.id) .. ' - Key: ' .. row.key .. ' - Value: ' .. tostring(row.value))
    end
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

return {
    insertInitialValues = _insertInitialValues,
    enableSound = _enableSound,
    disableSound = _disableSound,
    isSoundEnabled = _isSoundEnabled,
    insertFirstAccess = _insertFirstAccess,
    hasFirstAccess = _hasFirstAccess,
    showAllSettings = _showAllSettings
}