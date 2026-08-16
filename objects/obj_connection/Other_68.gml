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
	var discovered_server = get_server(async_load[? "ip"]);
	if discovered_server != NONE { discovered_server.discovery_time = current_time; exit; }
	
	array_push(servers,
	{
		name: data.name,
		discovery_time: current_time,
		ip: async_load[? "ip"]
	});
	exit;
}

if data.type == NETWORK_TYPES.CONNECTED
{
	if !data.joinable
	{
		network_destroy(tcp);
		tcp = network_create_socket(network_socket_tcp);
		server_ip = "";
		exit;
	}
	
	client_id = data.client_id;
	client_count = client_id + 1;
	connected = true;
	
	servers = {};
	server_last_alive = current_time;
	room_goto(rm_level_1);
	exit;
}

if data.type == NETWORK_TYPES.FRAME_DATA
{
	object_data = data.object_data;
	var curr_instance_ids = struct_get_names(object_data);
	
	for (var i = 0; i < array_length(curr_instance_ids); i++)
	{
		var obj = object_data[$ curr_instance_ids[i]];
		
		obj.object_index = asset_get_index(obj.object_index);
		if struct_exists(obj, "sprite_index") { obj.sprite_index = asset_get_index(obj.sprite_index); }
		if struct_exists(obj, "layer")
		{
			obj.layer = layer_exists(obj.layer) ?
				layer_get_id(obj.layer) :
				layer_create(obj.depth, obj.layer);
		}
		
		if !instances[$ curr_instance_ids[i]]
		{
			instances[$ curr_instance_ids[i]] = instance_create_depth(x, y, depth, obj.object_index);
			apply_struct(instances[$ curr_instance_ids[i]], obj);
		}
		
		send_signal(instances[$ curr_instance_ids[i]], "received_data");
	}
	
	var all_instance_ids = struct_get_names(instances);
	for (var i = 0; i < array_length(all_instance_ids); i++)
	{
		if array_contains(curr_instance_ids, all_instance_ids[i]) { continue; }
		
		instance_destroy(instances[$ all_instance_ids[i]]);
		struct_remove(instances, all_instance_ids[i]);
	}
	
	client_count = data.client_count;
	server_last_delay = current_time - server_last_alive;
	server_last_alive = current_time;
	exit;
}