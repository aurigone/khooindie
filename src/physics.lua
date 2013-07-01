
vector = require("hump.vector")

local dynamic_objects = {}
local static_objects = {}

Physics = {
    world = nil,
    meter = 64,
    gravity = vector(0, 9.81)
}
Physics.__index = Physics


function Physics:load()
    love.physics.setMeter(self.meter)
    local gpm = self.gravity * self.meter
    self.world = love.physics.newWorld(gpm.x, gpm.y, true)
    self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end


function Physics:baseObject(_type, _shape, position, size, obj)
    local body = love.physics.newBody(self.world, position.x, position.y, _type)
    body:setFixedRotation(obj.fixed_rotation)
    local shape = nil
    if _shape == "circle" then
        shape = love.physics.newCircleShape(size)
    elseif _shape == "rect" then
        shape = love.physics.newRectangleShape(0, 0, size.w, size.h)
    else
        assert(false, "Bad shape")
    end
    local fixture = love.physics.newFixture(body, shape, obj.mass)
    fixture:setUserData(obj)
    local res = {body = body, shape = shape, fixture = fixture}
    return res
end


function Physics:dynamicObject(_shape, pos, size, obj)
    local position = {x = pos.x + size.w/2, y = pos.y - size.h / 2}
    res = self:baseObject("dynamic", _shape, position, size, obj)
    table.insert(dynamic_objects, res)
    return res
end

function Physics:staticObject(_shape, pos, size, obj)
    local position = {x = pos.x + size.w/2, y = pos.y + size.h / 2}
    res = self:baseObject("static", _shape, position, size, obj)
    table.insert(static_objects, res)
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

    for i, object in ipairs(static_objects) do
        _draw(object)
    end
    for i, object in ipairs(dynamic_objects) do
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
    f:collideEnd(s, coll)
    s:collideEnd(f, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll)
end
