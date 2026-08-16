if instance_exists(obj_server)
{
	write_data(true, server_data());
	exit;
}

if !instance_exists(obj_connection) { exit; }

var data = obj_connection.object_data[$ instance];
_score = data._score;

if !got_signal("received_data") { exit; }

if client_id != obj_connection.client_id || obj_connection.server_last_delay > 0.5 ||
data.state == BAT_STATES.KNOCKBACK { apply_struct(id, data); } //rubberbanding

stop_signal("received_data");