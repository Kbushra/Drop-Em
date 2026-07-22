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