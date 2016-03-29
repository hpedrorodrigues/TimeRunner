local importations = require(IMPORTATIONS)
local listener = require(importations.LISTENER)
local strings = require(importations.STRINGS)

local function _showMemoryInfo()
    print(strings.BREAK_LINE)
    print(strings.LONG_LINE)
    print('Memory Info')
    print(strings.BREAK_LINE)

    print('Texture Memory:', string.format('%.2f MB', system.getInfo('textureMemoryUsed') / (1024 * 1024)))

    if (system.getInfo('environment') == 'simulator') then

        Runtime:addEventListener(listener.ENTER_FRAME, function()
            print('System Memory:', string.format('%.2f KB', collectgarbage('count')))
        end)
    else

        print('System Memory:', string.format('%.2f KB', collectgarbage('count')))
    end
end

return {
    showMemoryInfo = _showMemoryInfo
}