depth = -10000;

if server_side
{
	calculate_id();
	write_data(false, { server_side, targ_room_name: room_get_name(targ_room) });
	
	if got_signal("received_data")
	{
		var data = obj_client.frame_data[$ instance];
		targ_room = asset_get_index(data.targ_room_name);
	}
}

var spd = DELTA * 2;

if first_pass.maximum < 1
{
	first_pass.maximum = clamp(first_pass.maximum + spd, 0, 1);
}

if first_pass.maximum >= 0.5 && second_pass.maximum < 1
{
	second_pass.maximum = clamp(second_pass.maximum + spd, 0, 1);
}

if first_pass.maximum < 1 || second_pass.maximum < 1
{
	with obj_element { send_signal(id, "disable"); }
	exit;
}

if !transitioned
{
	if room_exists(targ_room) { room_goto(targ_room); }
	callback();
	transitioned = true;
}

if first_pass.minimum < 1
{
	first_pass.minimum = clamp(first_pass.minimum + spd, 0, 1);
}

if first_pass.minimum >= 0.5 && second_pass.minimum < 1
{
	second_pass.minimum = clamp(second_pass.minimum + spd, 0, 1);
}

if first_pass.minimum < 1 || second_pass.minimum < 1 { exit; }

instance_destroy();