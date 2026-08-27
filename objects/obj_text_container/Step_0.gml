image_alpha = lerp(image_alpha, place_meeting(x, y, obj_mouse) ? 0.5 : 0, 0.2);

if !got_signal("pressed") { exit; }
stop_signal("pressed");

if instance_exists(obj_main_menu) && !obj_main_menu.active_ui { exit; }
func();