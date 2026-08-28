if instance_exists(obj_host)
{
	write_data(true, server_data());
	exit;
}

if !instance_exists(obj_client) { exit; }

var data = obj_client.frame_data[$ instance];
if is_undefined(data) { exit; }

_score = data._score;
if got_signal("received_data")
{
	var force_rubberband = obj_client.frame_data_delay >= 1000 || data.state == BAT_STATES.KNOCKBACK;
	if client_id != obj_client.client_id || force_rubberband { apply_struct(id, data); }
	stop_signal("received_data");
}