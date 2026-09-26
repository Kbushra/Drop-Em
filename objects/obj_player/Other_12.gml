///@desc Attacking

///@func check_attack()
check_attack = function()
{
	if !agile || attack_cooldown > 0 || !input_pressed[KEY.ATTACK] { return; }
	
	attacking = true;
	attack_cooldown = 0.35;
	sprite_index = attack_sprite;
	image_index = 0;
}

///@func base_attack_logic([damage], [score_penalty], [delay], [inv])
base_attack_logic = function(damage = 15, score_penalty = 15, delay = 0.15, inv = 0.8)
{
	var latency = LATENCY;
	var prev_mask = mask_index;
	mask_index = attack_mask;
	with (obj_player)
	{
		if instance_exists(obj_client) { break; } //Player interactions don't happen locally
		if other.id == id { continue; }
		if state.state_is("ghost") { continue; }
		
		var late_pos = fetch_late_pos(latency);
		var curr_pos = new coordinate(x, y);
		
		x = late_pos.x;
		y = late_pos.y;
		var hit = place_meeting(x, y, other);
		x = curr_pos.x;
		y = curr_pos.y;
		
		if inv_frames > 0 || !hit { continue; }
		
		hp -= damage;
		_score -= score_penalty;
		if _score < 0 { _score = 0; }
		
		state.change("knockback");
		knockback_delay = delay;
		current_knockback_h_force = other.image_xscale * knockback_h_force;
		current_knockback_v_force = knockback_v_force;
		
		inv_frames = inv;
	}
	mask_index = prev_mask;
	
	if image_index >= image_number - 1 { attacking = false; }
}

///@func attack_logic()
attack_logic = function() { base_attack_logic(); }