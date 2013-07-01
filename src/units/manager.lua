
require("src.units.object")
require("src.units.static")
require("src.units.player")
require("src.units.spawner")
require("src.units.prototype")
require("src.units.animations")


local objects = {}

ObjectsManager = { player = nil }
ObjectsManager.__index = ObjectsManager

function ObjectsManager:load()
    load_prototypes()
    load_animations()
end

function ObjectsManager:process(dt)
    for i, object in ipairs(objects) do
        object:update(dt)
    end
end


function ObjectsManager:draw()
    for i, object in ipairs(objects) do
        object:draw()
    end
end


function ObjectsManager:createObject(pos, proto, name)
    local sprite
    if type(proto) == "string" then
        sprite = get_proto(proto)
    else
        sprite = proto
    end

    if sprite == nil then
        print("Sprite not created for proto: " .. proto)
        return
    end


    local metha_name = name or sprite.type

    metha_name = metha_name:gsub("^%l", string.upper)
    local metha = _G[metha_name]
    -- TODO: check if metha is Object subclass
    if metha ~= nil then
        local position = pos and {x = pos.x, y = pos.y} or  {x = sprite.x, y = sprite.y}
        local object = metha:create(position, sprite)
        table.insert(objects, object)
        if sprite.type == "player" then
            self.player = object
        end
        return object
    end
end
