return {
    DATABASE_NAME = 'time_runner.db',
    ALL_SETTINGS_SCRIPT = 'SELECT * FROM settings',
    CREATE_SETTINGS_TABLE_SCRIPT = [[
        CREATE TABLE IF NOT EXISTS settings (id INTEGER PRIMARY KEY, key, value INTEGER);
    ]],
    formatInitialSettingsScript = function(object)
        return [[
            INSERT OR REPLACE INTO settings VALUES (NULL, ']] .. object.firstAccessKey .. [[', 1);
            INSERT OR REPLACE INTO settings VALUES (NULL, ']] .. object.enableSoundKey .. [[', 1);
        ]]
    end,
    formatDeleteSettingsByKeyScript = function(key)
        return [[ DELETE FROM settings WHERE key = ']] .. key .. [['; ]]
    end,
    formatSelectSettingsByKeyScript = function(key)
        return 'SELECT * FROM settings WHERE key = "' .. key .. '"'
    end,
    formatInsertSettingsByKeyScript = function(key, value)
        return [[INSERT INTO settings VALUES (null, ']] .. key .. [[', ']] .. value .. [['); ]]
    end
}