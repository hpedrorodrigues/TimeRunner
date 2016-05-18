local function _set()
    display.setStatusBar(display.HiddenStatusBar)

    math.randomseed(os.time())

    display.setDefault('anchorX', 0.5)
    display.setDefault('anchorY', 0.5)

    system.activate('multitouch')
end

return {
    set = _set
}