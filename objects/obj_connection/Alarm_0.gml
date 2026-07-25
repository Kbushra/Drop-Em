///@desc Discovery
network_send_broadcast(udp, PORT, discovery_data.buffer, discovery_data.len);
alarm[0] = 30;

var server_names = struct_get_names(servers);
for (var i = 0; i < array_length(server_names); i++)
{
	//If server hasn't responded, it probably closed
	if current_time - servers[$ server_names[i]].discovery_time > 3000
	{ struct_remove(servers, server_names[i]); }
}