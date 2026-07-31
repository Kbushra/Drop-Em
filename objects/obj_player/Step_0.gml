depth = 0;

var control_all_players = instance_exists(game_debug) ? game_debug.control_all_players : false;
if instance_exists(obj_server) && !control_all_players
{
	input_pressed = obj_server.clients[client_id].frame_inputs.input_pressed;
	input_held = obj_server.clients[client_id].frame_inputs.input_held;
	input_released = obj_server.clients[client_id].frame_inputs.input_released;
}
else if !instance_exists(obj_connection) || control_all_players
{
	input_pressed = game_input.input_pressed;
	input_held = game_input.input_held;
	input_released = game_input.input_released;
}