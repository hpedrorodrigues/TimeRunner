local importations = require(IMPORTATIONS)
local ads = require(importations.ADS)

local APP_KEY = 'b577d563-b843-447c-a470-fbb59dd075e4'

local PREFERENCES_BANNER = 'bottom-banner-320x50'
local GAME_OVER_BANNER = 'interstitial-1'
local ABOUT_BANNER = PREFERENCES_BANNER

local SUPPORTED_SCREENS = {
    PREFERENCES = 'preferences',
    GAME_OVER = 'game_over',
    ABOUT = 'about'
}

local screenName

local function _adsListener(event)
    if (event.phase == 'init') then
        print('Corona Ads event: initialization successful')
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
    ads.init(APP_KEY, _adsListener)
end

local function _hide()
    if (screenName == SUPPORTED_SCREENS.PREFERENCES) then

        ads.hide(PREFERENCES_BANNER)
    elseif (screenName == SUPPORTED_SCREENS.GAME_OVER) then

        ads.hide(GAME_OVER_BANNER)
    elseif (screenName == SUPPORTED_SCREENS.ABOUT) then

        ads.hide(ABOUT_BANNER)
    end
end

local function _show(sn)
    screenName = sn
    if (screenName == SUPPORTED_SCREENS.PREFERENCES) then

        ads.show(PREFERENCES_BANNER, false)
    elseif (screenName == SUPPORTED_SCREENS.GAME_OVER) then

        ads.show(GAME_OVER_BANNER, false)
    elseif (screenName == SUPPORTED_SCREENS.ABOUT) then

        ads.show(ABOUT_BANNER, true)
    end
end

return {
    start = _start,
    hide = _hide,
    show = _show,
    SUPPORTED_SCREENS = SUPPORTED_SCREENS
}