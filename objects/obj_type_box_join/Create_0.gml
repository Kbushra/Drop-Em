event_inherited();

func = function()
{
	if string_length(typed_string) != 6 || !instance_exists(obj_client) { exit; }
	
	network_send_struct(obj_client.wss, NETWORK_TYPES.JOIN, { join_code: typed_string });
}