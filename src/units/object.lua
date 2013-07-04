
require("3rdparty.unclasslib")

Object = class()
Object.type = "Object"

function Object:__init()
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
