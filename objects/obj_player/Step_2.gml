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
	var change_to_knockback = state != knockback_state && data.state == knockback_state;
	var change_from_knockback = state == knockback_state && data.state != knockback_state;
	var change_to_ghost = state != ghost_state && data.state == ghost_state;
	var change_from_ghost = state == ghost_state && data.state != ghost_state;
	
	var force_rubberband = obj_client.frame_data_delay >= 2000 ||
		change_to_knockback || change_from_knockback || change_to_ghost || change_from_ghost;
	
	if client_id != obj_client.client_id || force_rubberband { apply_struct(id, data); }
	stop_signal("received_data");
}