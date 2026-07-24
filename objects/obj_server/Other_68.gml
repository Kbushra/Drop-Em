if async_load[? "type"] == network_type_connect
{
	array_push(clients,
	{
		tcp: async_load[? "socket"],
		ip: async_load[? "ip"],
		port: async_load[? "port"],
		frame_inputs:
		{
			input_pressed: inputs_default(),
			input_held: inputs_default(),
			input_released: inputs_default()
		}
	});
	instance_create_depth(x, y, depth, obj_player, { client_id: array_length(clients) - 1 });
	exit;
}

if async_load[? "type"] == network_type_disconnect
{
	for (var i = 1; i < array_length(clients); i++)
	{
		if clients[i].tcp != async_load[? "socket"] { continue; }
		array_delete(clients, i, 1);
		
		with (obj_player) { if client_id == i { instance_destroy(); } }
		break;
	}
	
	exit;
}

if async_load[? "type"] != network_type_data { exit; }

var data = json_parse(buffer_read(async_load[? "buffer"], buffer_string));

if data.type == NETWORK_TYPES.DISCOVERY
{
	network_send_udp(udp, async_load[? "ip"], async_load[? "port"],
		discovery_data.buffer, discovery_data.len);
}

if data.type == NETWORK_TYPES.INPUTS
{
	print("inputs");
	for (var i = 1; i < array_length(clients); i++)
	{
		print($"{clients[i].tcp} - {async_load[? "id"]}");
		if clients[i].tcp != async_load[? "id"] { continue; }
		clients[i].frame_inputs = data.frame_inputs;
		break;
	}
}