if async_load[? "type"] == network_type_connect
{
	var client =
	{
		tcp: async_load[? "socket"],
		ip: async_load[? "ip"],
		tcp_port: async_load[? "port"],
		udp_port: 0,
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
	
	var connection_data = buffer_struct
	({
		type: NETWORK_TYPES.CONNECTED,
		client_id: array_length(clients) - 1
	});
	network_send_packet(client.tcp, connection_data.buffer, connection_data.len);
	buffer_delete(connection_data.buffer);
	exit;
}

if async_load[? "type"] != network_type_data { exit; }

buffer_seek(async_load[? "buffer"], buffer_seek_start, 0);
var data = json_parse(buffer_read(async_load[? "buffer"], buffer_string));

if data.type == NETWORK_TYPES.DISCOVERY
{
	network_send_udp(udp, async_load[? "ip"], async_load[? "port"],
		discovery_data.buffer, discovery_data.len);
	
	exit;
}

if data.type == NETWORK_TYPES.GET_UDP_PORT
{
	clients[data.client_id].udp_port = async_load[? "port"];
	exit;
}

if data.type == NETWORK_TYPES.INPUTS
{
	for (var i = 1; i < array_length(clients); i++)
	{
		if data.client_id != i { continue; }
		
		var prev_inputs_held = clients[i].frame_inputs.input_held;
		clients[i].frame_inputs.input_held = data.input_held;
		
		for (var j = 0; j < KEY.COUNT; j++)
		{
			clients[i].frame_inputs.input_pressed[j] =
				!prev_inputs_held[j] && data.input_held[j];
			clients[i].frame_inputs.input_released[j] =
				prev_inputs_held[j] && !data.input_held[j];
		}
		break;
	}
	
	exit;
}

if data.type == NETWORK_TYPES.OBJECT_DATA
{
	clients[data.client_id].last_alive = current_time;
	exit;
}