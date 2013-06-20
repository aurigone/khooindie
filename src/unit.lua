
require("src.object")
require("src.physics")
vector = require("hump.vector")

Unit = class(Object, "Unit")


function Unit:init(sprite)
    self:super():init()
    self.pos = { x = 0, y = 0 }
    self.sprite = sprite
    self.speed = sprite.properties.speed or 100
    self.mass = sprite.properties.mass or 10
    self.jump_force = sprite.properties.jump_force or 2
    self.rotate = 0
    local pos = {x = sprite.x, y = sprite.y}
    local size = {w = sprite.width, h = sprite.height}
    self.phys = Physics:dynamicObject("rect", pos, size, self.mass, self)
    self.force = vector(0, 0)
    self._staticCollisions = {}
    self.impulses = stack()
end


function Unit:draw(pos, attr)
    p = { x = self.pos.x - self.sprite.width/2,
          y = self.pos.y + self.sprite.height/2 }
    if self.sprite.x ~= p.x or self.sprite.y ~= p.y then
        self.sprite.x = p.x
        self.sprite.y = p.y
        self.sprite:updateDrawInfo()
    end
end


function Unit:applyForce(dt)
    if self.phys == nil or self.phys.body == nil then return end
    -- Current mass
    local mass = self.phys.body:getMass()
    -- Current velocity
    local velocity = vector(self.phys.body:getLinearVelocity())
    local dumping = self.phys.body:getLinearDamping()
    -- Use half of speed when both forces applied
    local add = (0.5 * math.abs(self.force.x) * math.abs(self.force.y));
    -- Max velocity (does not count gravity)
    local mvel = vector(1.0 - add, 1.0 - add) * (self.speed / dt)
    -- Max force
    local mforce = self.force:permul(mvel / dt) * mass / Physics.meter

    -- Gravity influence <gravity> = ginf * dt
    local gscale = self.phys.body:getGravityScale()
    local ginf = (Physics.gravity * gscale) * dt
    -- Current force
    -- vel = <gravity> + <self>
    -- <self> = (F/m) * dt
    local cforce = (velocity - ginf) * mass / dt
    -- Force delta
    local dforce = mforce - cforce
    self.phys.body:applyForce(dforce.x, 0)
end


function Unit:applyImpulse(dt)
    local m = self.impulses:pop()
    if m ~= nil then
        local mass = self.phys.body:getMass()
        local momentum = m.direction * m.force * self.speed * mass / ( dt * Physics.meter)
        self.phys.body:applyLinearImpulse(momentum.x, momentum.y)
    end
end


function Unit:update(dt)
    local x, y = self.phys.body:getX(), self.phys.body:getY()
    if x ~= self.pos.x or y ~= self.pos.y then
        self.pos.x = x
        self.pos.y = y
    end
    self:applyForce(dt)
    self:applyImpulse(dt)
end

function Unit:move(arg)
    self.force = vector(arg.x, arg.y)
end

function Unit:jump(arg)
    if x == 0 and y == 0 then return end
    if self._inAir == false then
        self.impulses:push({
            direction=vector(arg.x, arg.y),
            force=self.jump_force
        })
    end
end

function Unit:collide(obj, coll)
    if obj._type == "Static" then
        self._inAir = false
    end
end

function Unit:collideEnd(obj, coll)
    if obj._type == "Static" then
        self._inAir = true
    end
end
