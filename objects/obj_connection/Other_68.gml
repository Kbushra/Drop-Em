print("networking");

if async_load[? "type"] == network_type_non_blocking_connect
{
	if !async_load[? "succeeded"] { server_ip = ""; exit; }
	
	connected = true;
	servers = {};
	alarm[0] = -1;
	room_goto(rm_level_1);
	exit;
}

if async_load[? "type"] == network_type_disconnect
{
	server_ip = "";
	connected = false;
	room_goto(rm_main);
	exit;
}

if async_load[? "type"] != network_type_data || !buffer_exists(async_load[? "buffer"]) ||
buffer_get_size(async_load[? "buffer"]) == 0 { exit; }

print("before dat");
buffer_seek(async_load[? "buffer"], buffer_seek_start, 0);
var data = json_parse(buffer_read(async_load[? "buffer"], buffer_string));
print($"type {data.type}");

if data.type == NETWORK_TYPES.DISCOVERY
{
	servers[$ data.name] =
	{
		creation_time: data.creation_time,
		discovery_time: EPOCH_TIME,
		ip: async_load[? "ip"]
	};
}

if data.type == NETWORK_TYPES.OBJECT_DATA
{
	print("received data");
	instance_destroy(obj_marker);
	for (var i = 0; i < array_length(data.object_data); i++)
	{
		print(data.object_data[i]);
		instance_create_depth(x, y, depth, obj_marker, data.object_data[i]);
	}
}