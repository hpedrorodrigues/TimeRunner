local sounds = require("src.constant.sounds")

local function _cancel(sound)
    if (sound ~= nil) then
        audio.stop(sound)
    end
end

local function _play(soundPath)
    local sound = audio.loadSound(soundPath)

    return audio.play(sound, {
        loops = -1,
        fadein = 5000
    })
end

local function _playBackgroundSound()
    return _play(sounds.ADVENTURE)
end

return {
    playBackgroundSound = _playBackgroundSound,
    cancel = _cancel
}