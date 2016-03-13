return {
    DATABASE_NAME = "time_runner.db",
    CREATE_SETTINGS_TABLE_SCRIPT = [[
        CREATE TABLE IF NOT EXISTS settings (id INTEGER PRIMARY KEY, key, value INTEGER);
    ]],
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