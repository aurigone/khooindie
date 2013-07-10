
require("src.units.object")

Sensor = class(Object)
Sensor.type = "Sensor"

CB_BEGIN = 1
CB_END = 2


function Sensor:__init(obj, phys, radius)
    self.obj = obj
    self.phys = phys
    self.radius = radius
    self.shape = love.physics.newCircleShape(radius)
    self.fixture = love.physics.newFixture(phys.body, self.shape, 1)
    self.fixture:setSensor(true)
    self.fixture:setUserData(self)
    self.callbacks_begin = {}
    self.callbacks_end = {}
end

function Sensor:__destroy()
    self.phys = nil
    for i,v in pairs(self.callbacks_begin) do
        self.callbacks_begin[i] = nil
    end
    for i,v in pairs(self.callbacks_end) do
        self.callbacks_end[i] = nil
    end
end

function Sensor:collide(obj, coll)
    self:callback(self.callbacks_begin, obj, coll)
end

function Sensor:collideEnd(obj, coll)
    self:callback(self.callbacks_end, obj, coll)
end

function Sensor:callback(callbacks, obj, coll)
    local t = obj.sprite and obj.sprite.type or obj.type
    local cbt = callbacks[t]
    if cbt == nil then return end
    for _, cb in ipairs(cbt) do
        local args = cb.args and table.copy(cb.args) or {}
        table.insert(args, obj)
        cb.f(unpack(args))
    end
end


function Sensor:addCallback(t, types, fun, args)
    local tb = nil
    if t == CB_BEGIN then
        tb = self.callbacks_begin
    elseif t == CB_END then
        tb = self.callbacks_end
    else
        assert(false, "Wrong callback type")
    end
    for _, target in pairs(types) do
        if tb[target] == nil then tb[target] = {} end
        table.insert(tb[target], {f=fun, args=args})
    end
end

