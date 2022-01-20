FlowMap = {}
FlowMap.__index = FlowMap

function FlowMap:create (size, w, h)
    local map = {}
    setmetatable(map, FlowMap)
    map.field = {}
    map.size = size
	map.w = w
	map.h = h
	map.toright = Vector:create(0.5, 0)
	map.toleft = Vector:create(-0.5, 0)
	map.tobot = Vector:create(0, 0.5)
	map.totop = Vector:create(0, -0.5)
    love.math.setRandomSeed(10000)
    return map
end 

function FlowMap:init()
	local cols = width/self.w
	local rows = height/self.h
	print(cols)

	for i = 1, cols do
		self.field[i] = {}
		for j = 1, rows do
			if i < 18 and j < 4 then self.field[i][j] = self.toleft end
			if i < 18 and j > 3 and j < 7 then self.field[i][j] = self.tobot end

			if i < 17 and j == 7 then self.field[i][j] = self.toright end
			if i == 17 and j == 7 then self.field[i][j] = self.tobot end

			if i < 9 and i > 1 and j > 7 and j < 12 then self.field[i][j] = self.toright end
			if i > 8 and i < 18 and j > 7 and j < 12 then self.field[i][j] = self.tobot end
			
			if i < 9 and i > 1 and j > 11 and j < 19 then self.field[i][j] = self.tobot end
			if i > 9 and i < 18 and j == 12 then self.field[i][j] = self.toleft end
			if i > 9 and i < 18 and j > 12 and j < 15 then self.field[i][j] = self.toleft end
			if i == 9 and j > 11 and j < 14 then self.field[i][j] = self.tobot end
			if i > 8 and i < 21 and j < 19 and j > 14 then self.field[i][j] = self.toright end

			if i > 17  and i < 30 and j < 14 and j > 8 then self.field[i][j] = self.tobot end
			if i > 17  and i < 30 and j < 8 then self.field[i][j] = self.toleft end

			if i > 17  and i < 30 and j == 14 then self.field[i][j] = self.toright end
			if i > 20  and i < 30 and j > 14 and j < 18 then self.field[i][j] = self.tobot end
			if i > 20  and i < 30 and j == 18 then self.field[i][j] = self.toright end

			if j < 4 and i < 15 and i > 2 then self.field[i][j] = self.tobot end
			if j < 7 and i == 1 then self.field[i][j] = self.tobot end
			if j < 6 and i == 2 then self.field[i][j] = self.tobot end

			if j < 6 and j > 3 and i < 15 and i > 2 then self.field[i][j] = self.toleft end
			if j == 6 and i < 29 and i > 1 then self.field[i][j] = self.toright end
			if j < 7 and i == 30 then self.field[i][j] = self.totop end
			if j < 7 and j > 1 and i == 29 then self.field[i][j] = self.totop end
			if j == 1 and i < 15 then self.field[i][j] = self.toleft end

			if j == 7 and i == 30 then self.field[i][j] = self.toleft end  --left arrow one

			if i > 1 and j > 18 then self.field[i][j] = self.toleft end
			if i < 2 and j > 7 then self.field[i][j] = self.totop end
			if i > 29 and j < 19 and j > 1 then self.field[i][j] = self.totop end
			if i == 1 and j == 1 then self.field[i][j] = self.tobot end

			if i > 14 and i < 29 and j == 7 then self.field[i][j] = self.toright end
			if i == 29 and j == 7 then self.field[i][j] = self.totop end
			if i < 17 and j == 8 then self.field[i][j] = self.toright end
			if j < 6 and j > 3 and i == 29 then self.field[i][j] = self.toleft end
			if j < 6 and j > 3 and i == 29 then self.field[i][j] = self.toleft end
			if j == 5 and i > 14 and i < 18 then self.field[i][j] = self.totop end
			if j == 4 and i > 14 and i < 29 then self.field[i][j] = self.toright end
			if j == 4 and i == 29 then self.field[i][j] = self.totop end
			if j < 3 and j > 1 and i == 29 then self.field[i][j] = self.toleft end

			if j == 8 and i > 16 and i < 29 then self.field[i][j] = self.toright end
			if j == 15 and i > 8 and i < 22 then self.field[i][j] = self.toleft end
			if j < 20 and j > 12 and i == 8 then self.field[i][j] = self.totop end
			if j < 14 and j > 11 and i > 3 and i < 9 then self.field[i][j] = self.toleft end
			if j == 16 and i > 2 and i < 9 then self.field[i][j] = self.toright end

			if j < 12 and j > 8 and i > 17 and i < 30 then self.field[i][j] = self.toleft end
			if j == 18  and i > 2 and i < 8 then self.field[i][j] = self.toright end
			if j == 17  and i > 3 and i < 8 then self.field[i][j] = self.toleft end
			if j == 16  and i == 7 then self.field[i][j] = self.tobot end

			if j == 14  and i > 2 and i < 7 then self.field[i][j] = self.toright end
			if j == 15  and i > 3 and i < 8 then self.field[i][j] = self.toleft end
			
			if self.field[i][j] == self.toleft or self.field[i][j] == self.toright
			or self.field[i][j] == self.tobot or self.field[i][j] == self.totop then
			else self.field[i][j] = self.tobot
			end
			
		end
	end
end



function FlowMap:lookup(v)
	local col = math.constrain(math.floor(v.x/self.size)+1, 1, #self.field)
	local row = math.constrain(math.floor(v.y/self.size)+1, 1, #self.field[1])
	return self.field[col][row]:copy()
end

function FlowMap:draw()
	for i = 1, #self.field do
		for j = 1, #self.field[1] do
			--if math.fmod(j, 2) == 0 then
			if self.field[i][j] == self.toleft or self.field[i][j] == self.toright then
				drawVector(self.field[i][j], (i-1) * self.w + 20, j * self.h - 22, self.w - 10, 1)
			elseif self.field[i][j] == self.tobot then
				drawVector(self.field[i][j], (i-1) * self.w + 20, j * self.h - 22, self.w - 10, 0)
			else
				drawVector(self.field[i][j], (i-1) * self.w + 20, j * self.h - 22, self.w - 10, 2)
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
