if joinable
{
	network_send_broadcast(udp, PORT, discovery_data.buffer, discovery_data.len);
}

client_broadcast({ type: NETWORK_TYPES.FRAME_DATA, object_data, client_count: array_length(clients) });
object_data = {};

clients[0].last_alive = current_time;
clients[0].frame_inputs =
{
	input_pressed: game_input.input_pressed,
	input_held: game_input.input_held,
	input_released: game_input.input_released,
	delta: DELTA
};

var alive_clients = [clients[0]];
for (var i = 1; i < array_length(clients); i++)
{
	if current_time - clients[i].last_alive < 10000
	{
		array_push(alive_clients, clients[i]);
		continue;
	}
	
	with (obj_player) { if client_id == i { instance_destroy(); } }
}

clients = alive_clients;