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
		network_send_udp(udp, clients[i].ip, clients[i].port, data.buffer, data.len);
	}
	
	buffer_delete(data.buffer);
}

///@func write_data()
write_data = function()
{
	with other
	{
		array_push(other.object_data,
		{
			sprite_index,
			image_index,
			image_alpha,
			image_blend,
			image_xscale,
			image_yscale,
			image_angle,
			x,
			y,
			depth,
			layer
		});
	}
}