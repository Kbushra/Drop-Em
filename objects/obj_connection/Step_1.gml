if current_time - server_last_alive >= 10000
{
	room_goto(rm_main);
	instance_destroy();
}