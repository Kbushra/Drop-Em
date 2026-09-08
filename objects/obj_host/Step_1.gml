if !added
{
	with obj_element { send_signal(id, "disable"); }
	exit;
}

network_send_struct(wss, NETWORK_TYPES.SET_FRAME_GET_INPUTS, { joinable, frame_data });
frame_data = {};

if os_is_paused() { print("Send signal now"); }