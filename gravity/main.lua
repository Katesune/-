require("vector")
require("mover")
require("attractor")

function love.load()
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()

	G = 0.4

	local location = Vector:create(width/2 + 100, height / 2)
	attractor = Attractor:create(location, 20)

	local location = Vector:create(300, 350)
	local velocity = Vector:create(0.1, 0.1)

	mover = Mover:create(location, velocity, 1)

	movers = {}
	attractors = {}
	for i=1,10 do
		local locations = Vector:create(math.random(800), math.random(600))
		local velocity = Vector:create(0.1, 0.1)
		attractors[i] = Attractor:create(locations, 4)
		movers[i] = Mover:create(locations, velocity, 1)
	end
end

function love.update()
	attractor:attract(mover)
	mover:update()
	for i=1,10 do
		movers[i]:update()
		movers[i]:checkBoundaries()
		attractors[i] = Attractor:create(movers[i].location, 4)
		for j=1,10 do 
			if j ~= i then 
				attractors[j]:attract(movers[i])
			end
		end 
	end
end

function love.draw()
	attractor:draw()
	mover:draw()
	for i=1,10 do
		movers[i]:draw()
		attractors[i]:draw()
	end
end