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

    location = Vector:create(150, 150)
    velocity = Vector:create(2, 2)

    mover = Mover:create(location, velocity)

    colon_1 = Colon:create(location, velocity)
    colon_2 = Colon:create(location, velocity)
end

function love.update(dt)
    scores:update()

    if (mode == 1) then
        mover:update(dt)
        colon_1:update()
        colon_2:update()
    end

    if scores.player == 9 then
        mode = 0
        scores.player = 0
    end
end

function love.draw()

    love.graphics.draw(game_back_day,0, 0,0,1,1)
    mover:draw()

    if mode == 0 then
        love.graphics.draw(start_back,52, 122.5,0,1,1)
    end

    if mode == 1 then
        scores:draw()
        mover.state = 1
        colon_1:draw()
        colon_2:draw()
    end

    if mode == 2 then
        love.graphics.draw(game_over_back,0, 0,0,1,1)
    end

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