if connecting { with obj_element { send_signal(id, "disable"); } }
if !connected { network_send_struct(wss, NETWORK_TYPES.GET_HOSTS); exit; }

network_send_struct(wss, NETWORK_TYPES.SET_INPUTS_GET_FRAME,
{
	input_data:
	{
		input_held: game_input.input_held,
		delta: DELTA
	}
});