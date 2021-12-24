require("scores")
require("mover")
require("col")
require("vector")

function love.load()
    width = love.graphics.getWidth()
	height = love.graphics.getHeight()
	love.graphics.setBackgroundColor(0 / 255, 0 / 255, 0 / 255)

    mode = 0

    start_back = love.graphics.newImage("assets/sprites/message.png")
	game_over_back = love.graphics.newImage("assets/sprites/gameover.png")
	game_back_day = love.graphics.newImage("assets/sprites/background-day.png")

    scores = Scores:create(0)
    scores:startScores()

    location = Vector:create(150, 150)
    velocity = Vector:create(2, 2)

    mover = Mover:create(location, velocity)

    start_location_x = 400

    colons = Colons:create(start_location_x, velocity)
end

function love.update(dt)

    mover:update(dt)

    if (mode == 1) then
        colons:update()
        if mover.state == 1 then
            --mover:chechCols(colons.colon_mass)
        end
        scores:update()
    end

    if scores.player == 9 then
        mode = 0
        scores.player = 0
    end
end

function love.draw()

    love.graphics.draw(game_back_day,0, 0,0,1,1)

    if mode == 0 then
        love.graphics.draw(start_back,52, 122.5,0,1,1)
    end

    if mode == 1 then
        scores:draw()
        mover.state = 1
        colons:draw()
    end

    if mode == 2 then
        love.graphics.draw(game_over_back,47, 235,0,1,1)
    end

    mover:draw()
end

function love.keypressed(key)
	if key == 'backspace' and mode ~= 1 then
        mode = 1
	end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 and mode ~= 1 then
        mode = 1
     end
end