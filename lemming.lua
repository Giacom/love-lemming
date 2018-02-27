local Lemming = {}

Lemming.BITMAP = love.graphics.newImage("res/lemmings.png")
Lemming.SPRITE_BATCH = love.graphics.newSpriteBatch(Lemming.BITMAP, 1024, "stream")
Lemming.SIZE_Y = 8
Lemming.SIZE_X = 5

Lemming.RIGHT = 1
Lemming.LEFT = -1

Lemming.FALL_SPEED = 40
Lemming.WALK_SPEED = 30

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
    sprite_batch:add(self.x, self.y, 0, 1, 1, origin_x, origin_y - 1)
end

function Lemming:update(world, dt)
    local x = self.x
    local y = self.y

    local fell = y + (Lemming.FALL_SPEED * dt)

    if (not world:check_collision(x, fell)) then
        self.y = fell
        return
    end

    for step = 0, 3 do
        local walk_x = x + (self.dir * Lemming.WALK_SPEED * dt)
        local walk_y = y - step
        if (not world:check_collision(walk_x, walk_y)) then
            self.x = walk_x
            self.y = walk_y
            return
        end
    end

    self.dir = -self.dir
end

return Lemming