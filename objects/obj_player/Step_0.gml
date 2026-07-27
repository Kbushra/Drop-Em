depth = 0;

if instance_exists(obj_server)
{
	input_pressed = obj_server.clients[client_id].frame_inputs.input_pressed;
	input_held = obj_server.clients[client_id].frame_inputs.input_held;
	input_released = obj_server.clients[client_id].frame_inputs.input_released;
}
else
{
	input_pressed = game_input.input_pressed;
	input_held = game_input.input_held;
	input_released = game_input.input_released;
}