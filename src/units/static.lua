

require("src.units.object")
require("src.physics")

Static = class(Object, "Static")

function Static:init(obj)
    self:super():init()
    self.phys = Physics:staticObject("rect", {x = obj.x, y = obj.y},
                            {w = obj.width, h = obj.height}, self)
end
