
require("src.utils")
hump_camera = require("hump.camera")

local cameras = stack()
local targets = {}

CameraManager = {
    object = nil
}
CameraManager.__index = CameraManager


function CameraManager:push(x,y, zoom, rot)
    local c = hump_camera.new(x,y, zoom, rot)
    cameras:push(c)
end

function CameraManager:pop()
    cameras:pop()
end

function CameraManager:top()
    return cameras:top()
end

function CameraManager:addTarget(object)
    table.insert(targets, object)
end

function CameraManager:setObject(object)
    self.object = object
end

function CameraManager:move(arg)
    local camera = self:top()
    camera:move(arg.x * 10, arg.y * 10)
end

function CameraManager:getPos()
    local camera = self:top()
    assert(camera, "No cameras exist")
    local scale = camera.scale
    local w,h = love.graphics.getWidth(), love.graphics.getHeight()
    local mw, mh = LevelsManager:size()
    local px = self.object and self.object.pos.x or camera.x
    local py = self.object and self.object.pos.y or camera.y
    -- Check borders
    local dx = (px < w / 2) and w / 2 or (
               (px > mw - w/2) and mw - w/2 or px )
    local dy = (py < h / 2) and h / 2 or (
               (py > mh - h/2) and mh - h/2 or py )
    camera:lookAt(dx, dy)
    return camera, {x = camera.x*scale - w/2, y = camera.y*scale - h/2}
end

function CameraManager:draw()
    local camera, pos = self:getPos()
    camera:attach()
    for _, target in ipairs(targets) do
        target:draw(pos, scale)
    end
    camera:detach()
end
