return {
    name = "butty",
    type = "Player",
    common_names = {"player"},
    properties = {
        fixed_rotation = true
    },
    animation = {
        image = "graphics/anim.png",
        frames = {
            idle = {
                {0, 1, 1, 108, 149},
            },
            right = {
                {100, 1, 1, 108, 149},
                {100, 111, 1, 215, 160},
                {100, 218, 1, 348, 155},
                {100, 351, 1, 481, 151}
            },
            left = {
                {100, 1, 1, 108, 149, true},
                {100, 111, 1, 215, 160, true},
                {100, 218, 1, 348, 155, true},
                {100, 351, 1, 481, 151, true},
            }
        }
    }
}
