

require("src/object")
require("src/input")
require("src/cameras")

Player = class(Object)


function Player:init(...)
    self:super():init(...)
    InputManager:bind_down("right", "move", self, {x = 1, y = 0})
    InputManager:bind_up("right", "move", self, {x = 0, y = 0})
    InputManager:bind_down("left", "move", self, {x = -1, y = 0})
    InputManager:bind_up("left", "move", self, {x = 0, y = 0})
    InputManager:bind_down("up", "move", self, {x = 0, y = -1})
    CameraManager:setObject(self)
end

function Player:move(arg)
    self.force = vector(arg.x, arg.y)
end
