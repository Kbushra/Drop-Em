if async_load[? "type"] == network_type_connect
{
	if joinable
	{
		var client =
		{
			tcp: async_load[? "socket"],
			last_alive: current_time,
			frame_inputs:
			{
				input_pressed: inputs_default(),
				input_held: inputs_default(),
				input_released: inputs_default()
			}
		};
		array_push(clients, client);
		instance_create_depth(x, y, depth, obj_bat, { client_id: array_length(clients) - 1 });
	}	
	
	var connection_data = buffer_struct
	({
		type: NETWORK_TYPES.CONNECTED,
		client_id: array_length(clients) - 1,
		joinable
	});
	network_send_packet(async_load[? "socket"], connection_data.buffer, connection_data.len);
	buffer_delete(connection_data.buffer);
	exit;
}

if async_load[? "type"] != network_type_data { exit; }

buffer_seek(async_load[? "buffer"], buffer_seek_start, 0);
var data = json_parse(buffer_read(async_load[? "buffer"], buffer_string));

if data.type == NETWORK_TYPES.INPUTS
{
	var client = get_client(async_load[? "id"]);
	if client.frame_inputs.delta > current_time - client.last_alive { exit; } //Cheater
	
	client.last_alive = current_time;
	client.frame_inputs = data.frame_inputs;
	exit;
}