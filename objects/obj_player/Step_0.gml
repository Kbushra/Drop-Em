depth = -client_id;

var curr_player = client_id == CLIENT_ID;
var singleplayer = !instance_exists(obj_host) && !instance_exists(obj_client);
var control_all_players = instance_exists(game_debug) ? game_debug.control_all_players : false;

if curr_player || singleplayer || control_all_players
{
	input_pressed = game_input.input_pressed;
	input_held = game_input.input_held;
	input_released = game_input.input_released;
	delta = DELTA;
}
else if instance_exists(obj_host)
{
	var frame = obj_host.input_data[client_id];
	if frame == -1 { instance_destroy(); exit; }
	
	input_pressed = frame.input_pressed;
	input_held = frame.input_held;
	input_released = frame.input_released;
	delta = frame.delta;
}
else
{
	input_pressed = default_inputs();
	input_held = default_inputs();
	input_released = default_inputs();
	delta = 0;
}