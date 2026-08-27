depth = -200;
if !keyboard_check_pressed(vk_enter) { exit; }
if instance_exists(obj_main_menu) && !obj_main_menu.active_ui { exit; }
func();