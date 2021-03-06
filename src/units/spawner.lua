

require("src.units.object")
require("src.utils")


Spawner = class(Object)
Spawner.type = "Spawner"


function Spawner:__init(pos, proto)
    self.pos = pos
    self.delay = proto.properties.delay or 0
    self.units_max = proto.properties.units_count or 1
    self.units_count = 0
    self.started = false
    self.disabled = proto.properties.disabled
    self.units = {}
    assert(proto.properties.types,
        "Spawner at " .. proto.x .. ":" .. proto.y .. " must have type.")
    local types = proto.properties.types:split(",")
    self.types = table.each(types, function(str)
                        return str:match("^%s*(.-)%s*$") end)
    self.typeset = set(self.types)
    self.checkpoint = self.typeset.player
    -- Hide spawner
    proto.visible = false
    proto:updateDrawInfo()
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
    if self.units_count < self.units_max then
        self:addTimer()
    end
    local random_type = self.types[math.random(#self.types)]
    local object = ObjectsManager:createObject(self.pos, random_type)
    if object ~= nil then
        if object.spawn then object:spawn(self) end
        table.insert(self.units, object)
    end
end


function Spawner:update(dt)
    if self.disabled or self.started then return end
    local pos = nil
    if not self.checkpoint then
        pos = ObjectsManager:PlayerPosition()
        if pos == nil then return end
    end
    self:addTimer()
end


function Spawner:free(obj)
    for k, v in ipairs(self.units) do
        if v[Object] == obj[Object] then
            self.units[k] = nil
            self.units_count = self.units_count - 1
        end
    end
end

