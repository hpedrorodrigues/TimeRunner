local BASE_FONT_PATH = 'assets/fonts/'

local isSimulator = (system.getInfo('environment') == 'simulator')

return {
    BOLD = isSimulator and BASE_FONT_PATH .. 'Quicksand-Bold' or 'Quicksand-Bold',
    BOLD_ITALIC = isSimulator and BASE_FONT_PATH .. 'Quicksand-BoldItalic' or 'Quicksand-BoldItalic',
    ITALIC = isSimulator and BASE_FONT_PATH .. 'Quicksand-Italic' or 'Quicksand-Italic',
    LIGHT = isSimulator and BASE_FONT_PATH .. 'Quicksand-Light' or 'Quicksand-Light',
    LIGHT_ITALIC = isSimulator and BASE_FONT_PATH .. 'Quicksand-LightItalic' or 'Quicksand-LightItalic',
    REGULAR = isSimulator and BASE_FONT_PATH .. 'Quicksand-Regular' or 'Quicksand-Regular',
    DASH = isSimulator and BASE_FONT_PATH .. 'Quicksand-Dash' or 'QuicksandDash-Regular',
    SYSTEM = isSimulator and BASE_FONT_PATH .. 'Quicksand-Bold' or 'Quicksand-Bold'
}