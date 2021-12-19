require("vector")
require("mover")
require("scores")
require("racket")
require("rectangle")

function love.load()

	width = love.graphics.getWidth()
	height = love.graphics.getHeight()
	love.graphics.setBackgroundColor(0 / 255, 0 / 255, 0 / 255)

	start_back = love.graphics.newImage("back/start_back.png")
	win_back = love.graphics.newImage("back/win_back.png")
	lose_back = love.graphics.newImage("back/lose_back.png")

	scores = Scores:create(0, 0)

	location_1 = Vector:create(40, 20)
	location_2 = Vector:create(750, height/2)

	velocity_sintez_racket = Vector:create(2, 2)

	racket_1 = Racket:create(location_1, Vector:create(0, 0))
	racket_2 = Racket:create(location_2, velocity_sintez_racket)

	location = Vector:create(width/2, height/2)
	velocity = Vector:create(2, 2)

	mover = Mover:create(location, velocity, 1)
	mover.size = 10

	rec_1 = Rectangle:create(1, 300)
	rec_2 = Rectangle:create(421,680)

	mode = 0

end

function love.update()
		
		if (mode==1) then
			racket_1:update()
			racket_2:sintezPlay(mover)

			mover:update()
			mover:checkBoundaries()

			mover:chechRacketFirst(racket_1, scores)
			mover:chechRacketSecond(racket_2, scores)

			if (scores.first_player == 9) then
				mode = 2
				scores.first_player = 0
				scores.second_player = 0
			end

			if (scores.second_player == 9) then
				mode = 3
				scores.first_player = 0
				scores.second_player = 0
			end
		end
end

function love.draw()

	local mainFont = love.graphics.newFont('AtariClassic-Regular.ttf', 40)
	love.graphics.setFont(mainFont)
	local r, g, b, a = love.graphics.getColor()

	local w = start_back:getWidth()
	local h = start_back:getHeight()

	if (mode == 0) then
		love.graphics.draw(start_back,550,400,0,1,1,w,h)
		love.graphics.setColor(112/255, 10/255, 255/255, 1)
	end

	if (mode==1) then
		scores:draw()
		racket_1:draw()
		racket_2:draw()
		mover:draw()
		love.graphics.setColor(112/255, 10/255, 255/255, 1)

		love.graphics.line( 400, 0, 400, 600)
	end

	if (mode == 2) then
		love.graphics.draw(win_back,500,300,0,1,1,w,h)
		love.graphics.setColor(112/255, 10/255, 255/255, 1)
	end

	if (mode == 3) then
		love.graphics.draw(lose_back,500,330,0,1,1,w,h)
		love.graphics.setColor(247/255, 13/255, 150/255, 1)
	end

	if mode ~= 1 then
		love.graphics.print("Press s to start",80,400 )
	end

	love.graphics.setColor(r, g, b, a)
	
end

function love.keypressed(key)
	if key == 's' or key == 'ы' then
		mode = 1
		mover.location = Vector:create(width/2, height/2)
		mover.velocity = Vector:create(2, 2)
		mover.acceleration = Vector:create(0, 0)

	end
end


function love.mousepressed(x, y, button, istouch)
    if button == 1 and mode ~= 1 then
        mode = 1
		mover.location = Vector:create(width/2, height/2)
		mover.velocity = Vector:create(2, 2)
		mover.acceleration = Vector:create(0, 0)
     end
end
