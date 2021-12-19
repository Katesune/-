Particle = {}
Particle.__index = Particle

function Particle:create(location, old_x, old_y)
    local particle = {}
    setmetatable(particle, Particle)
    particle.location = location
    particle.old_x = old_x
    particle.old_y = old_y

    particle.start = math.random(10, 60)

    particle.red_line = RedLine:create(particle.old_x, particle.old_y, particle.start)

    particle.a = particle.start
    particle.mode = 1
    particle.acceleration = Vector:create(0, 0.05)
    particle.decay = math.random(3,8) / 10

    particle.velocity = Vector:create(0.8, 0.8)

    particle.time = 0
    particle.frameTime = 0.01
    
    return particle
end

function Particle:update(dt)
    
    if self.mode == 3 then
        if self.a > 1 then
            if self.time > self.frameTime then
                self.location.x = self.location.x + 0.1
                self.location.y = self.location.y + 0.1
                self.a = self.a - 0.2
                self.time = 0
            end
        end
    end

    if self.a < 1 and self.mode ~=2 then
        self.mode = 2
    end

    if self.mode == 2 then
        self.red_line:update()
    end

    self.time = self.time + dt
end

function Particle:draw()
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(255/255, 255/255, 255/255, 1)
   if self.mode == 1 or self.mode == 3 then
        love.graphics.rectangle("fill", self.location.x, self.location.y, self.a, self.a)
   end

   if self.mode == 2 then
    self.red_line:draw()
    --[[
        love.graphics.setColor(255/255, 0/255, 76/255, 1)
        love.graphics.line(self.old_x, self.old_y, self.old_x, self.old_y + self.start)
        love.graphics.line(self.old_x, self.old_y, self.old_x + self.start, self.old_y)
        love.graphics.line(self.old_x + self.start, self.old_y, self.old_x + self.start, self.old_y + self.start)
        love.graphics.line(self.old_x, self.old_y + self.start, self.old_x + self.start, self.old_y + self.start)]]
   end
   love.graphics.setColor(r, g, b, a)
end

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(origin, n, cls)
    local system = {}
    setmetatable(system, ParticleSystem)
    system.origin = origin
    system.n = n or 10
    system.cls = cls or Particle
    system.particles = {}
    system.index = 1
    return system
end

function ParticleSystem:attraction(x, y)
    attr_point = Vector:create(x, y)
    for k, v in pairs(self.particles) do
        force = attr_point - v.location
        distance = force:mag()
        if distance then
            force = force:norm()
            force:mul(0.1)
            v:applyForce(force)
        end
    end
end


function ParticleSystem:draw()
   --[[ for k, v in pairs(self.particles) do
        v:draw()
    end]]
end

function ParticleSystem:update(touchx, touchy)
    if #self.particles < self.n then
        local l = Vector:create(math.random(0, width-100), math.random(0, height-100))

        self.particles[self.index] = Particle:create(l, l.x, l.y)
        self.index = self.index + 1
    end
end

function ParticleSystem:getPerticles()
    return self.particles
end

RedLine = {}
RedLine.__index = RedLine

function RedLine:create(x, y, size)
    local redline = {}
    setmetatable(redline, RedLine)

    redline.location = Vector:create(x, y)

    redline.location_sec = Vector:create(x, y)

    redline.size = size
    return redline
end


function RedLine:update()
    self.location = self.location + Vector:create(-math.random(1, 6),-math.random(1, 6))
    self.location_sec = self.location_sec + Vector:create(math.random(1, 6),math.random(1, 6))
end

function RedLine:draw()
    love.graphics.setColor(255/255, 0/255, 76/255, 1)
    love.graphics.line(self.location.x, self.location.y, self.location.x, self.location.y + self.size)
    love.graphics.line(self.location.x, self.location.y, self.location.x + self.size, self.location.y)

    love.graphics.line(self.location_sec.x + self.size, self.location_sec.y, self.location_sec.x + self.size, self.location_sec.y + self.size)
    love.graphics.line(self.location_sec.x, self.location_sec.y + self.size, self.location_sec.x + self.size, self.location_sec.y + self.size)
end
