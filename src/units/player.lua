

require("src.units.unit")
require("src.input")
require("src.cameras")
require("src.physics")

Player = class(Unit)
Player.type = "Player"


function Player:__init(...)
    self[Unit]:__init(...)
    InputManager:bind_down("right", "move", self, {x = 1, y = 0})
    InputManager:bind_up("right", "move", self, {x = 0, y = 0})
    InputManager:bind_down("left", "move", self, {x = -1, y = 0})
    InputManager:bind_up("left", "move", self, {x = 0, y = 0})
    InputManager:bind_down("up", "jump", self, {x = 0, y = -1})
    CameraManager:setObject(self)
end

function Player:die()
    self:spawn(self[Unit].spawner)
end

function Player:update(dt)
    self[Unit]:update(dt)
    local pos = self[Unit].pos
    if pos.y > LevelsManager.height then
       self:die()
    end
end

