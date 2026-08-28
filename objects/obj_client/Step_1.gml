if connecting { send_signal(obj_main_menu, "disable_ui"); }
if !connected { network_send_struct(wss, NETWORK_TYPES.GET_HOSTS); exit; }

network_send_struct(wss, NETWORK_TYPES.SET_INPUTS_GET_FRAME,
{
	input_data:
	{
		input_pressed: game_input.input_pressed,
		input_held: game_input.input_held,
		input_released: game_input.input_released,
		delta: DELTA
	}
});