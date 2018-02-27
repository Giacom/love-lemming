local Lemming = {}

Lemming.SIZE_X = 5
Lemming.SIZE_Y = 8

Lemming.BITMAP = nil
Lemming.SPRITE_BATCH = nil
Lemming.WALKING_FRAME = nil 


Lemming.RIGHT = 1
Lemming.LEFT = -1

Lemming.UPDATE_SPEED = 1

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
    sprite_batch:add(Lemming.WALKING_FRAME, self.x, self.y, 0, self.dir, 1, origin_x, origin_y - 1)
end

local stop = 0

function Lemming:update(world, dt)
    for update = 0, Lemming.UPDATE_SPEED do
        local x = self.x
        local y = self.y

        local fell = y + 1

        if (not world:check_collision(x, fell)) then
            self.y = fell
            goto continue
        end

        for step = 0, 3 do
            local walk_x = x + self.dir
            local walk_y = y - step
            if (not world:check_collision(walk_x, walk_y)) then
                self.x = walk_x
                self.y = walk_y
                goto continue
            end
        end

        self.dir = -self.dir
        ::continue::
    end
end

return Lemming