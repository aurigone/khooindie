
require("src.objects")
require("src.physics")
local loader = require("tileloader.Loader")


LevelsManager = { map = nil }
LevelsManager.__index = LevelsManager


function LevelsManager:load(file)
    loader.path = "levels/"
end


function LevelsManager:loadLevel(name)
    map = loader.load(name .. ".tmx")
    if map.properties.background then
        local bg = loadstring(map.properties.background)()
        if bg ~= nil then
            love.graphics.setBackgroundColor(bg)
        end
    end
    for _, layer in pairs(map.layers) do
        if layer.class == "ObjectLayer" then
            if layer.name == "physics" then
                for _, obj in pairs(layer.objects) do
                    ObjectsManager:createObject(obj, "static")
                end
            else
                for _, obj in pairs(layer.objects) do
                    ObjectsManager:createObject(obj)
                end
            end
        end
    end
end


function LevelsManager:draw(pos, scale)
    -- map.tiles[4]:draw(100,100)
    map:autoDrawRange(-pos.x, -pos.y, scale, 50)
    map:draw()
end
