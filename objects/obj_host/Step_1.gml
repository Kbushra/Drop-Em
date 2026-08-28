if !added { send_signal(obj_main_menu, "disable_ui"); exit; }

network_send_struct(wss, NETWORK_TYPES.SET_FRAME_GET_INPUTS, { joinable, frame_data });
frame_data = {};