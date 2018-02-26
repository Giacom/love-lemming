zoom = 2
resolution_x = 1334 / zoom
resolution_y = 750 / zoom

function love.conf(t)
    t.console = true

    t.window.title = "Lemmings"
    t.window.width = resolution_x
    t.window.height = resolution_y
end