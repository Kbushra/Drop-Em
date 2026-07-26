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

///@func write_data([extra])
write_data = function(extra = {})
{
	with other
	{
		var data = get_object_data(extra);
		data._id = id;
		data.object_name = object_get_name(object_index);
		data.sprite_index = sprite_get_name(sprite_index);
		data.layer = layer_get_name(layer);
		
		array_push(other.object_data, data);
	}
}