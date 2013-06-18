
require("src/adddebug")
require("src/objects")
require("src/levels")
require("src/physics")
require("src/input")
require("src/utils")
require("src/cameras")


function love.load()
    CameraManager:push(0, 0, 1, 0)
    Physics:load()
    ObjectsManager:load()
    LevelsManager:load()
    LevelsManager:loadLevel("main")
    CameraManager:addTarget(LevelsManager)
end

function love.update(dt)
    InputManager:process()
    ObjectsManager:process(dt)
    Physics:update(dt)
end

function love.draw()
    CameraManager:draw()
end

