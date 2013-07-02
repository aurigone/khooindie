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
                {0, 7, 2, 47, 60},
            },
            right = {
                {100, 7, 2, 47, 60},
                {100, 71, 5, 119, 61},
                {100, 136, 9, 173, 62},
                {100, 200, 8, 240, 63}
            },
            left = {
                {100, 7, 2, 47, 60, true},
                {100, 71, 5, 119, 61, true},
                {100, 136, 9, 173, 62, true},
                {100, 200, 8, 240, 63, true}
            }
        }
    }
}
