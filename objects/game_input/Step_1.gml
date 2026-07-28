update_keyboard_inputs();

if instance_exists(obj_server)
{
	obj_server.clients[0].frame_inputs = { input_pressed, input_held, input_released };
}
else if instance_exists(obj_connection) && obj_connection.connected
{
	var data = buffer_struct
	({
		type: NETWORK_TYPES.INPUTS,
		client_id: obj_connection.client_id,
		input_held
	});
	
	network_send_udp(obj_connection.udp, obj_connection.server_ip, PORT, data.buffer, data.len);
	buffer_delete(data.buffer);
}