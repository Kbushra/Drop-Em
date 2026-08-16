event_inherited();

if input_pressed[KEY.UP] { coyote_press_up = 0.2; }
if input_pressed[KEY.DOWN] { coyote_press_down = 0.2; }

state_transition();
state_step();

if instance_exists(obj_lava) && y < lowest_y
{
	if state != BAT_STATES.GHOST { _score += (lowest_y - y)/5; }
	lowest_y = y;
}

attack_cooldown -= delta;
coyote_press_up -= delta;
coyote_press_down -= delta;
coyote_fall -= delta;

x += hsp;
y += vsp;
if hsp != 0 { image_xscale = sign(hsp); }

if sprite_index != spr_bat_knockback { inv_frames -= delta; }

if attacking
{
	var prev_mask = mask_index;
	mask_index = spr_bat_mask_attack;
	with (obj_player)
	{
		if !instance_exists(obj_server) { break; } //Player interactions only happen on server
		
		if inv_frames > 0 || !place_meeting(x, y, other) { continue; }
		
		hp -= 15;
		_score -= 15;
		if _score < 0 { _score = 0; }
		
		state = BAT_STATES.KNOCKBACK;
		knockback_delay = 0.15;
		current_knockback_h_force = other.image_xscale * knockback_h_force;
		current_knockback_v_force = knockback_v_force;
		
		inv_frames = 0.8;
	}
	mask_index = prev_mask;
	
	if image_index >= image_number - 1 { attacking = false; }
}

if inv_frames <= 0 || sprite_index == spr_bat_knockback { image_blend = c_white }
else { image_blend = true_mod(inv_frames, 0.2) > 0.1 ? c_red : c_white; }