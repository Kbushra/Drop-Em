if !player
{
	with obj_player
	{
		if client_id == CLIENT_ID { other.player = id; break; }
	}
}

if player
{
	x = player.x;
	y = player.y;
}