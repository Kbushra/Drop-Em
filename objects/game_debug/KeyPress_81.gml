///@desc Slow down game
if !keyboard_check(vk_control) { exit; }
game_set_speed(game_get_speed(gamespeed_fps) == 60 ? 2 : 60, gamespeed_fps);