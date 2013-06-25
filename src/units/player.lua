

require("src.units.unit")
require("src.input")
require("src.cameras")

Player = class(Unit, "Player")


function Player:init(...)
    self:super():init(...)
    InputManager:bind_down("right", "move", self, {x = 1, y = 0})
    InputManager:bind_up("right", "move", self, {x = 0, y = 0})
    InputManager:bind_down("left", "move", self, {x = -1, y = 0})
    InputManager:bind_up("left", "move", self, {x = 0, y = 0})
    InputManager:bind_down("up", "jump", self, {x = 0, y = -1})
    CameraManager:setObject(self)
end
