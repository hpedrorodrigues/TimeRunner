local importations = require(IMPORTATIONS)
local databaseConstants = require(importations.DATABASE_CONSTANTS)
local databaseManager = require(importations.DATABASE)
local strings = require(importations.STRINGS)

local database = databaseManager.database()

local FIRST_ACCESS_KEY = "first_access"
local ENABLE_SOUND_KEY = "enable_sound"
local ENABLE_LOGS_KEY = "enable_logs"

local TRUE = 1
local FALSE = 0

local function _insertInitialValues()
    database:exec(databaseConstants.formatInitialSettings({
        firstAccessKey = FIRST_ACCESS_KEY,
        enableSoundKey = ENABLE_SOUND_KEY,
        enableLogsKey = ENABLE_LOGS_KEY
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

-- Enable Logs

local function _setEnableLogs(value)
    _setSettingByKey(ENABLE_LOGS_KEY, value)
end

local function _enableLogs()
    _setEnableLogs(TRUE)
end

local function _disableLogs()
    _setEnableLogs(FALSE)
end

local function _isLogsEnabled()
    return _getSettingByKey(ENABLE_LOGS_KEY) == TRUE
end

return {
    insertInitialValues = _insertInitialValues,
    enableSound = _enableSound,
    disableSound = _disableSound,
    isSoundEnabled = _isSoundEnabled,
    insertFirstAccess = _insertFirstAccess,
    hasFirstAccess = _hasFirstAccess,
    showAllSettings = _showAllSettings,
    enableLogs = _enableLogs,
    disableLogs = _disableLogs,
    isLogsEnabled = _isLogsEnabled
}