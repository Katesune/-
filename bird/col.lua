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
    colon.space = 80
    colon.bot_limit = 60

    colon.rand_y = math.random(colon.bot_limit, love.graphics.getHeight()-colon.bot_limit-colon.space)

    colon.right_x = location.x + colon.width

    colon.left_y_col1 = colon.rand_y - colon.height
    colon.right_y_col1 = colon.rand_y

    colon.left_y_col2 = colon.rand_y + colon.space
    colon.right_y_col2 = colon.left_y_col2 + colon.height

    return colon
end

function Colon:update(velocity)

    --self.location = self.location + self.velocity

    self.right_x = self.location.x + self.width
end

function Colon:draw()
    love.graphics.draw(self.images[self.image_num],location.x, self.rand_y,math.pi,1,1)
    love.graphics.draw(self.images[self.image_num],location.x - self.width, self.rand_y + self.space,0,1,1)
end

Colons = {}
Colons.__index = Colons

function Colons:create(start_location_x, velocity)
    local colons = {}
    setmetatable(colons, Colons)
    colons.velocity = velocity
    colons.colon_mass = {}
    colons.start_location_x = start_location_x
    colons.colon_space = 120
    colons.colon_mass[0] = Colon:create(Vector:create(start_location_x, 0), Vector:create(0, 0))
    return colons
end

function Colons:update()
    for i, colon in pairs(self.colon_mass) do
        colon:update(self.velocity)
    end

    local next_col_x = self.colon_mass[#self.colon_mass].location.x + self.colon_mass[#self.colon_mass].width + self.colon_space

    if  next_col_x < love.graphics.getWidth() then
        self.colon_mass[#self.colon_mass+1] = Colon:create(Vector:create(next_col_x, 200), Vector:create(0, 0))
    end
end

function Colons:draw()
    for i, colon in pairs(self.colon_mass) do
        colon:draw()
    end
end
