event_inherited();

if input_pressed[KEY.UP] { coyote_press_up = 0.2; }
if input_pressed[KEY.DOWN] { coyote_press_down = 0.2; }

switch state
{
	case BAT_STATES.WALK:
		update_hsp();
		vsp = 0;
		
		mask_index = spr_bat_mask;
		collide();
		sprite_index = hsp == 0 ? spr_bat_idle : spr_bat_walk;
		
		if coyote_press_up > 0
		{
			coyote_press_up = 0;
			vsp = jump_force;
			state = BAT_STATES.JUMP;
		}
		else if coyote_press_down > 0
		{
			coyote_press_down = 0;
			state = BAT_STATES.SLIDE;
			initial_slide_dir = image_xscale;
		}
		else if place_free(x, y + 1)
		{
			coyote_fall = 0.2;
			state = BAT_STATES.FALL;
		}
	break;
	
	case BAT_STATES.JUMP:
		update_hsp();
		update_vsp();
		
		mask_index = spr_bat_mask;
		collide();
		sprite_index = spr_bat_jump;
		
		if !input_held[KEY.UP] || vsp >= 0
		{
			vsp = 0;
			state = BAT_STATES.FALL;
		}
	break;
	
	case BAT_STATES.FALL:
		update_hsp();
		update_vsp();
		
		mask_index = spr_bat_mask;
		collide();
		sprite_index = spr_bat_fall;
		
		if coyote_fall > 0 && input_pressed[KEY.UP]
		{
			coyote_fall = 0;
			vsp = jump_force;
			state = BAT_STATES.JUMP;
		}
		else if !place_free(x + input_held[KEY.RIGHT] - input_held[KEY.LEFT], y)
		{
			wall_dir = input_held[KEY.RIGHT] - input_held[KEY.LEFT];
			coyote_wall_stick = 0.1;
			state = BAT_STATES.WALL;
		}
		else if !place_free(x, y + 1)
		{
			vsp = 0;
			state = BAT_STATES.WALK;
		}
	break;
	
	case BAT_STATES.SLIDE:
		if place_free(x, y + 1) && vsp == 0 { coyote_fall = 0.2; }
		
		hsp = initial_slide_dir * slide_spd * DELTA;
		update_vsp();
		
		mask_index = spr_bat_mask_slide;
		collide();
		
		if hsp == 0 { initial_slide_dir *= -1; } //Change direction
		
		mask_index = spr_bat_mask;
		if place_free(x, y) && !input_held[KEY.DOWN]
		{
			state = place_free(x, y + 1) ? BAT_STATES.FALL : BAT_STATES.WALK;
		}
		else
		{
			sprite_index = spr_bat_slide;
			mask_index = spr_bat_mask_slide;
		}
	break;
	
	case BAT_STATES.WALL:
		hsp = 0;
		vsp = 120 * DELTA;
		
		image_xscale = wall_dir;
		mask_index = spr_bat_mask;
		collide();
		sprite_index = spr_bat_wall;
		
		var hinputs = input_held[KEY.RIGHT] - input_held[KEY.LEFT];
		if hinputs == -wall_dir
		{ coyote_wall_stick -= DELTA; }
		
		if coyote_wall_stick < 0 { state = BAT_STATES.FALL; }
		else if vsp == 0 { state = BAT_STATES.WALK; }
		else if coyote_press_up > 0
		{
			coyote_press_up = 0;
			vsp = jump_force;
			current_wall_force = wall_force * wall_dir;
			state = BAT_STATES.WALL_JUMP;
		}
	break;
	
	case BAT_STATES.WALL_JUMP:
		update_hsp();
		update_vsp();
		
		var hinputs = input_held[KEY.RIGHT] - input_held[KEY.LEFT];
		
		var prev_sign = sign(current_wall_force);
		current_wall_force -= wall_force * wall_dir * DELTA * 3;
		if sign(current_wall_force) != prev_sign && hinputs != wall_dir { current_wall_force = 0; }
		
		//Don't jump as far when moving in the opposite direction as the wall
		if hinputs == -wall_dir
		{
			current_wall_force = clamp(current_wall_force, wall_force/2, -wall_force/2);
		}
		
		hsp += current_wall_force * DELTA;
		
		mask_index = spr_bat_mask;
		collide();
		sprite_index = spr_bat_jump;
		
		if !input_held[KEY.UP] || vsp >= 0
		{
			current_wall_force = 0;
			vsp = 0;
			state = BAT_STATES.FALL;
		}
	break;
}

coyote_press_up -= DELTA;
coyote_press_down -= DELTA;
coyote_fall -= DELTA;

x += hsp;
y += vsp;
if hsp != 0 { image_xscale = sign(hsp); }