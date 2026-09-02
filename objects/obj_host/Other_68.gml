if async_load[? "type"] != network_type_data { exit; }

buffer_seek(async_load[? "buffer"], buffer_seek_start, 0);
var data = json_parse(buffer_read(async_load[? "buffer"], buffer_string));
heartbeat_time = current_time;

if !assert(!is_undefined(data[$ "type"]) && !is_undefined(data[$ "success"]), "Invalid data packet received!") { exit; }

if !data.success
{
	if !is_undefined(data[$ "reason"]) { print(data.reason); }
	
	switch data.type
	{
		case NETWORK_TYPES.ADD_HOST:
			instance_destroy();
		break;
	}
	exit;
}

switch data.type
{
	case NETWORK_TYPES.ADD_HOST:
		added = true;
		join_code = data.join_code;
		room_goto(rm_level_1);
	break;
	
	case NETWORK_TYPES.SET_FRAME_GET_INPUTS:
		clients_removed = 0;
		for (var i = 0; i < array_length(data.input_data); i++)
		{
			var client_frames = data.input_data[i];
			if client_frames == -1
			{
				clients_removed++;
				input_data[i] = -1;
				continue;
			}
		
			if !index_defined(input_data, i)
			{
				input_data[i] = [];
				instance_create_depth(x, y, depth, obj_bat, { client_id: i });
			}
			
			for (var j = 0; j < array_length(client_frames); j++)
			{
				var client_frame = client_frames[j];
				
				var verified = verify_inputs(client_frame.input_pressed);
				verified = verified && verify_inputs(client_frame.input_held);
				verified = verified && verify_inputs(client_frame.input_released);
				if !verified { continue; }
		
				input_data[i][j] = client_frame;
			}
		}
	break;
}