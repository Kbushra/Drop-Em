for (var i = array_length(glow_client); i < array_length(obj_server.clients); i++)
{
	glow_client[i] = false;
}

var disabled = false;
if instance_exists(obj_lava) && obj_lava.colliding(x, y) { disabled = true; }

with (obj_player)
{
	if disabled { other.glow_client[client_id] = false; continue; }
	if other.glow_client[client_id] { continue; }
	
	if state != BAT_STATES.GHOST && place_meeting(x, y, other)
	{
		var bonus_time = other.expected_time_taken - (current_time - last_checkpoint_time)/1000;
		if bonus_time > 0 { _score += 50 * bonus_time; }
		
		other.glow_client[client_id] = true;
		_score += 100;
		last_checkpoint_time = current_time;
	}
	
	if state == BAT_STATES.GHOST && y == clamp(y, other.bbox_top - 32, other.bbox_bottom + 32)
	{
		other.glow_client[client_id] = true;
		last_checkpoint_time = current_time;
	}
}

//Glow for the first client
glow_alpha = lerp_delta(glow_alpha, glow_client[0] ? 0.5 : 0, 0.99);

draw_set_alpha(glow_alpha);
draw_sprite(spr_checkpoint_glow, 0, x, y);
draw_set_alpha(1);

draw_self();

obj_server.write_data({ glow_client });