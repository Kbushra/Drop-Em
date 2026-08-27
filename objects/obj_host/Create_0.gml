//Each client gives an array of structs containing their inputs that frame
input_data = [];

heartbeat_time = current_time;
join_code = "";
joinable = true;
frame_data = {};

network_send_struct(wss, NETWORK_TYPES.ADD_HOST, { name });

///@func verify_inputs(arr)
verify_inputs = function(arr)
{
	if array_length(arr) != KEY.COUNT { return false; }
	for (var i = 0; i < array_length(arr); i++) { if arr[i] != false && arr[i] != true { return false; } }
	
	return true;
}