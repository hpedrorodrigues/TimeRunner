local aspectRatio = display.pixelHeight / display.pixelWidth
local width = aspectRatio > 1.5 and 800 or math.floor(1200 / aspectRatio)
local height = aspectRatio < 1.5 and 1200 or math.floor(800 * aspectRatio)

application = {
    showRuntimeErrors = true,
    launchPad = false,
    content = {
        fps = 60,
        width = width,
        height = height,
        scale = "letterbox",
        xAlign = "left",
        yAlign = "top",
        shaderPrecision = "highp"
    }
}