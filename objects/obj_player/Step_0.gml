depth = 0;
dummy = false;

var control_all_players = instance_exists(game_debug) ? game_debug.control_all_players : false;
var server_movement = instance_exists(obj_server) && !control_all_players;
var client_movement = instance_exists(obj_connection) && client_id == obj_connection.client_id;
var singleplayer = !instance_exists(obj_server) && !instance_exists(obj_connection);

if client_movement || control_all_players || singleplayer
{
	input_pressed = game_input.input_pressed;
	input_held = game_input.input_held;
	input_released = game_input.input_released;
	delta = DELTA;
}
else if instance_exists(obj_server)
{
	var frame = obj_server.clients[client_id].frame_inputs;
	input_pressed = frame.input_pressed;
	input_held = frame.input_held;
	input_released = frame.input_released;
	delta = frame.delta;
}
else
{
	input_pressed = inputs_default();
	input_held = inputs_default();
	input_released = inputs_default();
	delta = 0;
}