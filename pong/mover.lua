Mover = {}
Mover.__index = Mover

function Mover:create(location, velocity, weight)
    local mover = {}
    setmetatable(mover, Mover)
    mover.location = location
    mover.velocity = velocity
    mover.acceleration = Vector:create(0, 0)
    mover.size = 2
    mover.weight = weight or 1
    return mover
end

function Mover:applyForce()
    local friction = self.velocity:norm()
    friction:mul(1.5)
    self.acceleration:add(friction / self.weight)
end

function Mover:checkBoundaries()
    if self.location.x > width - self.size then
        self.location.x = width - self.size
        self.velocity.x = -1 * self.velocity.x
    elseif self.location.x < self.size then
        self.location.x = self.size
        self.velocity.x = -1 * self.velocity.x
    end
    if self.location.y > height - self.size then
        self.location.y = height - self.size
        self.velocity.y = -1 * self.velocity.y
    elseif self.location.y < self.size then
        self.location.y = self.size
        self.velocity.y = -1 * self.velocity.y
    end
end

function Mover:chechRacketFirst(racket, scores)

    local dist = (self.location.x - self.size) - (racket.location.x + racket.width)
    sound = love.audio.newSource("sound/pong.wav", "static")

    if dist <= 0.1 then

        if (self.location.y + self.size) - racket.location.y >= 0.1 and 
        (self.location.y + self.size) - racket.location.y <= self.size-0.1 then
            self.location.y = racket.location.y - self.size - 0.1
            sound:play()
        end

        if (racket.location.y + racket.width) - (self.location.y - self.size) >= 0.1 and 
        (racket.location.y + racket.width) - (self.location.y - self.size) <= self.size-0.1 then
            self.location.y = racket.location.y + racket.width + self.size + 0.1
            sound:play()
        end

        if self.location.y - self.size >  racket.location.y and self.location.y - self.size < racket.location.y + racket.height and
        self.location.y + self.size <  racket.location.y + racket.height and self.location.y + self.size > self.location.y - self.size then
            self.velocity.x = -1 * self.velocity.x
            sound:play()
        end

        if self.location.x - self.size < 1 then
            self.location = Vector:create(width/2, height/2)
            --self.velocity.x = -1 * self.velocity.x
            scores:update(1)
            mover:applyForce()
        end

    end
end

function Mover:chechRacketSecond(racket, scores)

    local dist = racket.location.x - (self.location.x + self.size)
    sound = love.audio.newSource("sound/pong.wav", "static")

    if dist <= 0.1 then

        if (self.location.y + self.size) - racket.location.y >= 0.1 and 
        (self.location.y + self.size) - racket.location.y <= self.size-0.1 then
            self.location.y = racket.location.y - self.size - 0.1
            sound:play()
        end

        if (racket.location.y + racket.width) - (self.location.y - self.size) >= 0.1 and 
        (racket.location.y + racket.width) - (self.location.y - self.size) <= self.size-0.1 then
            self.location.y = racket.location.y + racket.width + self.size + 0.1
            sound:play()
        end

        if self.location.y - self.size >  racket.location.y and self.location.y - self.size < racket.location.y + racket.height or
        self.location.y + self.size <  racket.location.y + racket.height and self.location.y + self.size > racket.location.y then
            self.velocity.x = -1 * self.velocity.x
            sound:play()
        end

        if self.location.x + self.size > 799 then
            self.location = Vector:create(width/2, height/2)
            --self.velocity.x = -1 * self.velocity.x
            scores:update(0)
            mover:applyForce()
        end
    end
end

function Mover:draw()
    local r, g, b, a = love.graphics.getColor()

    love.graphics.setColor(247/255, 13/255, 150/255, 1)
    love.graphics.circle("fill", self.location.x, self.location.y, self.size)

    love.graphics.setColor(r, g, b, a)
end

function Mover:update()
    self.velocity.x = self.velocity.x + self.acceleration.x
    self.location.x = self.location.x + self.velocity.x
    
    self.velocity.y = self.velocity.y + self.acceleration.y
    self.location.y = self.location.y + self.velocity.y

    self.acceleration:mul(0)
end