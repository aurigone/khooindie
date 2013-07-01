
local resources = require("data.resources")

local prototypes = {}
local common_prototypes = {}

local function Prototype()
    return {}
end


local function get_common_proto(name)
    local protos = common_prototypes[name]
    if protos ~= nil then
        -- Crap
        local count = 0
        for _ in pairs(protos) do count = count + 1 end
        local randcount = math.random(count)
        count = 0
        for k, v in pairs(protos) do
            count = count + 1
            if count <= randcount then return v end
        end
    end
    return nil
end


function load_prototypes()
    for _, file in ipairs(resources.prototypes) do
        local proto = require(file)
        local common = proto.common_names
        if type(common) == "table" then
            for _, cname in ipairs(common) do
                if common_prototypes[cname] == nil then
                    common_prototypes[cname] = {}
                end
                common_prototypes[cname][proto.name] = proto
            end
        end
        prototypes[proto.name] = proto
    end
end


function get_proto(name)
    return get_common_proto(name) or prototypes[name]
end

function get_all_protos()
    return prototypes
end
