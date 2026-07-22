if async_load[? "type"] == network_type_non_blocking_connect
{
	if !async_load[? "succeeded"] { server_ip = ""; exit; }
	
	room_goto(rm_level_1);
	exit;
}

if async_load[? "type"] != network_type_data { exit; }

var data = json_parse(buffer_read(async_load[? "buffer"], buffer_string));

if data.type == NETWORK_TYPES.DISCOVERY
{
	servers[$ data.name] =
	{
		creation_time: data.creation_time,
		discovery_time: EPOCH_TIME,
		ip: async_load[? "ip"]
	};
}