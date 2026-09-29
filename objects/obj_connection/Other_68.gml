if async_load[? "type"] == network_type_non_blocking_connect && async_load[? "id"] == wss
{
	if async_load[? "succeeded"]
	{
		create_vars.wss = wss;
		instance_create_depth(x, y, depth, create_object, create_vars);
		
		carried_wss = true;
	}
	else
	{
		with (obj_logs) { array_push(logs, "ERROR: Couldn't connect to server, please try again."); }
	}
	
	instance_destroy();
}