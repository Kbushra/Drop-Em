depth = -100;
if !got_signal("pressed") { exit; }

stop_signal("pressed");
if instance_exists(obj_main_menu) && !obj_main_menu.active_ui { exit; }

obj_main_menu.get_curr_path()[ind].func();
func();