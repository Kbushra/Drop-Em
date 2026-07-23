image_alpha = lerp(image_alpha, place_meeting(x, y, obj_mouse) ? 0.5 : 0, 0.2);

if !got_signal("pressed") { exit; }
stop_signal("pressed");
func();