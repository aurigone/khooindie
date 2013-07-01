

-- Animation class
Animation = { }
Animation.__index = Animation

function Animation:init()
    self.frames = self.def.frames
    self:set_frame("idle")
    self.tileset = self.def.tileset
    self.id = self.tileset.batch:addq(self.current_quad, 0, 0)
    self.timer = 0
    self.frame_start = 0
    self.stopped = false
    return self
end


function Animation:set_frame(name)
    self.stopped = false
    if name == self.current_frame_name then return end
    self.current_frame_name = name
    self.current_quads = self.frames._quads[name]
    self.current_durations = self.frames._duration[name]
    self:set_frame_index(1)
end

function Animation:set_frame_index(index)
    assert(self.current_quads, "No frame exists: " .. self.current_frame_name)
    self.current_index = index
    self.current_quad, self.current_size = unpack(self.current_quads[index])
    self.current_duration = self.current_durations[index] / 1000
    self.frame_start = self.timer
end

function Animation:update(dt)
    self.timer = self.timer + dt
    if self.current_duration > 0 and not self.stopped then
        if self.timer - self.frame_start > self.current_duration then
            self:next_frame()
            self.frame_start = self.timer
            return true
        end
    end
end

function Animation:next_frame()
    local frame = self.current_index
    if frame < #self.current_quads then
        frame = frame + 1
    else
        frame = 1
    end
    self:set_frame_index(frame)
end

function Animation:stop(index)
    self:set_frame_index(index or 1)
    self.stopped = true
end

function Animation:draw_current(pos)
    self.def.tileset.batch:setq(self.id, self.current_quad, pos.x, pos.y)
end
