var input_pressed = obj_server.clients[client_id].frame_inputs.input_pressed;
var input_held = obj_server.clients[client_id].frame_inputs.input_held;
var input_released = obj_server.clients[client_id].frame_inputs.input_released;

x += (input_held[KEY.RIGHT] - input_held[KEY.LEFT]) * 150 * DELTA;

obj_server.write_data({ client_id });