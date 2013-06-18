

require("src/object")
require("src/input")
require("src/cameras")

Player = class(Object)


function Player:init(...)
    self:super():init(...)

    InputManager:bind("right", "move", self, {x = 1, y = 0})
    InputManager:bind("left", "move", self, {x = -1, y = 0})
    local camera = CameraManager:top()
    camera:lookAt(-self.sprite.x, -self.sprite.y)
end

function Player:move(arg)
    self.force = vector(arg.x, arg.y)
    local camera = CameraManager:top()
    print(self.sprite.x, self.sprite.y)
    camera:lookAt(self.sprite.x, self.sprite.y)
end
