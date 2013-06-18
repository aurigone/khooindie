
require("src/utils")
require("src/physics")
vector = require("hump/vector")

Object = class({pos = {
    x = 0,
    y = 0
}})


function Object:init(sprite)
    self.sprite = sprite
    --self.image:setFilter("nearest","nearest")
    self.speed = sprite.speed or 100
    -- self.size = attr["size"] or 1
    self.rotate = 0
    pos = {x = sprite.x, y = sprite.y}
    size = {w = sprite.width, h = sprite.height}
    --local size = {w = sprite.width, h = sprite.height}
    self.phys = Physics:dynamicObject("rect", pos, size, 1)
    self.force = vector(0, 0)
end


function Object:draw(pos, attr)
    
end




function Object:applyForce(dt)
    if self.phys == nil or self.phys.body == nil then return end

    -- Use half of speed when both forces applied
    local add = (0.5 * math.abs(self.force.x) * math.abs(self.force.y));
    -- Max velocity
    -- FIXME: Magic value must be function of time delta
    local mvel = vector(1.0 - add, 1.0 - add) * (self.speed / (dt * dt * Physics.meter) )
    -- Current velocity
    local velx, vely = self.phys.body:getLinearVelocity()
    local velocity = vector(velx, vely)
    local dumping = self.phys.body:getLinearDamping()
    -- Velocity delta
    local dvel = mvel - (velocity * dumping)
    -- Max force
    local mforce = dvel:permul(self.force) * self.phys.body:getMass()
    self.phys.body:applyForce(mforce.x, mforce.y)
    --dforce = mforce - physBody->f;
    --physBody->v_limit = p;
    --cpBodyApplyForce( physBody, dforce, cpvzero );
end


function Object:update(dt)
    local x, y = self.phys.body:getX(), self.phys.body:getY()
    if x ~= self.pos.x or y ~= self.pos.y then
        self.sprite.x, self.pos.x = x, x
        self.sprite.y, self.pos.y = y, y
        self.sprite:updateDrawInfo()
    end
    self:applyForce(dt)
end
