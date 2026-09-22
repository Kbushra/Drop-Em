depth = -10000;

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