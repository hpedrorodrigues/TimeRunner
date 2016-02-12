-----------------------------------------------------------------------------------------
-- Hello World
-----------------------------------------------------------------------------------------

-- Mostra um texto na tela, passa como parâmetro o texto, a posição X, a posição Y, a fonte, e o tamanho da letra
local txHello = display.newText("Hello World", 300, 200, native.systemFont, 40)

-- Define uma cor para o texto (Red, Green, Blue)
txHello:setTextColor(0, 255, 0)