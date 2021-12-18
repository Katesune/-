Scores = {}
Scores.__index = Scores

function Scores:create(player)
    local scores = {}
    setmetatable(scores, Scores)
    scores.player = player
    scores.image = love.graphics.newImage("assets/sprites/0.png")
    return scores
end

function Scores:draw()
    love.graphics.draw(self.image,132, 50,0,1,1)
end

function Scores:update()

    self.image = tostring(self.player)
    self.image = love.graphics.newImage("assets/sprites/" .. self.image .. ".png")

   --[[ if self.player == 9 then
        sound = love.audio.newSource("victory.wav", "static")
        sound:play()
        love.graphics.print("Congratulations! You won!",width/2,height/2 )
    end]]
end
