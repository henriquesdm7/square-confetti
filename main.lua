--[[ The game variables ]]
push = require 'lib.push'

WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

BALLS_QUANTITY = 100

require 'classes.Ball'

--[[ Called to load the game, only once. ]]
function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    balls = {}

    for i = 1, BALLS_QUANTITY do
        ball = Ball(VIRTUAL_WIDTH / 2 - 7, VIRTUAL_HEIGHT / 2 - 7, 7, 7)

        ball.dy = math.random(2) == 1 and -math.random(1, 190) or math.random(1, 190)
        ball.dx = math.random(2) == 1 and -math.random(1, 190) or math.random(1, 190)

        table.insert(balls, ball)
    end

    math.randomseed(os.time())
end

--[[ Called everytime a key is pressed ]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

--[[ Called every time the window is resized ]]
function love.resize(width, height)
    push:resize(width, height)
end

--[[ Called before every frame render ]]
function love.update(dt)
    if (dt <= .1) then
        for i = 1, BALLS_QUANTITY do
            balls[i]:update(dt, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        end
        -- ball1:update(dt, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        -- ball2:update(dt, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        -- ball3:update(dt, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    end
end

--[[ Called every frame, after update ]]
function love.draw()
    push:apply('start')
    -- 93E1D8
    love.graphics.clear(0.57, 0.88, 0.84, 1)

    love.graphics.setColor(0, 0, 0, 1)

    --[[ Balls rendering ]]
    for i = 1, BALLS_QUANTITY do
        balls[i]:draw()
    end
    --[[ Balls rendering ]]

    love.graphics.rectangle("fill", VIRTUAL_WIDTH / 2 - 4, VIRTUAL_HEIGHT / 2 - 4, 1, 1)

    -- show fps
    love.graphics.setFont(love.graphics.newFont(10))
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)

    push:apply('end')
end
