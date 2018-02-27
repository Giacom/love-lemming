local World = {}

World.NO_COLLISION = 0
World.COLLISION = 1

function World:new(...)
    local instance = {}
    setmetatable( instance, self )
    self.__index = self
    self._init( instance, ... )
    self.pasted = love.image.newImageData(256, 256) -- Dirty hack to quickly destroy terrain
    return instance
end

function World:_init(image)
    self.bitmap = image
end

function World:check_collision(x, y)
    if self:in_world(x, y) then
        local r, g, b, a = self.bitmap:getData():getPixel(x, y)
        return a ~= 0
    end
    return false
end

function World:sculpt(x, y, w, h)
    print(string.format( "Destroying (%d, %d - %d, %d)", x, y, w, h))

    local data = self.bitmap:getData()
    local changed = false

    for _x = x + 1, x + w do
        for _y = y + 1, y + h do
            --print(string.format("(%d, %d)", _x, _y))

            if self:in_world(_x, _y) then
                --data:setPixel(_x, _y, 0xFF, 0xFF, 0xFF, 0x00)
                changed = true
            else
                --print(string.format("Not valid x: %d y: %d", _x, _y))
            end
        end
    end
    if changed == true then
        print("Updating world.")
        data:paste(self.pasted, x, y, 0, 0, w, h)
        self.bitmap = love.graphics.newImage(data)
    end
end

function World:in_world(x, y)
    local data = self.bitmap:getData()
    local size_x = data:getWidth()
    local size_y = data:getHeight()
    return x >= 0 and y >= 0 and x < size_x and y < size_y
end

return World