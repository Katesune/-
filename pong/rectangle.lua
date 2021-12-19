Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle:create(width_start, width_end) 
    local rectangle = {}
    setmetatable(rectangle, Rectangle)
    rectangle.width = math.random(100,120)
    rectangle.height = math.random(100,120)
    rectangle.left = math.random(width_start,width_end)
    rectangle.top = math.random(50,550)
    return rectangle
end


function Rectangle:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, math.random(90,260), math.random(50,120), 0.5)
	love.graphics.rectangle("fill", self.left, self.top, self.width, self.height)
    love.graphics.setColor(r, g, b, a)
end
