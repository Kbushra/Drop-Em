///@desc Methods

///@func create_server(protocol)
create_server = function(protocol)
{
	return network_create_server(protocol, PORT, 7);
}