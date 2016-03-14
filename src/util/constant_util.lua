local importations = require(IMPORTATIONS)
local images = require(importations.IMAGES)
local databaseConstants = require(importations.DATABASE_CONSTANTS)
local listener = require(importations.LISTENER)
local sounds = require(importations.SOUNDS)
local spriteSequences = require(importations.SPRITE_SEQUENCE)
local strings = require(importations.STRINGS)
local displayConstants = require(importations.DISPLAY_CONSTANTS)

local function _listProperties(obj, message)
    print(strings.BREAK_LINES)
    print(strings.LONG_LINE)
    print(message)
    print(strings.BREAK_LINE)

    for k, v in pairs(obj) do

        print('Key: ' .. k)

        local valueType = type(v)

        if (valueType == 'function') then

            print('Value: [Function]')
        elseif (valueType == 'userdata') then

            print('Value: [UserData]')
        elseif (valueType == 'table') then

            print('Value: [Table]')
        else

            print('Value: ' .. v)
        end
    end

    print(strings.LONG_LINE)
    print(strings.BREAK_LINES)
end

local function _listImagesObject()
    _listProperties(images, 'Images')
end

local function _listDatabaseObject()
    _listProperties(databaseConstants, 'Database constants')
end

local function _listListenerObject()
    _listProperties(listener, 'Listeners')
end

local function _listSoundObject()
    _listProperties(sounds, 'Sounds')
end

local function _listSpriteSequencesObject()
    _listProperties(spriteSequences, 'Sprite sequences')
end

local function _listStringsObject()
    _listProperties(strings, 'Strings')
end

local function _listDisplayUtilObject()
    _listProperties(displayConstants, 'Display Constants')
end

local function _listKnownConstantObjects()
    _listImagesObject()
    _listDatabaseObject()
    _listListenerObject()
    _listSoundObject()
    _listSpriteSequencesObject()
    _listStringsObject()
    _listDisplayUtilObject()
end

return {
    listKnownConstantObjects = _listKnownConstantObjects
}