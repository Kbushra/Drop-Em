given_first_bonus = false;
reached_client = [];
glow_client = [];
reached = false;
glow_alpha = 0;

for (var i = array_length(reached_client); i < CLIENT_COUNT; i++)
{
	reached_client[i] = false;
	glow_client[i] = false;
}

///@func glow_for_player(client_id)
glow_for_player = function(_client_id)
{
	if instance_exists(obj_lava) && obj_lava.colliding(x, y) { return false; }

	with (obj_player)
	{
		if client_id != _client_id { continue; }
		
		var reached_checkpoint = state != BAT_STATES.GHOST && place_meeting(x, y, other);
		var in_range = state == BAT_STATES.GHOST && y == clamp(y, other.bbox_top - 32, other.bbox_bottom + 32);
		
		if !reached_checkpoint && !in_range { return false; }
		
		if !instance_exists(obj_connection) && reached_checkpoint && !other.reached_client[client_id]
		{
			var bonus_time = other.expected_time_taken - (current_time - last_checkpoint_time)/1000;
			if bonus_time > 0 { _score += 50 * bonus_time; }
			
			//Another bonus for being the first to reach it
			_score += other.given_first_bonus ? 50 : 150;
			other.given_first_bonus = true;
		}
		
		other.reached_client[client_id] = true;
		last_checkpoint_time = current_time;
		return true;
	}
	
	return false;
}