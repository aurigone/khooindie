return {
    name = "poo",
    type = "WalkingEnemy",
    common_names = {"walking_enemy"},
    properties = {
        enemies = {"Player"},
    },
    animation = {
        image = "graphics/anim.png",
        frames = {
            idle = {
                {50, 4, 74, 61, 125, true},
            },
            right = {
                {50, 4, 74, 61, 125, true},
                {50, 68, 76, 125, 125, true},
                {50, 132, 78, 189, 125, true},
                {50, 196, 77, 253, 125, true}
            },
            left = {
                {50, 4, 74, 61, 125},
                {50, 68, 76, 125, 125},
                {50, 132, 78, 189, 125},
                {50, 196, 77, 253, 125}
            },
        }
    }
}
