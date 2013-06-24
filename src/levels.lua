
require("src.objects")
require("src.physics")
local loader = require("tileloader.Loader")


LevelsManager = { map = nil }
LevelsManager.__index = LevelsManager


function LevelsManager:load(file)
    loader.path = "levels/"
end


function LevelsManager:size()
    return self.width, self.height
end


function LevelsManager:loadLevel(name)
    map = loader.load(name .. ".tmx")
    self.width = map.width * map.tileWidth
    self.height = map.height * map.tileHeight
    local bgstr = map.properties.background
    if bgstr then
        local bg = loadstring(bgstr)()
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
    map:autoDrawRange(-pos.x, -pos.y, scale, map.tileWidth * 4 + 1)
    map:draw()
end
