Scores = {}
Scores.__index = Scores

function Scores:create(first_player, second_player)
    local scores = {}
    setmetatable(scores, Scores)
    scores.first_player = first_player
    scores.second_player = second_player
    return scores
end

function Scores:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(44/255, 6/255, 163/255, 1)

    local mainFont = love.graphics.newFont('AtariClassic-Regular.ttf', 70)
    love.graphics.setFont(mainFont)

	love.graphics.print(tostring(self.first_player),20,20 )
    --love.graphics.line( 20, 80, 70, 80)
    love.graphics.print(tostring(self.second_player),710,20 )

    love.graphics.setColor(r, g, b, a)

end

function Scores:update(gamer_numer)
    if gamer_numer == 0 then self.first_player = self.first_player + 1
    else self.second_player = self.second_player + 1
    end

    if self.first_player == 9 then
        sound = love.audio.newSource("sound/victory.wav", "static")
        sound:play()
    end

    if self.second_player == 9 then
        sound = love.audio.newSource("sound/gameover.wav", "static")
        sound:play()
    end
end
