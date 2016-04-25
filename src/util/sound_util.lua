local importations = require(IMPORTATIONS)
local sounds = require(importations.SOUNDS)

local function _cancel(sound)
    if (sound ~= nil) then
        audio.stop(sound)
    end
end

local function _playBackgroundSound()
    local sound = audio.loadStream(sounds.ADVENTURE)

    return audio.play(sound, {
        loops = -1,
        fadein = 10000
    })
end

return {
    playBackgroundSound = _playBackgroundSound,
    cancel = _cancel
}