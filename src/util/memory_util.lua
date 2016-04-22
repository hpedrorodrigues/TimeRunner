local importations = require(IMPORTATIONS)
local strings = require(importations.STRINGS)

local function _showMemoryInfo()
    print(strings.BREAK_LINE)
    print(strings.LONG_LINE)
    print('Memory Info')
    print(strings.BREAK_LINE)

    print('Texture Memory:', string.format('%.2f MB', system.getInfo('textureMemoryUsed') / (1024 * 1024)))
    print('System Memory:', string.format('%.2f KB', collectgarbage('count')))
end

return {
    showMemoryInfo = _showMemoryInfo
}