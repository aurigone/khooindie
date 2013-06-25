

local resources = require("data.resources")

local animations = {}
local images = {}

function load_animations()
    for _, file in ipairs(resources.animations) do
        local anim = require(file)
        init_animation(anim)
        animations[anim.name] = anim
    end
end

function init_animation(anim)
    local tileset = images[anim.image] or { }
    if tileset.image == nil then
        tileset.image = love.graphics.newImage(anim.image)
        tileset.image:setFilter("nearest", "linear")
        tileset.batch = love.graphics.newSpriteBatch(tileset.image, 30)
    end

    local quads = {}
    for name, a in ipairs(anim.frames_action) do
        quads[name] = {}
        for _, frame in a do
            rx, ty, lx, by, mirrored = unpack(frame)
            width, height = lx - rx, by - ty
            if mirrored then
                width = - width
                rx, lx = lx, rx
            end
            local quad = love.graphics.newQuad(rx, ty, width, height,
                            tileset.image:getWidth(), tileset.image:getHeight())
            table.insert(quads[name], quad)
        end
    end

    -- Setup anim
    anim.tileset = tileset
    anim.quads = quads
end

function get_animation(name)
    local anim = {def = animations[name]}
    setmetatable(anim, Animation)
    return anim
end


-- Animation class
local Animation = { }
Animation.__index = Animation




