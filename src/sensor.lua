
require("src.units.object")

Sensor = class(Object)
Sensor.type = "Sensor"


function Sensor:__init(obj, phys, radius)
    self.obj = obj
    self.phys = phys
    self.radius = radius
    self.shape = love.physics.newCircleShape(radius)
    self.fixture = love.physics.newFixture(phys.body, self.shape, 1)
    self.fixture:setSensor(true)
    self.fixture:setUserData(self)
end

function Sensor:collide(obj, coll)
    print("sensor, start", obj)
end

function Sensor:collideEnd(obj, coll)
    print("sensor, end", obj)
end
