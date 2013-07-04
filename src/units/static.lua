

require("src.units.object")
require("src.physics")

Static = class(Object)
Static.type = "Static"


function Static:__init(pos, obj)
    self.phys = Physics:staticObject("rect", {x = pos.x, y = pos.y},
                            {w = obj.width, h = obj.height}, self)
end
