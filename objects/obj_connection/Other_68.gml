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
	client_count = client_id + 1;
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
	var instance_ids = [];
	for (var i = 0; i < array_length(data.object_data); i++)
	{
		var obj = data.object_data[i];
		obj.object_index = asset_get_index(obj.object_index);
		
		if struct_exists(obj, "sprite_index") { obj.sprite_index = asset_get_index(obj.sprite_index); }
		if struct_exists(obj, "layer")
		{
			obj.layer = layer_exists(obj.layer) ?
				layer_get_id(obj.layer) :
				layer_create(obj.depth, obj.layer);
		}
		
		instances[$ obj.instance] ??= instance_create_depth(x, y, depth, obj.object_index);
		
		struct_remove(obj, "object_index");
		apply_struct(instances[$ obj.instance], obj);
		array_push(instance_ids, obj.instance);
	}
	
	var all_instance_ids = struct_get_names(instances);
	for (var i = 0; i < array_length(all_instance_ids); i++)
	{
		if array_contains(instance_ids, all_instance_ids[i]) { continue; }
		
		instance_destroy(instances[$ all_instance_ids[i]]);
		struct_remove(instances, all_instance_ids[i]);
	}
	
	client_count = data.client_count;
	server_last_alive = current_time;
	
	var keep_alive = buffer_struct({ type: NETWORK_TYPES.FRAME_DATA, client_id });
	network_send_udp(udp, server_ip, PORT, keep_alive.buffer, keep_alive.len);
	buffer_delete(keep_alive.buffer);
	exit;
}