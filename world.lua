local World = {}

World.NO_COLLISION = 0
World.COLLISION = 1

function World:new(...)
    local instance = {}
    setmetatable( instance, self )
    self.__index = self
    self._init( instance, ... )
    return instance
end

function World:_init(image)
    self.bitmap = image
end

function World:check_collision(x, y)
    local data = self.bitmap:getData()
    local size_x = data:getWidth()
    local size_y = data:getHeight()

    if (x >= 0 and y >= 0 and x < size_x and y < size_y) then
        local r, g, b, a = data:getPixel(x, y)
        return a ~= 0
    end
    return false
end

return World