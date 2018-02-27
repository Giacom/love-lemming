World = require "world"
Lemming = require "lemming"

local lemmings = {}

local world = nil
local world_bitmap = nil

local count = 0
local max_tick_rate = 1 / 45

local tick_rate = 0
local paused = false
local step = false

function love.load()
    love.graphics.setBackgroundColor(0x00, 0x00, 0x00)
    love.graphics.setDefaultFilter("nearest", "nearest", 1) 

    world = World:new(love.graphics.newImage("res/world.png"))

    Lemming.BITMAP = love.graphics.newImage("res/lemmings.png")
    Lemming.SPRITE_BATCH = love.graphics.newSpriteBatch(Lemming.BITMAP, 1024, "stream")

    for i = 1, test_lemming do
        lemmings[#lemmings+1] = Lemming:new()
        lemmings[#lemmings].y = -i * 32
    end
end

local game_zoom = game_zoom

function love.draw()
    love.graphics.draw(world.bitmap, 0, 0, 0, game_zoom, game_zoom)
    love.graphics.print(string.format( "Tick: %.0f - FPS %.0f - Lemmings %i", tick_rate, love.timer.getFPS(), #lemmings), 0, 0, 0, game_zoom, game_zoom)

    local sprite_batch = Lemming.SPRITE_BATCH
    sprite_batch:clear()
    for i = 1, #lemmings do
        lemmings[i]:batch(sprite_batch)
    end
    love.graphics.draw(sprite_batch, 0, 0, 0, game_zoom, game_zoom)
    sprite_batch:clear()
end

--function love.mousemoved(x, y, dx, dy, istouch)
function love.update(dt)
    if paused then
        if not step then
            return
        end
        step = false
        count = max_tick_rate
    end
    count = count + dt
    if count >= max_tick_rate then
        tick_rate = 1 / count
        for i = 1, #lemmings do
            lemmings[i]:update(world, 1)
        end
        count = max_tick_rate - count
    end
end

function love.mousepressed(x, y, button, istouch)
    x = x / game_zoom
    y = y / game_zoom
    world:sculpt(x, y, 32, 32)
end

function love.keypressed(key, scancode, isrepeat )
    if scancode == "escape" then
        love.event.quit()
    end
    print(key)
    if scancode == "tab" then
        paused = not paused
        step = false
    end

    if scancode == "w" then
        step = true
    end
end