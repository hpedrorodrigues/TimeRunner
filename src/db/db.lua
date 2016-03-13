local databaseConstants = require('src.constant.database')
local sqlite3 = require("sqlite3")

local dbPath = system.pathForFile(databaseConstants.DATABASE_NAME, system.DocumentsDirectory)
local db = sqlite3.open(dbPath)

db:exec(databaseConstants.CREATE_SETTINGS_TABLE_SCRIPT)

local function onSystemEvent(event)
    if (event.type == "applicationExit" and db and db:isopen()) then
        db:close()
    end
end

Runtime:addEventListener("system", onSystemEvent)

print("SQLite version: " .. sqlite3.version())

return {
    database = db
}