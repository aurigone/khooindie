
require("src/utils")
hump_camera = require("hump/camera")


CameraManager = {
    cameras = stack(),
    targets = {}
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


function CameraManager:draw()
    local camera = self:top()
    assert(camera, "No cameras exist")
    local pos = { x = camera.x, y = camera.y }
    local scale = camera.scale
    camera:attach()
    for _, target in ipairs(self.targets) do
        target:draw(pos, scale)
    end
    camera:detach()
end
