FlowMap = {}
FlowMap.__index = FlowMap

function FlowMap:create (size)
    local map = {}
    setmetatable(map, FlowMap)
    map.field = {}
    map.size = size
    love.math.setRandomSeed(10000)
    return map
end 

function FlowMap:init()
	local cols = width/self.size
	local rows = height/self.size
    local xoff = 0.1
    local yoff = 0.1

	local angle = 1


	for i = 1, cols do
		self.field[i] = {}
		for j = 1, rows do
			--local thetax = xoff
			--local thetay = yoff * transform(thetax, yoff)

			--local thetax = xoff * xoff - yoff * yoff + 0.1
			--local thetay = 2 * xoff * yoff + 0.1

			local radius = 300
			--local theta = xoff * (math.sqrt(5) + 1)/2

			local r = 2* math.pi * 0.5
			--self.field[i][j] = Vector:create( r *math.cos(-angle), r *math.sin(-angle))
			self.field[i][j] = Vector:create( r*angle*math.cos(angle), r*angle*math.sin(angle))
			
			print( r*angle*math.cos(angle))
			--x, y = x + h, y + h * f(x, y)

			angle = angle + 0.1
			--xoff = thetax 
			--yoff = thetay 
			yoff = yoff + 0.01
		end
		xoff = xoff + 0.1
	end

	--[[for i = 1, cols/2 do
		self.field[i] = {}
		for j = 1, rows do
			--local thetax = xoff
			--local thetay = yoff * transform(thetax, yoff)

			--local thetax = xoff * xoff - yoff * yoff + 0.1
			--local thetay = 2 * xoff * yoff + 0.1

			local radius = 300
			local theta = xoff * (math.sqrt(5) + 1)/2

			self.field[i][j] = Vector:create(math.sin(theta), math.cos(theta))
			--x, y = x + h, y + h * f(x, y)

			--xoff = thetax 
			--yoff = thetay 
			yoff = yoff + 0.01
		end
		xoff = xoff + 0.1
	end]]

	--[[for i = 1, 10 do
		self.field[i] = {}
		for j = 1, 15 do

			local radius = 300
			local theta = xoff * (math.sqrt(5) + 1)/2

			self.field[i][j] = Vector:create(math.cos(theta), math.sin(theta))
			yoff = yoff + 0.01
		end

		--[[for j = 8, 15 do

			local radius = 300
			local theta = xoff * (math.sqrt(5) + 1)/2

			self.field[i][j] = Vector:create(math.sin(theta), math.cos(theta))
			yoff = yoff + 0.01
		end
		]]
		--[[xoff = xoff + 0.1
	end

	for i = 11, 20 do
		self.field[i] = {}
		for j = 1, 15 do

			local radius = 300
			local theta = xoff * (math.sqrt(5) + 1)/2

			self.field[i][j] = Vector:create(math.cos(theta), math.sin(theta))
			yoff = yoff + 0.01
		end

		--[[for j = 8, 15 do

			local radius = 300
			local theta = xoff * (math.sqrt(5) + 1)/2

			self.field[i][j] = Vector:create(math.sin(theta), math.cos(theta))
			yoff = yoff + 0.01
		end
		
		xoff = xoff + 0.1
	end]]


	-- for i = 1, cols do
    --     yoff = 0 
	-- 	self.field[i] = {}
	-- 	for j = 1, rows do
		

	-- 		--local theta = math.map(10, 0, 1, 0, angle)
	-- 		--local theta = math.map(love.math.noise(-2 * math.sin(angle), 3 *math.cos(angle)), 0, 1, 0, math.pi * 2)

	-- 		--self.field[i][j] = Vector:create(1, 5)
	-- 		--angle = angle + 1

	-- 		local theta = math.map(love.math.noise(xoff, yoff), 0, 1, 0, math.pi * 2)
	-- 		self.field[i][j] = Vector:create(math.cos(theta), math.sin(theta))
    --         yoff = yoff - 0.13
	-- 	end
    --     xoff = xoff + 0.1
	-- end
end

function transform(x, y)
	return 6*x^2+5*x*y
end



function FlowMap:lookup(v)
	local col = math.constrain(math.floor(v.x/self.size)+1, 1, #self.field)
	local row = math.constrain(math.floor(v.y/self.size)+1, 1, #self.field[1])
	return self.field[col][row]:copy()
end

function FlowMap:draw()
	for i = 1, #self.field do
		for j = 1, #self.field[1] do
			--drawVector(self.field[i][j], (i-1) * self.size, (j-1) * self.size, self.size-2)
			drawVector(self.field[i][j], (i-1) * self.size, j * self.size, self.size-2)
		end
	end
end

function drawVector(v, x, y, s)
	love.graphics.push()
	love.graphics.translate(x,y)
	love.graphics.rotate(v:heading())
	local len = v:mag() * s
	love.graphics.line(0,0,len,0)
	love.graphics.circle("fill",len,0,5)
	love.graphics.pop()
end
