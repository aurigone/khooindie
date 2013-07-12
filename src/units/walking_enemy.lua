
require("src.units.unit")

WalkingEnemy = class(Unit)
WalkingEnemy.type = "WalkingEnemy"

function WalkingEnemy:__init(pos, proto)
    self[Unit]:__init(pos, proto)
    self.waypoints = stack()
    self.visible_range = proto.properties.visible_range or 600
    self.enemies = proto.properties.enemies or {}
    self.sensor = Physics:addSensor(self, self[Unit].phys, self.visible_range)
    if #self.enemies > 0 then
        self.sensor:addCallback(CB_BEGIN, self.enemies, self:chaintop().spot, {self:chaintop()})
    end
end

function WalkingEnemy:__destroy()
    self[Unit]:__destroy()
    self.sensor = nil
end

function WalkingEnemy:update(dt)
    self[Unit]:update(dt)
    local pos = self[Unit].pos
    local waypoint = self.waypoints:top()
    if waypoint then
        local x = waypoint.x - self[Unit].pos.x
        local y = waypoint.y - self[Unit].pos.y
        self:move({x = math.abs(x)/x, y = math.abs(y)/y})
    end
    if pos.y > LevelsManager.height then
       self:die()
    end
end

function WalkingEnemy:spot(obj)
    self.waypoints:push(obj:get("pos"))
end
