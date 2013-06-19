
require("src/object")
require("src/static")
require("src/player")


ObjectsManager = { objects = {}, player = nil }
ObjectsManager.__index = ObjectsManager

function ObjectsManager:load()

end

function ObjectsManager:process(dt)
    for i, object in ipairs(self.objects) do
        object:update(dt)
    end
end


function ObjectsManager:draw()
    for i, object in ipairs(self.objects) do
        object:draw()
    end
end

function ObjectsManager:createObject(sprite, name)
    local metha_name = name or sprite.type
    metha_name = metha_name:gsub("^%l", string.upper)
    local metha = _G[metha_name]
    -- TODO: check if metha is Object subclass
    if metha ~= nil then
        local object = metha:create(sprite)
        table.insert(self.objects, object)
        if sprite.type == "player" then
            self.player = object
        end
    end
end
