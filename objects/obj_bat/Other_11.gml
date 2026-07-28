///@desc States

///@func state_transition()
state_transition = function()
{
	var hinputs = input_held[KEY.RIGHT] - input_held[KEY.LEFT];
	switch state
	{
		case BAT_STATES.WALK:
			mask_index = spr_bat_mask;
			if place_free(x, y + 1)
			{
				coyote_fall = 0.2;
				state = BAT_STATES.FALL;
			}
			else if coyote_press_up > 0
			{
				coyote_press_up = 0;
				vsp = jump_force;
				state = BAT_STATES.JUMP;
			}
			else if coyote_press_down > 0 && agile
			{
				coyote_press_down = 0;
				state = BAT_STATES.SLIDE;
				slide_dir = image_xscale;
			}
		break;
		
		case BAT_STATES.JUMP:
			mask_index = spr_bat_mask;
			if !input_held[KEY.UP] || vsp >= 0
			{
				vsp = 0;
				state = BAT_STATES.FALL;
			}
		break;
		
		case BAT_STATES.FALL:
			mask_index = spr_bat_mask;
			if coyote_fall > 0 && input_pressed[KEY.UP]
			{
				coyote_fall = 0;
				vsp = jump_force;
				state = BAT_STATES.JUMP;
			}
			else if !place_free(x, y + 1)
			{
				vsp = 0;
				state = BAT_STATES.WALK;
			}
			else if !place_free(x + hinputs, y) && agile
			{
				wall_dir = input_held[KEY.RIGHT] - input_held[KEY.LEFT];
				coyote_wall_stick = 0.1;
				state = BAT_STATES.WALL;
			}
			else if place_free(x, y + 20) && place_free(x + hinputs * 20, y) && coyote_press_up > 0 && agile
			{
				coyote_press_up = 0;
				state = BAT_STATES.GLIDE;
				glide_dir = image_xscale;
			}
		break;
		
		case BAT_STATES.SLIDE:
			//Disabled
			if !agile { state = BAT_STATES.WALK; break; }
		
			mask_index = spr_bat_mask;
			if place_free(x, y) && !input_held[KEY.DOWN]
			{
				state = place_free(x, y + 1) ? BAT_STATES.FALL : BAT_STATES.WALK;
			}
		break;
		
		case BAT_STATES.WALL:
			//Disabled
			if !agile { state = BAT_STATES.FALL; break; }
			
			mask_index = spr_bat_mask;
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
			//Disabled
			if !agile { state = BAT_STATES.JUMP; break; }
			
			mask_index = spr_bat_mask;
			if !input_held[KEY.UP] || vsp >= 0
			{
				current_wall_force = 0;
				vsp = 0;
				state = BAT_STATES.FALL;
			}
		break;
		
		case BAT_STATES.GLIDE:
			//Disabled
			if !agile { state = BAT_STATES.FALL; break; }
			
			mask_index = spr_bat_mask;
			if place_free(x, y) && !place_free(x, y + 1)
			{
				state = BAT_STATES.WALK;
			}
			else if place_free(x, y) && !input_held[KEY.UP]
			{
				state = BAT_STATES.FALL;
			}
		break;
	}
}

///@func state_step()
state_step = function()
{
	var hinputs = input_held[KEY.RIGHT] - input_held[KEY.LEFT];
	switch state
	{
		case BAT_STATES.WALK:
			update_hsp();
			vsp = 0;
			
			attack();
			mask_index = spr_bat_mask;
			collide();
			
			if !attacking { sprite_index = hsp == 0 ? spr_bat_idle : spr_bat_walk; }
		break;
		
		case BAT_STATES.JUMP:
			update_hsp();
			update_vsp();
			
			attack();
			mask_index = spr_bat_mask;
			if !attacking { sprite_index = spr_bat_jump; }
			collide();
		break;
		
		case BAT_STATES.FALL:
			update_hsp();
			update_vsp();
		
			attack();
			mask_index = spr_bat_mask;
			if !attacking { sprite_index = spr_bat_fall; }
			collide();
		break;
		
		case BAT_STATES.SLIDE:
			//Disabled
			if !agile { state = BAT_STATES.WALK; break; }
	
			if place_free(x, y + 1) && vsp == 0 { coyote_fall = 0.2; }
		
			hsp = slide_dir * slide_spd * DELTA;
			update_vsp();
		
			mask_index = spr_bat_mask_small;
			sprite_index = spr_bat_slide;
			collide();
		
			if hsp == 0 { slide_dir *= -1; } //Change direction
		break;
		
		case BAT_STATES.WALL:
			//Disabled
			if !agile { state = BAT_STATES.FALL; break; }
		
			hsp = 0;
			vsp = 120 * DELTA;
		
			image_xscale = wall_dir;
			mask_index = spr_bat_mask;
			sprite_index = spr_bat_wall;
			collide();
			
			if hinputs == -wall_dir
			{ coyote_wall_stick -= DELTA; }
		break;
		
		case BAT_STATES.WALL_JUMP:
			//Disabled
			if !agile { state = BAT_STATES.JUMP; break; }
	
			update_hsp();
			update_vsp();
		
			var prev_sign = sign(current_wall_force);
			current_wall_force -= wall_force * wall_dir * DELTA * 3;
			if sign(current_wall_force) != prev_sign && hinputs != wall_dir { current_wall_force = 0; }
		
			//Don't jump as far when moving in the opposite direction as the wall
			if hinputs == -wall_dir
			{
				current_wall_force = clamp(current_wall_force, wall_force/2, -wall_force/2);
			}
		
			hsp += current_wall_force * DELTA;
			
			attack();
			mask_index = spr_bat_mask;
			if !attacking { sprite_index = spr_bat_jump; }
			collide();
		break;
		
		case BAT_STATES.GLIDE:
			//Disabled
			if !agile { state = BAT_STATES.FALL; break; }
	
			hsp = glide_dir * glide_spd * DELTA;
			vsp = lerp_delta(vsp, 0, 0.99);
		
			mask_index = spr_bat_mask_small;
			sprite_index = spr_bat_glide;
			collide();
		
			if hsp == 0 { glide_dir *= -1; } //Change direction
		break;
		
		case BAT_STATES.KNOCKBACK:
			hsp = current_knockback_h_force * DELTA;
			update_vsp();
			
			mask_index = spr_bat_mask;
			sprite_index = spr_bat_knockback;
			collide();
			
			if hsp == 0 { current_knockback_h_force *= -1; }
			if vsp != 0 { break; }
			
			current_knockback_h_force /= 2;
			current_knockback_v_force /= 2;
			vsp = current_knockback_v_force;
			if near_equals(current_knockback_h_force, 0, 4) &&
			near_equals(current_knockback_v_force, 0, 0.1)
			{ state = BAT_STATES.WALK; }
		break;
	}
}