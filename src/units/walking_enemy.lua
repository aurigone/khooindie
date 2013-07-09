
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
        self.sensor:addCallback(CB_BEGIN, self.enemies, self.spot, {self})
    end
end

function WalkingEnemy:update(dt)
    self[Unit]:update(dt)
    local waypoint = self.waypoints:top()
    if waypoint then
        local x = waypoint.x - self[Unit].pos.x
        local y = waypoint.y - self[Unit].pos.y
        self:move({x = math.abs(x)/x, y = math.abs(y)/y})
    end
end

function WalkingEnemy:spot(obj)
    self.waypoints:push(obj:get("pos"))
end
