var i = 0;
while i < array_length(servers)
{
	//If server hasn't responded, it probably closed
	if current_time - servers[i].discovery_time > 1000 { array_delete(servers, i, 1); }
	else { i++; }
}

if !connected { exit; }

if current_time - server_last_alive >= 10000
{
	room_goto(rm_main);
	instance_destroy();
	exit;
}

var data = buffer_struct
({
	type: NETWORK_TYPES.INPUTS,
	frame_inputs:
	{
		input_pressed: game_input.input_pressed,
		input_held: game_input.input_held,
		input_released: game_input.input_released,
		delta: DELTA
	}
});
	
network_send_packet(tcp, data.buffer, data.len);
buffer_delete(data.buffer);