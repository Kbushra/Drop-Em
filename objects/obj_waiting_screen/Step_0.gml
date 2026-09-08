//Keep client active
network_send_struct(wss, NETWORK_TYPES.SET_INPUTS_GET_FRAME,
{
	input_data:
	{
		input_held: default_inputs(),
		delta: 0
	}
});