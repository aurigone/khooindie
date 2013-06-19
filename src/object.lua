
require("src/utils")
require("src/physics")
vector = require("hump/vector")

Object = class()


function Object:init(sprite)
    self.pos = { x = 0, y = 0 }
    self.sprite = sprite
    self.speed = sprite.speed or 100
    self.rotate = 0
    local pos = {x = sprite.x, y = sprite.y}
    local size = {w = sprite.width, h = sprite.height}
    self.phys = Physics:dynamicObject("rect", pos, size, 1)
    self.force = vector(0, 0)
end


function Object:draw(pos, attr)
    p = { x = self.pos.x - self.sprite.width/2,
          y = self.pos.y + self.sprite.height/2 }
    if self.sprite.x ~= p.x or self.sprite.y ~= p.y then
        self.sprite.x = p.x
        self.sprite.y = p.y
        self.sprite:updateDrawInfo()
    end
end


function Object:applyForce(dt)
    if self.phys == nil or self.phys.body == nil then return end
    -- Current mass
    local mass = self.phys.body:getMass()
    -- Current velocity
    local velocity = vector(self.phys.body:getLinearVelocity())
    local dumping = self.phys.body:getLinearDamping()
    -- Use half of speed when both forces applied
    local add = (0.5 * math.abs(self.force.x) * math.abs(self.force.y));
    -- Max velocity
    local mvel = vector(1.0 - add, 1.0 - add) * (self.speed / ( dt * dt * Physics.meter ) )
    -- Max force
    local mforce = mvel * mass
    -- Current force
    local cforce = velocity * mass / ( dt * Physics.meter)
    -- Force delta
    local dforce = self.force:permul(mforce - cforce)
    -- Velocity delta
    if self.force.x ~= 0 or self.force.y ~= 0 then
        print("=======")
        print(velocity, mass)
        print(cforce,mforce)
        print(dforce)
        print("=======")
    end

    --local dvel = mvel - (velocity * dumping)
    -- Max force
    --local mforce = dvel:permul(self.force) *  mass / dt
    self.phys.body:applyForce(dforce.x, dforce.y)
    --self.phys.body:applyForce(mforce.x, mforce.y)
end


function Object:update(dt)
    local x, y = self.phys.body:getX(), self.phys.body:getY()
    if x ~= self.pos.x or y ~= self.pos.y then
        self.pos.x = x
        self.pos.y = y
    end
    self:applyForce(dt)
end
