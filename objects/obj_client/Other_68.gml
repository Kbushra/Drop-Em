if async_load[? "type"] != network_type_data { exit; }

buffer_seek(async_load[? "buffer"], buffer_seek_start, 0);
var data = json_parse(buffer_read(async_load[? "buffer"], buffer_string));
heartbeat_time = current_time;

if !assert(data[$ "type"] && data[$ "success"], "Invalid data packet received!") { exit; }

if !data.success
{
	if data[$ "reason"] { print(data.reason); }
	
	switch data.type
	{
		case NETWORK_TYPES.JOIN:
			obj_main_menu.active_ui = true;
		break;
	}
	exit;
}

switch data.type
{
	case NETWORK_TYPES.GET_HOSTS:
		hosts = data.hosts;
		array_sort(hosts, function(curr, next) { return curr.creation_time - next.creation_time; });
	break;
	
	case NETWORK_TYPES.JOIN:
		if connected { break; }
		
		client_id = data.id;
		client_count = client_id + 1;
		connected = true;
	
		room_goto(rm_level_1);
	break;
	
	case NETWORK_TYPES.SET_INPUTS_GET_FRAME:
		if !is_struct(data.frame_data) { break; }
	
		frame_data = data.frame_data;
		var curr_instance_ids = struct_get_names(frame_data);
	
		for (var i = 0; i < array_length(curr_instance_ids); i++)
		{
			var obj = frame_data[$ curr_instance_ids[i]];
			if obj[$ "object_index"] == undefined { continue; }
		
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
				instances[$ curr_instance_ids[i]] = instance_create_depth(x, y, depth, obj.object_index,
					{ instance: curr_instance_ids[i] });
			
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
	break;
}