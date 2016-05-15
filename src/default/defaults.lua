local function _set()
    display.setStatusBar(display.HiddenStatusBar)

    math.randomseed(os.time())

    display.setDefault('anchorX', 0.5)
    display.setDefault('anchorY', 0.5)
end

return {
    set = _set
}