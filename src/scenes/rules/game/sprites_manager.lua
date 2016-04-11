local importations = require(IMPORTATIONS)
local bearSpriteManager = require(importations.BEAR_SPRITE)
local tigerSpriteManager = require(importations.TIGER_SPRITE)

local function _createBearSprite()
    return bearSpriteManager.create()
end

local function _createTigerSprite()
    return tigerSpriteManager.create()
end

return {
    createBearSprite = _createBearSprite,
    createTigerSprite = _createTigerSprite
}