return {
    DATABASE_NAME = "time_runner.db",
    CREATE_SETTINGS_TABLE_SCRIPT = [[
        CREATE TABLE IF NOT EXISTS settings (id INTEGER PRIMARY KEY, key, value INTEGER);
    ]],
    formatInitialSettings = function(object)
        return [[
            DELETE FROM settings;
            INSERT OR REPLACE INTO settings VALUES (NULL, ']] .. object.firstAccessKey .. [[', 1);
            INSERT OR REPLACE INTO settings VALUES (NULL, ']] .. object.enableSoundKey .. [[', 1);
            INSERT OR REPLACE INTO settings VALUES (NULL, ']] .. object.enableLogsKey .. [[', 1);
        ]]
    end,
    formatDeleteSettingsByKeyScript = function(key)
        return [[ DELETE FROM settings WHERE key = ']] .. key .. [['; ]]
    end,
    formatSelectSettingsByKeyScript = function(key)
        return "SELECT * FROM settings WHERE key = '" .. key .. "'"
    end,
    formatInsertSettingsByKeyScript = function(key, value)
        return [[INSERT INTO settings VALUES (null, ']] .. key .. [[', ']] .. value .. [['); ]]
    end,
    ALL_SETTINGS_SCRIPT = "SELECT * FROM settings",
}