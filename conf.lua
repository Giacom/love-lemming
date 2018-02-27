game_zoom = 4
resolution_x = 1334
resolution_y = 750
test_lemming = 100

function love.conf(t)
    t.console = true

    t.window.title = "Lemmings"
    t.window.width = resolution_x
    t.window.height = resolution_y
end