///@desc Methods

///@func get_server(ip)
get_server = function(ip)
{
	for (var i = 0; i < array_length(servers); i++)
	{
		if servers[i].ip == ip { return servers[i]; }
	}
	
	return NONE;
}