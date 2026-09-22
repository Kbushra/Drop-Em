array_push(obj_mouse.clickables, id);

if !instance_exists(list) { exit; }

var enabled = !got_signal("disable");
stop_signal("disable");

if !enabled
{
	stop_signal("pressed");
	stop_signal("hovered");
}

if got_signal("pressed")
{
	for (var i = 0; i < array_length(list.elements); i++)
	{
		var inst = list.elements[i].inst;
		with inst 
		{
			if id == other.id { continue; }
			focused = false;
		}
	}
	
	focused = true;
	stop_signal("pressed");
}

y = lerp_delta(y, focused ? targ_y - 10 : targ_y, 0.995);