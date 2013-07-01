
require("src.units.animation")
local resources = require("src.units.prototype")

local animations = {}
local images = {}
local batches = {}

local function setup_quad(rx, ty, lx, by, iw, ih)
    local width, height = lx - rx, by - ty
    return love.graphics.newQuad(rx, ty, width, height, iw, ih),
           {w = width, h = height}
end


local function init_frames(frames, iw, ih)
    local quads = {}
    local durations = {}
    for name, a in pairs(frames) do
        quads[name] = {}
        durations[name] = {}
        for _, frame in ipairs(a) do
            local duration, rx, ty, lx, by, mirrored = unpack(frame)
            local quad, size = setup_quad(rx, ty, lx, by, iw, ih)
            if mirrored then quad:flip(true, false) end
            table.insert(quads[name], {quad, size})
            table.insert(durations[name], duration)
        end
    end
    frames._quads = quads
    frames._duration = durations
end



function load_animations()
    local protos = get_all_protos()
    for _, proto in pairs(protos) do
        init_animation(proto.animation)

        -- Constructor
        proto.animation.new = function()
            local anim = {def = proto.animation}
            setmetatable(anim, Animation)
            return anim:init()
        end

        animations[proto.name] = proto.animation
    end
end


function init_animation(anim)
    local tileset = images[anim.image] or { }
    if tileset.image == nil then
        tileset.image = love.graphics.newImage(anim.image)
        tileset.image:setFilter("nearest", "linear")
        tileset.batch = love.graphics.newSpriteBatch(tileset.image, 30)
        table.insert(batches, tileset.batch)
    end

    -- Setup anim
    anim.tileset = tileset
    local iw, ih = tileset.image:getWidth(), tileset.image:getHeight()
    init_frames(anim.frames, iw, ih)
end

function draw_animations(pos)
    for _, batch in ipairs(batches) do
        love.graphics.draw(batch, 0, 0)
    end
end





