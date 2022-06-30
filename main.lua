--[[ The game variables ]]
push = require 'lib.push'

WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

BALLS_QUANTITY = 100

require 'classes.Ball'
require 'classes.Wall'

--[[ Called to load the game, only once. ]]
function love.load()
    math.randomseed(os.time())

    love.graphics.setDefaultFilter("nearest", "nearest")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    balls = {}
    walls = {
        Wall(100, 10, 20, 100),
        Wall(0, 10, 100, 20),
        Wall(0, 90, 90, 20)
    }

    for i = 1, BALLS_QUANTITY do

        ball = Ball(VIRTUAL_WIDTH / 2 - 7, VIRTUAL_HEIGHT / 2 - 7, 3, 3)

        ball.dy = ((math.random(2) == 1) and (-math.random(-190, 190)) or (math.random(-190, 190)))
        ball.dx = ((math.random(2) == 1) and (-math.random(-190, 190)) or (math.random(-190, 190)))

        table.insert(balls, ball)
    end
end

--[[ Called everytime a key is pressed ]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

--[[ Called everytime the mouse is clicked ]]
function love.mousepressed(x, y, button)
    if button == 1 then
        for i = 1, #balls do
            balls[i].dy = -balls[i].dy
            balls[i].dx = -balls[i].dx
        end
    end
end

--[[ Called everytime the mouse is pressed and mantained ]]
function love.mousemoved(x, y)
    if love.mouse.isDown(1) then
        mouse_x, mouse_y = push:toGame(x, y)
        ball = Ball(mouse_x, mouse_y, 3, 3)
    
        ball.dy = ((math.random(2) == 1) and (-math.random(-190, 190)) or (math.random(-190, 190)))
        ball.dx = ((math.random(2) == 1) and (-math.random(-190, 190)) or (math.random(-190, 190)))
    
        table.insert(balls, ball)
    end
end

--[[ Called every time the window is resized ]]
function love.resize(width, height)
    push:resize(width, height)
end

--[[ Called before every frame render ]]
function love.update(dt)
    if (dt <= .1) then
        for i = 1, #balls do
            balls[i]:checkCollisionsAndDeflect(walls)
            balls[i]:update(dt, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        end
        for i = 1, #walls do
            walls[i]:update(dt, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        end
    end
end

--[[ Called every frame, after update ]]
function love.draw()
    push:apply('start')
    -- 93E1D8
    love.graphics.clear(0.57, 0.88, 0.84, 1)

    love.graphics.setColor(0, 0, 0, 1)

    --[[ Balls rendering ]]
    for i = 1, #balls do
        balls[i]:draw()
    end
    for i = 1, #walls do
        walls[i]:draw()
    end

    love.graphics.rectangle("fill", VIRTUAL_WIDTH / 2 - 4, VIRTUAL_HEIGHT / 2 - 4, 1, 1)

    --[[ Show fps ]]
    love.graphics.setFont(love.graphics.newFont(10))
    love.graphics.setColor(.5, .6, .1, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.print('Balls: ' .. tostring(#balls), 10, 20)

    push:apply('end')
end
