
require("src.utils")
hump_camera = require("hump.camera")


CameraManager = {
    cameras = stack(),
    targets = {},
    object = nil
}
CameraManager.__index = CameraManager


function CameraManager:push(x,y, zoom, rot)
    local c = hump_camera.new(x,y, zoom, rot)
    self.cameras:push(c)
end

function CameraManager:pop()
    self.cameras:pop()
end

function CameraManager:top()
    return self.cameras:top()
end

function CameraManager:addTarget(object)
    table.insert(self.targets, object)
end

function CameraManager:setObject(object)
    self.object = object
end

function CameraManager:move(arg)
    local camera = CameraManager:top()
    camera:move(arg.x * 10, arg.y * 10)
end

function to_pos(x, y, scale)
    local w,h = love.graphics.getWidth(), love.graphics.getHeight()
    return {x = x*scale - w/2, y = y*scale - h/2}
end

function CameraManager:draw()
    local camera = self:top()
    assert(camera, "No cameras exist")
    local w,h = love.graphics.getWidth(), love.graphics.getHeight()
    if self.object ~= nil then
        camera:lookAt(self.object.pos.x, self.object.pos.y)
    end
    local pos = to_pos(camera.x, camera.y, camera.scale)

    camera:attach()
    for _, target in ipairs(self.targets) do
        target:draw(pos, scale)
    end
    camera:detach()
end
