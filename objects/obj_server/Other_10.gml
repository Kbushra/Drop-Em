///@desc Methods

///@func get_client(tcp)
get_client = function(_tcp)
{
	for (var i = 0; i < array_length(clients); i++)
	{
		if clients[i].tcp == _tcp { return clients[i]; }
	}
	
	return NONE;
}

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
		network_send_packet(clients[i].tcp, data.buffer, data.len);
	}
	
	buffer_delete(data.buffer);
}

///@func write_data(write_defaults, [struct])
write_data = method(undefined, function(write_defaults, struct = {})
{
	var data = {};
	
	if write_defaults
	{
		data = get_object_data();
		data.sprite_index = sprite_get_name(sprite_index);
		data.layer = layer_get_type(layer) == layer_type_unknown ? "" : layer_get_name(layer);
	}
	
	data.object_index = object_get_name(object_index);
	data = struct_concat(data, struct);
	obj_server.object_data[$ calculate_id()] = data;
});