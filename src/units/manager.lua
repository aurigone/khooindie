
require("src.units.object")
require("src.units.static")
require("src.units.player")
require("src.units.spawner")
require("src.units.animation")


local objects = {}

ObjectsManager = { player = nil }
ObjectsManager.__index = ObjectsManager

function ObjectsManager:load()
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


function ObjectsManager:createObject(sprite, name)
    if type(sprite) == string then
        sprite = get_proto(sprite)
    end

    local metha_name = name or sprite.type
    metha_name = metha_name:gsub("^%l", string.upper)
    local metha = _G[metha_name]
    -- TODO: check if metha is Object subclass
    if metha ~= nil then
        local object = metha:create(sprite)
        table.insert(objects, object)
        if sprite.type == "player" then
            self.player = object
        end
    end
end
