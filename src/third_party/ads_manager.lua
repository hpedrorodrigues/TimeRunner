local importations = require(IMPORTATIONS)
local ads = require(importations.ADS)

local APP_ID = 'ca-app-pub-1400363074358864~8485068036'

local PREFERENCES_BANNER = 'ca-app-pub-1400363074358864/6868734039'
local GAME_OVER_BANNER = 'ca-app-pub-1400363074358864/2438534439'

local SUPPORTED_SCREENS = {
    PREFERENCES = 'preferences',
    GAME_OVER = 'game_over'
}

local screenName

local function _adsListener(event)
    if (event.phase == 'init') then
        print('Corona Ads event: ad for "' .. tostring(event.placementId) .. '" placement requested')
    elseif (event.phase == 'found') then
        print('Corona Ads event: ad for "' .. tostring(event.placementId) .. '" placement found')
    elseif (event.phase == 'failed') then
        print('Corona Ads event: ad for "' .. tostring(event.placementId) .. '" placement not found')
    elseif (event.phase == 'shown') then
        print('Corona Ads event: ad for "' .. tostring(event.placementId) .. '" placement has shown')
    elseif (event.phase == 'closed') then
        print('Corona Ads event: ad for "' .. tostring(event.placementId) .. '" placement closed/hidden')
    end
end

local function _start()
    ads.init(APP_ID, _adsListener)
end

local function _hide()
    if (screenName == SUPPORTED_SCREENS.PREFERENCES) then

        ads.hide(PREFERENCES_BANNER)
    elseif (screenName == SUPPORTED_SCREENS.GAME_OVER) then

        ads.hide(GAME_OVER_BANNER)
    end
end

local function _show()
    if (screenName == SUPPORTED_SCREENS.PREFERENCES) then

        ads.show(PREFERENCES_BANNER, false)
    elseif (screenName == SUPPORTED_SCREENS.GAME_OVER) then

        ads.show(GAME_OVER_BANNER, false)
    end
end

local function _set(sn)
    screenName = sn
    _show()
end

return {
    start = _start,
    hide = _hide,
    set = _set,
    SUPPORTED_SCREENS = SUPPORTED_SCREENS
}