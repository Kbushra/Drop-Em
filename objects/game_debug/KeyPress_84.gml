///@desc Control all players
if !instance_exists(obj_server) || !keyboard_check(vk_control) { exit; }
control_all_players = !control_all_players;