update_coord();
if !clickable { exit; }

array_push(obj_mouse.clickables, id);

image_alpha = lerp(image_alpha, got_signal("hovered") ? 0.5 : 0, 0.2);
stop_signal("hovered");

var enabled = !got_signal("disable");
stop_signal("disable");

if !enabled || !got_signal("pressed") { exit; }
stop_signal("pressed");

image_alpha = 0;
func();