Mover = {}
Mover.__index = Mover

function Mover:create(location, velocity)
    local mover = {}
    setmetatable(mover, Mover)
    mover.location = location

    mover.velocity = velocity
    mover.angle = 0
    mover.state = 0

    mover.images = {
        love.graphics.newImage("assets/sprites/redbird-downflap.png"),
        love.graphics.newImage("assets/sprites/redbird-midflap.png"),
        love.graphics.newImage("assets/sprites/redbird-upflap.png")
    }
    mover.image_num = 1

    mover.width = mover.images[1]:getWidth()
    mover.height = mover.images[1]:getHeight()

    mover.right_x = location.x + mover.width
    mover.right_y = location.y + mover.height

    mover.time = 0
    mover.frameTime = 0.1

    return mover
end

function Mover:update(dt)
    if self.state == 1 and self.time > self.frameTime then
        if self.image_num > 2 then
            self.image_num = 1
        else self.image_num = self.image_num + 1
        end
        self.time = 0
    end

    self.time = self.time + dt

    --self.location = self.location + self.velocity

    self.right_x = self.location.x + self.width
    self.right_y = self.location.y + self.height

end

function Mover:draw()
    if self.state == 0 then
        love.graphics.draw(self.images[self.image_num],127, 290,0,1,1)
    end
    love.graphics.draw(self.images[self.image_num],127, 290,0,1,1)
end