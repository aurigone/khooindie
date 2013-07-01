return {
    name = "poo",
    type = "Unit",
    common_names = {"walking_enemy"},
    properties = { },
    animation = {
        image = "graphics/anim.png",
        frames = {
            idle = {
                {0, 163, 1, 133, 275, true},
            },
            right = {
                {50, 163, 1, 133, 275, true},
                {50, 137, 163, 207, 273, true},
                {50, 273, 158, 405, 273, true},
                {50, 408, 154, 540, 274, true}
            },
            left = {
                {50, 163, 1, 133, 275},
                {50, 137, 163, 207, 273},
                {50, 273, 158, 405, 273},
                {50, 408, 154, 540, 274}
            },
        }
    }
}
