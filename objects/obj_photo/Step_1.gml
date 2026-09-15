array_push(obj_mouse.clickables, id);

if got_signal("pressed") && instance_exists(list)
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

if got_signal("disable") { focused = false; }
y = lerp_delta(y, focused ? targ_y - 10 : targ_y, 0.995);