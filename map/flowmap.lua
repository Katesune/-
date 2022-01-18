FlowMap = {}
FlowMap.__index = FlowMap

function FlowMap:create (size, w, h)
    local map = {}
    setmetatable(map, FlowMap)
    map.field = {}
    map.size = size
	map.w = w
	map.h = h
    love.math.setRandomSeed(10000)
    return map
end 

function FlowMap:init()
	local cols = width/self.w
	local rows = height/self.h
	print(cols)

	--local cols = self.w
	--local rows = self.h

	for i = 1, cols do
		self.field[i] = {}
		for j = 1, rows do
			if math.fmod(j, 2) == 0 then
				if math.fmod(i, 2) == 0 then
					self.field[i][j] = Vector:create(-0.3, 0)
				else
					self.field[i][j] = Vector:create(0.3, 0)
				end
			else
				--[[if math.fmod(i, 2) == 0 then
					self.field[i][j] = Vector:create(-0.3, 0)
				else
					self.field[i][j] = Vector:create(0.3, 0)
				end]]
				
				if math.fmod(i, 2) == 0 then
					self.field[i][j] = Vector:create(0, 0.5)
				else
					self.field[i][j] = Vector:create(0, -0.5)
				end
			end
		end
	end

	--[[for i = 1, 20 do
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
			if math.fmod(j, 2) == 0 then
				drawVector(self.field[i][j], (i-1) * self.w + 20, j * self.h - 14, self.w - 10, 1)
			elseif math.fmod(i, 2) == 0 then
				drawVector(self.field[i][j], (i-1) * self.w + 20, j * self.h - 14, self.w - 10, 0)
			else
				drawVector(self.field[i][j], (i-1) * self.w + 20, j * self.h - 14, self.w - 10, 2)
			end
		end
	end
end

function drawVector(v, x, y, s, mode)
	love.graphics.push()
	love.graphics.translate(x,y)
	love.graphics.rotate(v:heading())
	local len = v:mag() * s

	if mode == 0 then
		love.graphics.line(-14,0,len-5,0)

		love.graphics.line(len-5,0,len-10,5)
		love.graphics.line(len-5,0,len-10,-5)

	elseif mode == 2 then
		love.graphics.line(-10,-3,len,-3)

		love.graphics.line(len,-3,len-5,2)
		love.graphics.line(len,-3,len-5,-8)

	elseif mode == 1 then
		love.graphics.line(-12,0,len,0)

		love.graphics.line(len,0,len-5,5)
		love.graphics.line(len,0,len-5,-5)

	end


	--local vehicle = Vehicle:create(len, 0)
    --vehicle.velocity.x = len
    --vehicle.velocity.y = 0
	--vehicle:draw()
	--love.graphics.triangle("fill",len,-5,len, 5, len +5, 0)
	love.graphics.pop()
end
