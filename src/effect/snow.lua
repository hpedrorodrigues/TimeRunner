local function _removeFlake(target)
    target:removeSelf()
    target = nil
end

local function _spawnSnowFlake()
    local flake = display.newCircle(0, 0, 3)
    local wind = math.random(80) - 40

    flake.x = math.random(display.contentWidth + 1000)
    flake.y = -2

    transition.to(flake, {
        time = math.random(3000) + 3000,
        y = display.contentHeight + 2,
        x = flake.x + wind,
        onComplete = _removeFlake
    })
end

local function _makeSnow()
    _spawnSnowFlake()
    return true
end


return {
    make = _makeSnow
}