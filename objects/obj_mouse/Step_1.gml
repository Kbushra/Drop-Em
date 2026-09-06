depth = -999;

var obj = noone;
var lowest_depth = 9999;
for (var i = 0; i < array_length(clickables); i++)
{
	with clickables[i]
	{
		if !place_meeting(x, y, other) || depth >= lowest_depth { continue; }
	
		lowest_depth = depth;
		obj = id;
	}
}

send_signal(obj, mouse_check_button_pressed(mb_left) ? "pressed" : "hovered");
clickables = [];