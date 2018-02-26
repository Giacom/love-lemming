local Lemming = {}

Lemming.BITMAP = love.graphics.newImage("res/lemmings.png")
Lemming.SPRITE_BATCH = love.graphics.newSpriteBatch(Lemming.BITMAP, 1024, "stream")
Lemming.SIZE_X = 5
Lemming.SIZE_Y = 8

Lemming.RIGHT = 1
Lemming.LEFT = -1

function Lemming:new(...)
    local instance = {}
    setmetatable( instance, self )
    self.__index = self
    self._init( instance, ... )
    return instance
end

function Lemming:_init()
    self.x = 0
    self.y = Lemming.SIZE_Y
    self.dir = Lemming.RIGHT
end

function Lemming:batch(sprite_batch)
    local origin_x = Lemming.SIZE_X * 0.5
    local origin_y = Lemming.SIZE_Y * 1.0
    sprite_batch:add(self.x, self.y, 0, 1, 1, origin_x, origin_y)
end

function Lemming:update(world)
    local x = self.x
    local y = self.y

    if (not world:check_collision(x, y + 1)) then
        self.y = y + 1
        return
    end

    for step = 0, 3 do
        if (not world:check_collision(x + self.dir, y - step)) then
            self.x = x + self.dir
            self.y = y - step
            return
        end
    end

    self.dir = -self.dir
end

return Lemming