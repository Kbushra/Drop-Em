if async_load[? "type"] == network_type_non_blocking_connect && !async_load[? "succeeded"]
{
	server_ip = "";
	exit;
}

if async_load[? "type"] != network_type_data || !buffer_exists(async_load[? "buffer"]) ||
buffer_get_size(async_load[? "buffer"]) == 0 { exit; }

buffer_seek(async_load[? "buffer"], buffer_seek_start, 0);
var data = json_parse(buffer_read(async_load[? "buffer"], buffer_string));

if data.type == NETWORK_TYPES.DISCOVERY
{
	servers[$ data.name] =
	{
		creation_time: data.creation_time,
		discovery_time: EPOCH_TIME,
		ip: async_load[? "ip"]
	};
	exit;
}

if data.type == NETWORK_TYPES.CONNECTED
{
	if !data.success
	{
		network_destroy(tcp);
		tcp = network_create_socket(network_socket_tcp);
		exit;
	}
	
	client_id = data.client_id;
	connected = true;
	servers = {};
	server_last_alive = current_time;
	alarm[0] = -1;
	room_goto(rm_level_1);
	
	var udp_data = buffer_struct({ type: NETWORK_TYPES.GET_UDP_PORT, client_id });
	network_send_udp(udp, server_ip, PORT, udp_data.buffer, udp_data.len);
	buffer_delete(udp_data.buffer);
	exit;
}

if data.type == NETWORK_TYPES.FRAME_DATA
{
	var ids = [];
	for (var i = 0; i < array_length(data.object_data); i++)
	{
		var obj = data.object_data[i];
		obj.sprite_index = asset_get_index(obj.sprite_index);
		obj.layer = layer_exists(obj.layer) ?
			layer_get_id(obj.layer) :
			layer_create(obj.depth, obj.layer);
		
		markers[$ obj._id] ??= instance_create_depth(x, y, depth, obj_marker);
		apply_struct(markers[$ obj._id], obj);
		array_push(ids, obj._id);
	}
	
	with (obj_marker)
	{
		if array_contains(ids, _id) { continue; }
		
		markers[$ _id] = undefined;
		instance_destroy();
	}
	
	client_count = data.client_count;
	server_last_alive = current_time;
	
	var keep_alive = buffer_struct({ type: NETWORK_TYPES.FRAME_DATA, client_id });
	network_send_udp(udp, server_ip, PORT, keep_alive.buffer, keep_alive.len);
	buffer_delete(keep_alive.buffer);
	exit;
}