var coord = get_coord();

image_alpha = lerp(image_alpha, place_meeting(coord.x, coord.y, obj_mouse) ? 0.5 : 0, 0.2);
array_push(obj_mouse.clickables, id);

var enabled = !got_signal("disable");
stop_signal("disable");

if !enabled || !got_signal("pressed") { exit; }
stop_signal("pressed");

func();