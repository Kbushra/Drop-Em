if instance_exists(obj_host)
{
	while repeat_frame { event_perform(ev_step, ev_step_normal); }
	write_data(true, server_data());
	exit;
}

if !instance_exists(obj_client) { exit; }

var data = obj_client.frame_data[$ instance];
_score = data._score;

if !got_signal("received_data") { exit; }

//rubberbanding
if client_id != obj_client.client_id || data.state == BAT_STATES.KNOCKBACK { apply_struct(id, data); }

stop_signal("received_data");