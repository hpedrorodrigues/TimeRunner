local importations = require(IMPORTATIONS)
local databaseConstants = require(importations.DATABASE_CONSTANTS)
local sqlite3 = require(importations.SQLITE3)
local listener = require(importations.LISTENER)
local strings = require(importations.STRINGS)

local db

local function _start()
    local dbPath = system.pathForFile(databaseConstants.DATABASE_NAME, system.DocumentsDirectory)
    db = sqlite3.open(dbPath)

    db:exec(databaseConstants.CREATE_SETTINGS_TABLE_SCRIPT)

    local function onSystemEvent(event)
        if (event.type == 'applicationExit' and db and db:isopen()) then
            db:close()
        end
    end

    Runtime:addEventListener(listener.SYSTEM, onSystemEvent)
end

local function _printSqliteVersion()
    print(strings.BREAK_LINE)
    print(strings.LONG_LINE)
    print('SQLite version: ' .. sqlite3.version())
end

local function _database()
    return db
end

return {
    database = _database,
    start = _start,
    printSqliteVersion = _printSqliteVersion
}