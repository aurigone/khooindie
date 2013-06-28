

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
            -- Nothing in stack
            if #self == 0 then return nil end
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


function table:each(func)
  local new_array = {}
  for i,v in ipairs(self) do
    new_array[i] = func(v)
  end
  return new_array
end



function string:split(sSeparator, nMax, bRegexp)
    assert(sSeparator ~= '')
    assert(nMax == nil or nMax >= 1)

    local aRecord = {}

    if self:len() > 0 then
        local bPlain = not bRegexp
        nMax = nMax or -1

        local nField=1 nStart=1
        local nFirst,nLast = self:find(sSeparator, nStart, bPlain)
        while nFirst and nMax ~= 0 do
            aRecord[nField] = self:sub(nStart, nFirst-1)
            nField = nField+1
            nStart = nLast+1
            nFirst,nLast = self:find(sSeparator, nStart, bPlain)
            nMax = nMax-1
        end
        aRecord[nField] = self:sub(nStart)
    end

    return aRecord
end
