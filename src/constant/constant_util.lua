local images = require("src.constant.images")
local databaseConstants = require('src.constant.database')
local listener = require("src.constant.listener")
local sounds = require("src.constant.sounds")
local spriteSequences = require("src.constant.sprite_sequence")

local function _listProperties(obj, message)
    print('\n\n')
    print('-----------------------------')
    print(message)
    print('\n')

    for k, v in pairs(obj) do

        print('Key: ' .. k)

        if (type(v) == 'function') then

            print('Value: [Function]')
        else

            print('Value: ' .. v)
        end
    end

    print('-----------------------------')
    print('\n\n')
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

local function _listKnownConstantObjects()
    _listImagesObject()
    _listDatabaseObject()
    _listListenerObject()
    _listSoundObject()
    _listSpriteSequencesObject()
end

return {
    listKnownConstantObjects = _listKnownConstantObjects
}