
require("src.units.unit")

WalkingEnemy = class(Unit)
WalkingEnemy.type = "WalkingEnemy"

function WalkingEnemy:__init(pos, proto)
    self[Unit]:__init(pos, proto)
    self.waypoints = stack()
    self.visible_range = proto.properties.visible_range or 600
    self.range = Physics:addSensor(self, self[Unit].phys, self.visible_range)
end


function WalkingEnemy:update(dt)
    self[Unit]:update(dt)
end
