local function _fillNeededFrameFields(frames)
    local framesCount = 0

    for index, current in pairs(frames) do

        local old = frames[index - 1]

        if (current.x == nil) then
            current.x = old.x + old.width
        end

        if (current.y == nil) then
            current.y = old.y
        end

        if (current.height == nil) then
            current.height = old.height
        end

        framesCount = index
    end

    return framesCount
end

return {
    fillNeededFrameFields = _fillNeededFrameFields
}