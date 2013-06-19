

Physics = {
    world = nil,
    meter = 64,
    gravity = 9.81,
    dynamic_objects = {},
    static_objects = {}
}
Physics.__index = Physics


function Physics:load()
    love.physics.setMeter(self.meter)
    self.world = love.physics.newWorld(0, self.gravity*self.meter, true)
    --self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end


function Physics:dynamicObject(_shape, pos, size, mass)
    print(pos.x, pos.y, size.w, size.w)
    local position = {x = pos.x + size.w/2, y = pos.y - size.h / 2}
    local body = love.physics.newBody(self.world, position.x, position.y, "dynamic")
    local shape = nil
    if _shape == "circle" then
        shape = love.physics.newCircleShape(size)
    elseif _shape == "rect" then
        shape = love.physics.newRectangleShape(0, 0, size.w, size.h)
    end
    local fixture = love.physics.newFixture(body, shape, mass)
    local res = {body = body, shape = shape, fixture = fixture}
    table.insert(self.dynamic_objects, res)
    --return res
    return res
end


function Physics:staticObject(_shape, pos, size)
    print(pos.x, pos.y, size.w, size.h)
    local position = {x = pos.x + size.w/2, y = pos.y + size.h / 2}
    local body = love.physics.newBody(self.world, position.x, position.y, "static")
    local shape = nil
    if _shape == "circle" then
        shape = love.physics.newCircleShape(size)
    elseif _shape == "rect" then
        shape = love.physics.newRectangleShape(0, 0, size.w, size.h)
    else
        assert(false, "Bad shape")
    end
    local fixture = love.physics.newFixture(body, shape)
    local res = {body = body, shape = shape, fixture = fixture}
    table.insert(self.static_objects, res)
    return res
end

function Physics:update(dt)
    if self.world ~= nil then
        self.world:update(dt)
    end
end


function Physics:draw(pos, arg)
    local mode = "line"
    function _draw(obj)
        love.graphics.circle(mode, obj.body:getX(), obj.body:getY(), 10)
        love.graphics.quad(mode, obj.body:getWorldPoints(obj.shape:getPoints()))
    end

    for i, object in ipairs(self.static_objects) do
        _draw(object)
    end
    for i, object in ipairs(self.dynamic_objects) do
        _draw(object)
    end
end




function beginContact(a, b, coll)
    x,y = coll:getNormal()
    print("\n", a:getUserData(), " colliding with ", b:getUserData(), " with a vector normal of: ", x, ", ", y)
end

function endContact(a, b, coll)
    persisting = 0
    print("\n", a:getUserData(), " uncolliding with ", b:getUserData())
end

persisting = 0

function preSolve(a, b, coll)
    if persisting == 0 then    -- only say when they first start touching
        print("\n", a:getUserData(), " touching ", b:getUserData())
    elseif persisting < 20 then    -- then just start counting
        print(" ", persisting)
    end
    persisting = persisting + 1    -- keep track of how many updates they've been touching for
end

function postSolve(a, b, coll)
end
