if !instance_exists(player)
{
	with obj_player
	{
		if client_id == CLIENT_ID { other.player = id; break; }
	}
}

if instance_exists(player)
{
	x = player.x;
	y = player.y;
}