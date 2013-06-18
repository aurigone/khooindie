

Physics = {
    world = nil,
    meter = 64,
    gravity = 9.81,
    objects = {}
}
Physics.__index = Physics


function Physics:load()
    love.physics.setMeter(self.meter)
    self.world = love.physics.newWorld(0, self.gravity*self.meter, true)
end

function Physics:dynamicObject(_shape, pos, size, mass)
    body = love.physics.newBody(self.world, pos.x, pos.y, "dynamic")
    shape = nil
    if _shape == "circle" then
        shape = love.physics.newCircleShape(size)
    elseif _shape == "rect" then
        shape = love.physics.newRectangleShape(pos.x, pos.y, size.w, size.h, 0)
    end
    fixture = love.physics.newFixture(body, shape, mass)
    res = {body = body, shape = shape, fixture = fixture}
    table.insert(self.objects, res)
    return res
end

function Physics:update(dt)
    if self.world ~= nil then
        self.world:update(dt)
    end
end
