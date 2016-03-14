local function _set()
    display.setStatusBar(display.HiddenStatusBar)

    native.setProperty("androidSystemUiVisibility", "immersive")

    math.randomseed(os.time())

    display.setDefault("anchorX", 0.5)
    display.setDefault("anchorY", 0.5)
end

return {
    set = _set
}