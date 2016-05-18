local BASE_FONT_PATH = ''

local isSimulator = (system.getInfo('environment') == 'simulator')

local fonts = {
    BOLD = isSimulator and BASE_FONT_PATH .. 'Quicksand-Bold' or 'Quicksand-Bold',
    BOLD_ITALIC = isSimulator and BASE_FONT_PATH .. 'Quicksand-BoldItalic' or 'Quicksand-BoldItalic',
    ITALIC = isSimulator and BASE_FONT_PATH .. 'Quicksand-Italic' or 'Quicksand-Italic'
}

fonts.SYSTEM = fonts.BOLD_ITALIC

return fonts