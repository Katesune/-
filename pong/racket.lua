Racket = {}
Racket.__index = Racket

function Racket:create(location, velocity)
    local racket = {}
    setmetatable(racket, Racket)
    racket.width = 15
    racket.height = 60
    racket.location = location
    racket.velocity = velocity
    racket.acceleration = Vector:create(1, 1)
    return racket
end

function Racket:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(170/255, 43/255, 253/255, 1)

	love.graphics.rectangle("fill", self.location.x, self.location.y, self.width, self.height)
    love.graphics.setColor(r, g, b, a)
end

function Racket:update()
    local x, y = love.mouse.getPosition()
    self.location.y = y
end


function Racket:sintezPlay(mover)
    local ran = math.floor(math.random(1, 10))

    self.velocity = mover.velocity + mover.acceleration
    self.location.y = mover.location.y + mover.velocity.y 

    if ran > 8 then
        self.velocity = mover.velocity + mover.acceleration
        self.location.y = mover.location.y + mover.velocity.y + 1

    else 
        local top_or_bot = math.floor(math.random(1, 10))


        self.velocity = mover.velocity + mover.acceleration 
        self.location.y = mover.location.y + mover.velocity.y 

        if top_or_bot < 8 then
            local friction = velocity:norm()
            friction:mul(0.5)
            self.acceleration:add(friction / width)
        else
            local friction = velocity:norm()
            friction:mul(300)
            self.acceleration:add(friction / width)
        end
    end
end

function Racket:applyForce(param)

    local friction = velocity:norm()
    friction:mul(1.5)
    acceleration:add(friction / width)
end