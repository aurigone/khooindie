
require("src/objects")
local loader = require("tileloader.Loader")


LevelsManager = { map = nil }
LevelsManager.__index = LevelsManager


function LevelsManager:load(file)
    loader.path = "levels/"
end


function LevelsManager:loadLevel(name)
    map = loader.load(name .. ".tmx")
    map.useSpriteBatch = false    
    for _, layer in pairs(map.layers) do
        print(layer.class)
        if layer.class == "ObjectLayer" then
            for _, obj in pairs(layer.objects) do
                ObjectsManager:createObject(obj)
            end
        end
    end
--[[
    if file.background then
        local bg = file.background
        love.graphics.setBackgroundColor(bg[1] or 0, bg[2] or 0,
                                         bg[3] or 0, bg[4] or 255)
    end
    for i, object in ipairs(file.objects) do
        ObjectsManager:createObject(object.type, object.pos, object.attrs)
    end
-- ]]--
end


function LevelsManager:draw(pos, scale)
    -- map.tiles[4]:draw(100,100)
    map:autoDrawRange(pos.x, -pos.y, scale, 50)
    map:draw()
end
