game_zoom = 1.5
resolution_x = 1334
resolution_y = 750

function love.conf(t)
    t.console = true

    t.window.title = "Lemmings"
    t.window.width = resolution_x
    t.window.height = resolution_y
end