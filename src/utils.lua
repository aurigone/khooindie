

function class( baseClass, typename )

    local new_class = {}
    local class_mt = { __index = new_class }

    function new_class:create(...)
        local newinst = { _type = typename }
        setmetatable(newinst, class_mt)
        newinst:init(...)
        return newinst
    end

    if nil ~= baseClass then
        setmetatable(new_class, { __index = baseClass })
    end

    -- Implementation of additional OO properties starts here --

    -- Return the class object of the instance
    function new_class:class()
        return new_class
    end

    -- Return the super class object of the instance
    function new_class:super()
        return baseClass
    end

    -- Return true if the caller is an instance of theClass
    function new_class:isa(theClass)
        local b_isa = false

        local cur_class = new_class

        while ( nil ~= cur_class ) and ( false == b_isa ) do
            if cur_class == theClass then
                b_isa = true
            else
                cur_class = cur_class:super()
            end
        end

        return b_isa
    end

    return new_class
end


function load_file(name)
    local file = assert(loadfile(name))
    return file()
end


function stack(t)
    local Stack = {
        push = function(self, ...)
            for _, v in ipairs{...} do
                self[#self+1] = v
            end
        end,
        pop = function(self, num)
            local num = num or 1
            if num > #self then
                error("underflow in NewStack-created stack")
            end
            local ret = {}
            for i = num, 1, -1 do
                ret[#ret+1] = table.remove(self)
            end
            return unpack(ret)
        end,
        top = function(self)
            return self[#self]
        end
    }
    return setmetatable(t or {}, {__index = Stack})
end
