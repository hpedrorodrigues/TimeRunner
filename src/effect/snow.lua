local transitionHandler

local function _removeFlake(target)
    target:removeSelf()
    target = nil

    -- Doing it because is needed but linter not known Corona SDK
    if (target ~= nil) then
        print(target)
    end
end

local function _spawnSnowFlake()
    local flake = display.newCircle(0, 0, 3)
    local wind = math.random(80) - 40

    flake.x = math.random(display.contentWidth + 1000)
    flake.y = -2

    transitionHandler = transition.to(flake, {
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

local function _cancel()
    if (transitionHandler ~= nil) then
        transition.cancel(transitionHandler)
    end
end


return {
    make = _makeSnow,
    cancel = _cancel
}