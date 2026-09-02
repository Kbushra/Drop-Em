depth = -client_id;

var curr_player = client_id == CLIENT_ID;
var singleplayer = !instance_exists(obj_host) && !instance_exists(obj_client);
var control_all_players = instance_exists(game_debug) ? game_debug.control_all_players : false;

var repeat_event = false;

if curr_player || singleplayer || control_all_players
{
	input_pressed = game_input.input_pressed;
	input_held = game_input.input_held;
	input_released = game_input.input_released;
	delta = DELTA;
}
else if instance_exists(obj_host)
{
	var frames = obj_host.input_data[client_id];
	if frames == -1 { instance_destroy(); exit; }
	
	var frame = array_shift(frames);
	if is_undefined(frame) { exit; }
	
	input_pressed = frame.input_pressed;
	input_held = frame.input_held;
	input_released = frame.input_released;
	delta = frame.delta;
	
	repeat_event = true;
}
else { exit; }

setup_coyotes();

state_transition();
state_step();

control_score();
reduce_timers();

x += hsp;
y += vsp;
if hsp != 0 { image_xscale = sign(hsp); }

if attacking { attack_logic(); }

inv_blend();

if repeat_event { event_perform(ev_step, ev_step_normal); }