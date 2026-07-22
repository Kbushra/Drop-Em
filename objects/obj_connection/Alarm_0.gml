///@desc Discovery
network_send_broadcast(udp, PORT, broadcast_data.buffer, broadcast_data.len);
alarm[0] = 120;

var server_names = struct_get_names(servers);
for (var i = 0; i < array_length(server_names); i++)
{
	//If server hasn't responded, it probably closed
	if EPOCH_TIME - servers[$ server_names[i]].discovery_time > 3
	{ struct_remove(servers, server_names[i]); }
}