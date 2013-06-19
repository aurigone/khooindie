



InputManager = {
    bindings_press = {},
    bindings_release = {},
}
InputManager.__index = InputManager



function InputManager:bind_down(key, callback, metha, args)
    self.bindings_press[key] = {
        object = metha,
        func = callback,
        args = args
    }
end

function InputManager:bind_up(key, callback, metha, args)
    self.bindings_release[key] = {
        object = metha,
        func = callback,
        args = args
    }
end


function InputManager:process_action(action)
    if action == nil then return end
    metha = action.object or _G
    metha[action.func](metha, action.args)
end


function love.keypressed(key)
    local action = InputManager.bindings_press[key]
    InputManager:process_action(action)
end

function love.keyreleased(key)
    local action = InputManager.bindings_release[key]
    InputManager:process_action(action)
end
