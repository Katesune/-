Attractor = {}
Attractor.__index = Attractor

function Attractor:create(location, weight)
    local attractor = {}
    setmetatable(attractor, Attractor)
    attractor.location = location
    attractor.weight = weight
    attractor.size = 30 + 0.3 * weight
    attractor.inner_size = attractor.size
    return attractor
end

function Attractor:attract(mover)
    force = self.location - mover.location
    distance = force:mag()
    if distance then 
        if distance < 5 then 
            distance = 5
        end
        
        if distance > 25 then 
            distance = 25
        end

        force = force:norm()
        strength = (G*self.weight * mover.weight)/(distance*distance)
        force:mul(strength)
        mover:applyForce(force)
    end
end

function Attractor:draw()
    local r, g, b, a = love.graphics.getColor()
    self.inner_size = self.inner_size - 0.5
    if self.inner_size <= 0 then 
        self.inner_size = self.size
    end

    love.graphics.circle("line", self.location.x, self.location.y, self.size)
    love.graphics.circle("line", self.location.x, self.location.y, self.inner_size)
    love.graphics.setColor(r, g, b, a)
end