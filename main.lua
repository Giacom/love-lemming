World = require "world"
Lemming = require "lemming"

local lemmings = {}

local world = nil
local world_bitmap = nil

function love.load()
    world = World:new(love.graphics.newImage("res/world.png"))
    love.graphics.setBackgroundColor(0x00, 0x00, 0x00)

    for i = 1, 5000 do
        lemmings[#lemmings+1] = Lemming:new()
        lemmings[#lemmings].y = -i * 32
    end
end

function love.draw()
    love.graphics.draw(world.bitmap, 0, 0, 0, game_zoom, game_zoom)
    love.graphics.print(string.format( "FPS %.0f - Lemmings %i", love.timer.getFPS(), #lemmings), 0, 0)

    local sprite_batch = Lemming.SPRITE_BATCH
    sprite_batch:clear()
    for i = 1, #lemmings do
        lemmings[i]:batch(sprite_batch)
    end
    love.graphics.draw(sprite_batch, 0, 0, 0, game_zoom, game_zoom)
    sprite_batch:clear()
end

function love.update(dt)
    for i = 1, #lemmings do
        lemmings[i]:update(world, dt)
    end
end

function love.mousepressed(x, y, button, istouch)
    x = x / game_zoom
    y = y / game_zoom
    world:sculpt(x, y, 32, 32)
end