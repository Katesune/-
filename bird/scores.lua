Scores = {}
Scores.__index = Scores

function Scores:create(player)
    local scores = {}
    setmetatable(scores, Scores)
    scores.player = player
    scores.x = love.graphics.getWidth() / 2
    self.images = {}
    return scores
end

function Scores:draw()
    for i = 0, #self.images do
        if i == 0 then
            love.graphics.draw(self.images[i],self.x, 50,0,1,1)
        else
            love.graphics.draw(self.images[i],self.x + self.self.images[i]:getWidth(), 50,0,1,1)
        end
    end
end

function Scores:update()
end

function Scores:startScores()
    self.images[0] = love.graphics.newImage("assets/sprites/" .. tostring(self.player) .. ".png")
    self.x = self.x - self.images[0]:getWidth()/2
end


function Scores:addScored()
    scores.player = scores.player + 1

    local round = tostring(self.player):len()-1

    for i = round, -1, -1 do
        local mod = math.pow(10, i)
        self.images[i] = love.graphics.newImage("assets/sprites/" .. tostring(self.player) .. ".png")
        if i ~= 0 then
            self.x = self.x - self.images[i]:getWidth()/2
        end
    end

end
