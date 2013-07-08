
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

function set(list)
  local _set = {}
  for _, l in ipairs(list) do _set[l] = true end
  return _set
end

function table:each(func)
  local new_array = {}
  for i,v in ipairs(self) do
    new_array[i] = func(v)
  end
  return new_array
end

function table.copy(t)
  local u = { }
  for k, v in pairs(t) do u[k] = v end
  return setmetatable(u, getmetatable(t))
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
