
require("src.utils")


Object = class({}, "Object")

function Object:init()
end

function Object:draw(pos, attr)
end

function Object:update(dt)
end

-- Collision callbacks
-- Redefined in subclass if needed
function Object:collide(obj, coll)
end

function Object:collideEnd(obj, coll)
end
