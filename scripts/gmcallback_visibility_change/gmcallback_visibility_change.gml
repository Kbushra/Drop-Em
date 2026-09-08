function gmcallback_visibility_change(hidden)
{
	if !instance_exists(obj_host) { return; }
	network_send_struct(obj_host.wss, NETWORK_TYPES.PAUSE_HOST);
	print("Paused!");
}