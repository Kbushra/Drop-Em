///@desc Methods

///@func create_server(protocol)
create_server = function(protocol)
{
	return network_create_server(protocol, PORT, 7);
}

///@func client_broadcast(struct)
client_broadcast = function(struct)
{
	if array_length(clients) == 1 { return; }
	
	var data = buffer_struct(struct);
	for (var i = 1; i < array_length(clients); i++)
	{
		network_send_udp(udp, clients[i].ip, clients[i].udp_port, data.buffer, data.len);
	}
	
	buffer_delete(data.buffer);
}

///@func write_data(write_defaults, [struct])
write_data = function(write_defaults, struct = {})
{
	with other
	{
		var data = {};
		
		if write_defaults
		{
			data = get_object_data();
			data.sprite_index = sprite_get_name(sprite_index);
			data.layer = layer_get_type(layer) == layer_type_unknown ? "" : layer_get_name(layer);
		}
		
		data.instance = calculate_id();
		data.object_index = object_get_name(object_index);
		data = struct_concat(data, struct);
		array_push(other.object_data, data);
	}
}