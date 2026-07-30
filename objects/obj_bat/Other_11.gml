///@desc States

///@func state_transition()
state_transition = function()
{
	if instance_exists(obj_lava) && obj_lava.colliding(x, y) && state != BAT_STATES.GHOST
	{
		hp = 0;
		_score -= 100;
		if _score < 0 { _score = 0; }
	}
	
	if hp <= 0
	{
		hp = 0;
		state = BAT_STATES.GHOST;
		if current_arena
		{
			arena_place = current_arena.available_place;
			current_arena.available_place--;
		}
	}
	
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
			if coyote_fall > 0 && coyote_press_up > 0
			{
				coyote_fall = 0;
				coyote_press_up = 0;
				vsp = jump_force;
				state = BAT_STATES.JUMP;
			}
			else if !place_free(x, y + 1)
			{
				vsp = 0;
				state = BAT_STATES.WALK;
			}
			else if hinputs != 0 && !place_free(x + hinputs, y) && agile
			{
				wall_dir = hinputs;
				coyote_wall_stick = 0.1;
				state = BAT_STATES.WALL;
			}
			else if place_free(x, y + 32) && place_free(x + hinputs * 32, y) && coyote_press_up > 0 && agile
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
			if coyote_wall_stick < 0 || place_free(x + wall_dir, y) { state = BAT_STATES.FALL; }
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
		
		case BAT_STATES.KNOCKBACK:
			if knockback_delay > 0 { break; }
			
			if hp <= 0 { state = BAT_STATES.GHOST; }
			else if near_equals(current_knockback_h_force, 0, 4) &&
			near_equals(current_knockback_v_force, 0, 0.1)
			{ state = BAT_STATES.WALK; }
		break;
		
		case BAT_STATES.GHOST:
			var checkpoint = instance_place(x, y, obj_checkpoint);
			if checkpoint && checkpoint.glow_client[client_id]
			{
				checkpoint.mask_index = spr_checkpoint;
				if place_meeting(x, y, checkpoint)
				{
					state = BAT_STATES.WALK;
					x = checkpoint.x;
					y = checkpoint.y;
					lowest_y = y;
					hp = 100;
				}
				checkpoint.mask_index = spr_checkpoint_glow;
			}
		break;
	}
}

///@func state_step()
state_step = function()
{
	image_alpha = 1;
	image_blend = c_white;
	
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
			
			var regular_jump = !place_free(x, y + 1) && coyote_press_up > 0;
			var air_jump = place_free(x, y + 1) && coyote_fall > 0 && coyote_press_up > 0;
			if regular_jump || air_jump
			{
				if air_jump { coyote_fall = 0; }
				coyote_press_up = 0;
				vsp = jump_force;
			}
			
			if !input_held[KEY.UP] && vsp < 0 { vsp = 0; }
		
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
			vsp = lerp_delta(vsp, 0, 0.995);
		
			mask_index = spr_bat_mask_small;
			sprite_index = spr_bat_glide;
			collide();
		
			if hsp == 0 { glide_dir *= -1; } //Change direction
		break;
		
		case BAT_STATES.KNOCKBACK:
			knockback_delay -= DELTA;
			if knockback_delay > 0 { sprite_index = spr_bat_knockback; break; }
		
			hsp = current_knockback_h_force * DELTA;
			update_vsp();
			
			mask_index = spr_bat_mask;
			sprite_index = spr_bat_knockback;
			collide();
			
			if hsp == 0 { current_knockback_h_force *= -1; }
			if place_free(x, y + 1) { break; }
			
			current_knockback_h_force /= 2;
			current_knockback_v_force /= 2;
			vsp = current_knockback_v_force;
		break;
		
		case BAT_STATES.GHOST:
			update_hsp();
			vsp = 0;
			y = lerp_delta(y, obj_lava.bbox_top - 20, 0.99);
			
			image_alpha = 0.5;
			mask_index = spr_bat_mask;
			sprite_index = spr_bat_ghost;
			x = clamp(x, sprite_xoffset, room_width - sprite_xoffset);
		break;
	}
}