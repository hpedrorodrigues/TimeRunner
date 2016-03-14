local lfs = require("lfs")

local function _listFiles(path, message)
    print('\n\n')
    print('-----------------------------')
    print(message)
    print('\n')

    if (path == nil) then

        print('Invalid value "nil" for path')
    else

        print('Listing files on path: "', path, '"')

        for file in lfs.dir(path) do
            print("Found file -> " .. file)
        end
    end

    print('-----------------------------')
    print('\n\n')
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