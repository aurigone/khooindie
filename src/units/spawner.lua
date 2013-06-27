

require("src.units.object")
require("src.utils")


Spawner = class(Object, "Spawner")


function Spawner:init(proto)
    self.delay = proto.properties.delay or 0
    self.units_max = proto.properties.units_count or 1
    self.started = false
    self.units_count = 0
    self.started = true
    assert(proto.properties.types,
        "Spawner at " .. proto.x .. ":" .. proto.y .. " must have type.")
    self.types = map(function(str)
            return str:match( "^%s*(.-)%s*$" )
        end, proto.properties.types:split(","))
end


function Spawner:addTimer()
    Timer:add(self.delay,
        function(...)
            self:action(...)
        end)
    self.started = true
end


function Spawner:action()
    if self.units_count >= self.units_max then return end
    self.units_count = self.units_count + 1
    if self.units < self.units_max then
        self:addTimer()
    end
    local random_type = self.types[math.random(#self.types)]
    table.insert(self.units, ObjectManager:createObject(random_type))
end


function Spawner:update(dt)
    if self.started then return end
    self:addTimer()
end
