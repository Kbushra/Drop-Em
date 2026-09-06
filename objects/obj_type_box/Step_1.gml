depth = -200;
var enabled = !got_signal("disable");
stop_signal("disable");

if !keyboard_check_pressed(vk_enter) || !enabled { exit; }
func(id);