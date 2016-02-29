local function _setBackground(url)
    display.newImage(url, 700, 400, true)
end


return {
    setBackground = _setBackground
}