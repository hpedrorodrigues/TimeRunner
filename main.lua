local SnowMaker = require("src.effect.snow")
local ViewUtil = require("src.view.view-util")
local SpriteSequences = require("src.constant.sprite-sequence")
local Listeners = require("src.constant.listener")
local sprite = require("src.sprite.sprite")

ViewUtil.setBackground("./assets/images/Kingdom.jpg")

local mainGroup = display.newGroup()

Runtime:addEventListener(Listeners.ENTER_FRAME, SnowMaker.make)

sprite:play()

mainGroup:insert(sprite)