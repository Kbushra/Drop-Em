event_inherited();

if mouse_check_button_pressed(mb_left)
{
	if !got_signal("pressed")
	{
		focused = false;
		instance_destroy(type_bar);
	}
	else if !focused
	{
		focused = true;
		keyboard_string = initial_keyboard_string + typed_string;
		type_bar = instance_create_depth(x + 2, y + sprite_height/2, depth - 1, obj_type_bar);
		stop_signal("pressed");
	}
}

array_push(obj_mouse.clickables, id);

var enabled = !got_signal("disable");
stop_signal("disable");

if !keyboard_check_pressed(vk_enter) || !enabled { exit; }
func(id);