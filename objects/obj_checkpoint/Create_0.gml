given_first_bonus = false;
reached_player = [];
glow_player = [];
glow_alpha = 0;

for (var i = array_length(reached_player); i < CLIENT_COUNT + 1; i++)
{
	reached_player[i] = false;
	glow_player[i] = false;
}

///@func glow_for_player(client_id)
glow_for_player = function(_client_id)
{
	if instance_exists(obj_lava) && obj_lava.colliding() { return false; }

	with (obj_player)
	{
		if client_id != _client_id { continue; }
		
		var reached_checkpoint = hp > 0 && place_meeting(x, y, other);
		var in_range = hp == 0 && y == clamp(y, other.bbox_top - 32, other.bbox_bottom + 32);
		
		if !reached_checkpoint && !in_range { return false; }
		
		if !instance_exists(obj_client) && reached_checkpoint && !other.reached_player[client_id + 1]
		{
			var bonus_time = other.expected_time_taken - (current_time - last_checkpoint_time)/1000;
			if bonus_time > 0 { _score += 50 * bonus_time; }
			
			//Another bonus for being the first to reach it
			_score += other.given_first_bonus ? 50 : 150;
			other.given_first_bonus = true;
		}
		
		other.reached_player[client_id + 1] = true;
		last_checkpoint_time = current_time;
		return true;
	}
	
	return false;
}