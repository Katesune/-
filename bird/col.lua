Colon = {}
Colon.__index = Colon

function Colon:create(location, velocity)
    local colon = {}
    setmetatable(colon, Colon)
    colon.location = location
    colon.velocity = velocity

    colon.images = {
        love.graphics.newImage("assets/sprites/pipe-green.png"),
        love.graphics.newImage("assets/sprites/pipe-red.png"),
    }

    colon.image_num = math.floor(math.random(1, 2))

    colon.width = colon.images[1]:getWidth()
    colon.height = colon.images[1]:getHeight()

    colon.right_x = location.x + colon.width
    colon.right_y = location.y + colon.height

    return colon
end

function Colon:update()

    self.location = self.location + self.velocity

    self.right_x = self.location.x + self.width
    self.right_x = self.location.y + self.height

end

function Colon:draw()
    print(self.height_1)
    love.graphics.draw(self.images[self.image_num],512, 320,0,1,1)
end