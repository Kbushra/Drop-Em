//Each client gives an array of structs containing their inputs that frame
last_input_data = [];
input_data = [];
latencies = [];

heartbeat_time = current_time;
join_code = "";
added = false;
joinable = true;
frame_data = {};

network_send_struct(wss, NETWORK_TYPES.ADD_HOST, { name });

///@func verify_inputs(arr)
verify_inputs = function(arr)
{
	if !is_array(arr) || array_length(arr) != KEY.COUNT { return false; }
	for (var i = 0; i < array_length(arr); i++) { if arr[i] != false && arr[i] != true { return false; } }
	
	return true;
}