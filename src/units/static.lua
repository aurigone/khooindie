

require("src.units.object")
require("src.physics")

Static = class(Object, "Static")

function Static:init(pos, obj)
    self:super():init()
    self.phys = Physics:staticObject("rect", {x = pos.x, y = pos.y},
                            {w = obj.width, h = obj.height}, self)
end
