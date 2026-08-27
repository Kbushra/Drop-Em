depth = 0;
repeat_frame = false;

var control_all_players = instance_exists(game_debug) ? game_debug.control_all_players : false;
var host_movement = instance_exists(obj_host) && !control_all_players;
var client_movement = instance_exists(obj_client) && client_id == obj_client.client_id;
var singleplayer = !instance_exists(obj_host) && !instance_exists(obj_client);

if host_movement || client_movement || control_all_players || singleplayer
{
	input_pressed = game_input.input_pressed;
	input_held = game_input.input_held;
	input_released = game_input.input_released;
	delta = DELTA;
}
else if instance_exists(obj_host)
{
	var frames = obj_host.input_data[client_id];
	var frame = array_shift(frames);
	input_pressed = frame == undefined ? default_inputs() : frame.input_pressed;
	input_held = frame == undefined ? default_inputs() : frame.input_held;
	input_released = frame == undefined ? default_inputs() : frame.input_released;
	delta = frame.delta;
	
	repeat_frame = array_length(frames) > 0;
}
else
{
	input_pressed = default_inputs();
	input_held = default_inputs();
	input_released = default_inputs();
	delta = 0;
}