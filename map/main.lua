require("vector")
require("flowmap")
require("vehicle")


function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    flow = FlowMap:create(40, 40, 40)
    flow:init()

    vehicles = {}

    for i=0, 50 do
        local x = math.random(100, 1100)
        local y = math.random(100, 700)
        vehicles[i] = Vehicle:create(x, y)
        vehicles[i].velocity.x = 1
        vehicles[i].velocity.y = 10
    end

    vehicle = Vehicle:create(width/2, height/2)
    vehicle.velocity.x = 1
    vehicle.velocity.y = 1.5
end

function love.update(dt)

    for i = 1, #vehicles do
        vehicles[i]:borders()
        vehicles[i]:update()
        vehicles[i]:follow(flow)
    end

    vehicle:borders()
    vehicle:update()
    vehicle:follow(flow)
end

function love.draw()
    flow:draw()

    for i = 1, #vehicles do
        vehicles[i]:draw()
    end

    vehicle:draw()
end

math.randomseed(os.time())
