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
		frame_inputs: { input_pressed, input_held, input_released }
	});
	
	network_send_packet(obj_connection.tcp, data.buffer, data.len);
	buffer_delete(data.buffer);
}