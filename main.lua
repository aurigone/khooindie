
require("src.adddebug")
require("src.units.manager")
require("src.levels")
require("src.physics")
require("src.input")
require("src.utils")
require("src.cameras")
--profiler = require("profiler")
Timer = require("hump.timer").new()


function love.load(arg)
    if arg[#arg] == "-debug" then require("mobdebug").start() end
    love.graphics.setMode(1024, 768)
    CameraManager:push(0, 0, 1, 0)
    Physics:load()
    ObjectsManager:load()
    LevelsManager:load()
    LevelsManager:loadLevel("main")
    CameraManager:addTarget(ObjectsManager)
    CameraManager:addTarget(LevelsManager)
    CameraManager:addTarget(LevelsManager)
    CameraManager:addTarget(draw_animations)
    CameraManager:addTarget(Physics)
    if profiler then profiler.start() end
end


function love.update(dt)
    Physics:update(dt)
    ObjectsManager:process(dt)
    Timer:update(dt)
end

function love.draw()
    CameraManager:draw()
end

