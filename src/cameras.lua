
require("src/utils")
hump_camera = require("hump/camera")


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
    InputManager:bind("right", "move", self, {x = 1, y = 0})
    InputManager:bind("left", "move", self, {x = -1, y = 0})
    InputManager:bind("up", "move", self, {x = 0, y = 1})
    InputManager:bind("down", "move", self, {x = 0, y = -1})
end

function CameraManager:setObject(object)
    self.object = object
end

function CameraManager:move(arg)
    local camera = CameraManager:top()
    camera:move(arg.x * 10, arg.y * 10)
end


function CameraManager:draw()
    local camera = self:top()
    assert(camera, "No cameras exist")
    local pos = { x = camera.x, y = camera.y }
    local scale = camera.scale
    if self.object ~= nil then
        local pos = self.object.pos
        camera:lookAt(pos.x, pos.y)
    end
    camera:attach()
    for _, target in ipairs(self.targets) do
        target:draw(pos, scale)
    end
    camera:detach()
end
