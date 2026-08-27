if async_load[? "type"] == network_type_non_blocking_connect && async_load[? "id"] == wss
{
	if async_load[? "succeeded"]
	{
		create_vars.wss = wss;
		instance_create_depth(x, y, depth, create_object, create_vars);
		
		carried_wss = true;
	}
	else { instance_destroy(); }
}