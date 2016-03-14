local databaseConstants = require('src.constant.database')
local sqlite3 = require("sqlite3")
local listener = require('src.constant.listener')
local strings = require('src.constant.strings')

local db

local function _init()
    local dbPath = system.pathForFile(databaseConstants.DATABASE_NAME, system.DocumentsDirectory)
    db = sqlite3.open(dbPath)

    db:exec(databaseConstants.CREATE_SETTINGS_TABLE_SCRIPT)

    local function onSystemEvent(event)
        if (event.type == "applicationExit" and db and db:isopen()) then
            db:close()
        end
    end

    Runtime:addEventListener(listener.SYSTEM, onSystemEvent)
end

local function _printSqliteVersion()
    print(strings.BREAK_LINE)
    print(strings.LONG_LINE)
    print("SQLite version: " .. sqlite3.version())
end

local function _database()
    return db
end

return {
    database = _database,
    init = _init,
    printSqliteVersion = _printSqliteVersion
}