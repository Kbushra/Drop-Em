depth = -999;

var obj = noone;
var lowest_depth = 9999;
for (var i = 0; i < array_length(mouseables); i++)
{
	with mouseables[i]
	{
		if !place_meeting(x, y, other) || depth >= lowest_depth { continue; }
	
		lowest_depth = depth;
		obj = id;
	}
}

send_signal(obj, "hovered");
if mouse_check_button_pressed(mb_left) { send_signal(obj, "pressed"); }
if mouse_check_button(mb_left) { send_signal(obj, "held"); }
if mouse_check_button_released(mb_left) { send_signal(obj, "released"); }
mouseables = [];