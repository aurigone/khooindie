



InputManager = { bindings = {} }
InputManager.__index = InputManager


function InputManager:bind(key, callback, metha, args)
    print(key, callback, metha, args)
    self.bindings[key] = {
        object = metha,
        func = callback,
        args = args
    }
end

function InputManager:process()
    for name, bind in pairs(self.bindings) do
        if love.keyboard.isDown(name) then
            metha = bind.object or _G
            metha[bind.func](metha, bind.args)
        end
    end
end

