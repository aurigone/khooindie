

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
    self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end


function Physics:baseObject(_type, _shape, position, size, mass, obj)
    local body = love.physics.newBody(self.world, position.x, position.y, _type)
    local shape = nil
    if _shape == "circle" then
        shape = love.physics.newCircleShape(size)
    elseif _shape == "rect" then
        shape = love.physics.newRectangleShape(0, 0, size.w, size.h)
    else
        assert(false, "Bad shape")
    end
    local fixture = love.physics.newFixture(body, shape, mass)
    fixture:setUserData(obj)
    local res = {body = body, shape = shape, fixture = fixture}
    return res
end


function Physics:dynamicObject(_shape, pos, size, mass, obj)
    print(pos.x, pos.y, size.w, size.w)
    local position = {x = pos.x + size.w/2, y = pos.y - size.h / 2}
    res = self:baseObject("dynamic", _shape, position, size, mass, obj)
    table.insert(self.dynamic_objects, res)
    return res
end

function Physics:staticObject(_shape, pos, size, obj)
    local position = {x = pos.x + size.w/2, y = pos.y + size.h / 2}
    res = self:baseObject("static", _shape, position, size, nil, obj)
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
    local f = a:getUserData()
    local s = b:getUserData()
    f:collide(s, coll)
    s:collide(f, coll)
end

function endContact(a, b, coll)
    local f = a:getUserData()
    local s = b:getUserData()
    f:collide(s, coll)
    s:collide(f, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll)
end
