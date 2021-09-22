require("vector")
require("mover")

function love.load()
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()
	love.graphics.setBackgroundColor(128 / 255,
									 128 / 255, 
									 128 / 255)

	location = Vector:create(100, height/2)
	wlocation = Vector:create(500, height/2)
	velocity = Vector:create(0, 0)

	mover = Mover:create(location, velocity, 5)
	mover.size = 30
	wmover = Mover:create(wlocation, velocity, 5)
	wmover.size = 30

	wind = Vector:create(0.01, 0)
	isWind = false
	gravity = Vector:create(0, 0.01)
	isGravity = true
	floating = Vector:create(0, -0.02)
	isFloationg = false
end

function love.update()
	mover:applyForce(gravity)
	wmover:applyForce(gravity)
	mover:applyForce(wind)
	wmover:applyForce(wind)

	--[[friction = (mover.velocity  * -1):norm()
	if friction then 
		friction:mul(0.005)
		mover:applyForce(friction)
		wmover:applyForce(friction)
	end]]

    mover:update()
	mover:checkBoundaries()
	mover:checkRectangle()

	wmover:update()
	wmover:checkBoundaries()
	wmover:checkRectangle()
end

function love.draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0, 199/255, 90/255, 0.5)
	love.graphics.rectangle("fill", 0, 0, 400, 600)
	love.graphics.setColor(0, 230/255, 52/255, 0.5)
	love.graphics.rectangle("fill", 400, 0, 400, 600)
	love.graphics.setColor(r, g, b, a)

	mover:draw()
	wmover:draw()

	love.graphics.print(tostring(mover.velocity) ..
								 mover.location.x + mover.size, 
								 140)

	love.graphics.print(tostring(wmover.velocity) ..
								 wmover.location.x + wmover.size, 
								 500)

	love.graphics.print("w: " .. tostring(isWind) .. 
						" g: " .. tostring(isGravity) ..
						" f: " .. tostring(isFloationg)) 
end

function love.keypressed(key)
	if key == 'g' then 
		isGravity = not isGravity
	end
	if key == 'f' then 
		isFloationg = not isFloationg
	end
	if key == 'w' then 
		isWind = not isWind
		if isWind then 
			wind = wind * -1
		end
	end
end
