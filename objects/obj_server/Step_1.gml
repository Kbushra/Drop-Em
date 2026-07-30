client_broadcast({ type: NETWORK_TYPES.FRAME_DATA, object_data, client_count: array_length(clients) });
clients[0].last_alive = current_time; //Why not lol
object_data = [];

var alive_clients = [clients[0]];
for (var i = 1; i < array_length(clients); i++)
{
	if current_time - clients[i].last_alive < 10000
	{
		array_push(alive_clients, clients[i]);
		continue;
	}
	
	with (obj_bat) { if client_id == i { instance_destroy(); } }
}

clients = alive_clients;