local importations = require(IMPORTATIONS)
local strings = require(importations.STRINGS)
local lfs = require(importations.LFS)

local function _listFiles(path, message)
    print(strings.BREAK_LINES)
    print(strings.LONG_LINE)
    print(message)
    print(strings.BREAK_LINE)

    if (path == nil) then

        print('Invalid value "nil" for path')
    else

        print('Listing files on path: "', path, '"')

        for file in lfs.dir(path) do
            print("Found file -> " .. file)
        end
    end

    print(strings.LONG_LINE)
    print(strings.BREAK_LINES)
end

local function _listDocumentsDirectory()
    _listFiles(system.pathForFile("", system.DocumentsDirectory), 'DocumentsDirectory')
end

local function _listResourcesDirectory()
    _listFiles(system.pathForFile("", system.ResourceDirectory), 'ResourceDirectory')
end

local function _listTemporaryDirectory()
    _listFiles(system.pathForFile("", system.TemporaryDirectory), 'TemporaryDirectory')
end

local function _listCachesDirectory()
    _listFiles(system.pathForFile("", system.CachesDirectory), 'CachesDirectory')
end

local function _listKnownDirectories()
    _listDocumentsDirectory()
    _listResourcesDirectory()
    _listTemporaryDirectory()
    _listCachesDirectory()
end

return {
    listKnownDirectories = _listKnownDirectories
}