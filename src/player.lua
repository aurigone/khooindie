

require("src/object")
require("src/input")
require("src/cameras")

Player = class(Object)


function Player:init(...)
    self:super():init(...)

    InputManager:bind("right", "move", self, {x = 1, y = 0})
    InputManager:bind("left", "move", self, {x = -1, y = 0})
    CameraManager:setObject(self)
end

function Player:move(arg)
    self.force = vector(arg.x, arg.y)
end
