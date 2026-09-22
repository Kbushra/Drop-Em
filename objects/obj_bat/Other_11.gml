///@desc States
event_inherited();

state.add("walk",
{
	step: function()
	{
		update_hsp();
		vsp = 0;
		
		check_attack();
		mask_index = spr_bat_mask;
		collide();
			
		if !attacking { sprite_index = hsp == 0 ? spr_bat_idle : spr_bat_walk; }
		apply_spd();
		
		if place_free(x, y + 1)
		{
			coyote_fall = 0.2;
			state.change("fall");
		}
		else if coyote_press_up > 0
		{
			coyote_press_up = 0;
			state.change("jump");
		}
		else if coyote_press_down > 0 && agile
		{
			coyote_press_down = 0;
			state.change("slide");
		}
	}
});

state.add("jump",
{
	enter: function() { vsp = jump_force; },
	step: function()
	{
		update_hsp();
		update_vsp();
		
		check_attack();
		mask_index = spr_bat_mask;
		collide();
		
		if !attacking { sprite_index = spr_bat_jump; }
		apply_spd();
		
		if !input_held[KEY.UP] || vsp >= 0
		{
			vsp = 0;
			state.change("fall");
		}
	}
});

state.add("fall",
{
	step: function()
	{
		var hinputs = input_held[KEY.RIGHT] - input_held[KEY.LEFT];
		
		update_hsp();
		update_vsp();
		
		check_attack();
		mask_index = spr_bat_mask;
		collide();
			
		if !attacking { sprite_index = spr_bat_fall; }
		apply_spd();
		
		if coyote_fall > 0 && coyote_press_up > 0
		{
			coyote_fall = 0;
			coyote_press_up = 0;
			state.change("jump");
		}
		else if !place_free(x, y + 1)
		{
			state.change("walk");
		}
		else if hinputs != 0 && !place_free(x + hinputs, y) && agile
		{
			state.change("wallslide");
		}
		else if place_free(x, y + 32) && place_free(x + 32, y) &&
		place_free(x - 32, y) && coyote_press_up > 0 && agile
		{
			coyote_press_up = 0;
			state.change("glide");
		}
	}
});

state.add("wallslide",
{
	enter: function()
	{
		wall_dir = input_held[KEY.RIGHT] - input_held[KEY.LEFT];
		coyote_wall_stick = 0.1;
	},
	step: function()
	{
		//Disabled
		if !agile { state.change("fall"); return; }
		
		var hinputs = input_held[KEY.RIGHT] - input_held[KEY.LEFT];
		hsp = 0;
		vsp = 120 * delta;
		
		image_xscale = wall_dir;
		mask_index = spr_bat_mask;
		sprite_index = spr_bat_wall;
		collide();
			
		if hinputs == -wall_dir { coyote_wall_stick -= delta; }
		apply_spd();
		
		if coyote_wall_stick < 0 || place_free(x + wall_dir, y) { state.change("fall"); }
		else if vsp == 0 { state.change("walk"); }
		else if coyote_press_up > 0
		{
			coyote_press_up = 0;
			state.change("walljump");
		}
	},
	leave: function() { wall_dir = 0; }
});

state.add("walljump",
{
	enter: function()
	{
		vsp = jump_force;
		wall_dir = image_xscale;
		current_wall_force = wall_force * wall_dir;
	},
	step: function()
	{
		//Disabled
		if !agile { state.change("jump"); return; }
		
		var hinputs = input_held[KEY.RIGHT] - input_held[KEY.LEFT];
		update_hsp();
		update_vsp();
		
		var prev_sign = sign(current_wall_force);
		current_wall_force -= wall_force * wall_dir * delta * 3;
		if sign(current_wall_force) != prev_sign && hinputs != wall_dir { current_wall_force = 0; }
		
		//Don't jump as far when moving in the opposite direction as the wall
		if hinputs == -wall_dir
		{
			current_wall_force = clamp(current_wall_force, wall_force/2, -wall_force/2);
		}
		
		hsp += current_wall_force * delta;
			
		check_attack();
		mask_index = spr_bat_mask;
		collide();
			
		if !attacking { sprite_index = spr_bat_jump; }
		apply_spd();
		
		if !input_held[KEY.UP] || vsp >= 0
		{
			vsp = 0;
			state.change("fall");
		}
	},
	leave: function()
	{
		wall_dir = 0;
		current_wall_force = 0;
	}
});

state.add("slide",
{
	enter: function() { slide_dir = image_xscale; },
	step: function()
	{
		//Disabled
		if !agile { state.change("walk"); return; }
		
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
		
		hsp = slide_dir * slide_spd * delta;
		update_vsp();
		
		mask_index = spr_bat_mask_small;
		sprite_index = spr_bat_slide;
		collide();
		
		if hsp == 0 { slide_dir *= -1; } //Change direction
		apply_spd();
		
		mask_index = spr_bat_mask;
		if place_free(x, y) && !input_held[KEY.DOWN]
			{ state.change(place_free(x, y + 1) ? "fall" : "walk"); }
		else { mask_index = spr_bat_mask_small; }
	},
	leave: function() { slide_dir = 0; }
});

state.add("glide",
{
	enter: function()
	{
		glide_dir = image_xscale;
		if near_equals(vsp, 0, 4) { vsp = 0; }
	},
	step: function()
	{
		//Disabled
		if !agile { state.change("fall"); return; }
		
		hsp = glide_dir * glide_spd * delta;
		vsp = lerp_delta(vsp, 0, 0.995);
		
		mask_index = spr_bat_mask_small;
		sprite_index = spr_bat_glide;
		collide();
		
		if hsp == 0 { glide_dir *= -1; } //Change direction
		apply_spd();
		
		mask_index = spr_bat_mask;
		if place_free(x, y) && !place_free(x, y + 1) { state.change("walk"); }
		else if place_free(x, y) && !input_held[KEY.UP] { state.change("fall"); }
		else { mask_index = spr_bat_mask_small; }
	},
	leave: function() { glide_dir = 0; }
});

state.add("knockback",
{
	enter: function()
	{
		hsp = 0;
		vsp = 0;
		sprite_index = spr_bat_knockback;
		reset_action("knockback_jump");
	},
	step: function()
	{
		knockback_delay -= delta;
		if knockback_delay > 0 { return; }
			
		if !done_action("knockback_jump") { vsp = current_knockback_v_force; }
		
		hsp = current_knockback_h_force * delta;
		update_vsp();
			
		mask_index = spr_bat_mask;
		sprite_index = spr_bat_knockback;
		collide();
			
		if hsp == 0 { current_knockback_h_force *= -1; }
			
		if !place_free(x, y + 1) && vsp >= 0
		{
			current_knockback_h_force /= 2;
			current_knockback_v_force /= 2;
			vsp = current_knockback_v_force;
		}
			
		apply_spd();
		
		if near_equals(current_knockback_h_force, 0, 4) &&
		near_equals(current_knockback_v_force, 0, 0.1)
		{ state.change("walk"); }
	}
});

state.add("ghost",
{
	enter: function()
	{
		hp = 0;
		revive_xstart = x;
		revive_ystart = y;
		revive_time = 0;
		if current_arena
		{
			arena_place = current_arena.available_place;
			current_arena.available_place--;
		}
	},
	step: function()
	{
		if instance_exists(obj_lava)
		{
			update_hsp();
			vsp = 0;
			y = lerp_delta(y, obj_lava.bbox_top - 20, 0.99);
			
			apply_spd();
			x = clamp(x, abs(sprite_xoffset), room_width - abs(sprite_xoffset));
			
			if !instance_exists(obj_client)
			{
				var checkpoint = instance_place(x, y, obj_checkpoint);
				if checkpoint && checkpoint.glow_player[client_id + 1]
				{
					checkpoint.mask_index = spr_checkpoint;
					if place_meeting(x, y, checkpoint)
					{
						x = checkpoint.x;
						y = checkpoint.y;
						state.change("walk");
					}
					checkpoint.mask_index = spr_checkpoint_glow;
					
					if state.get_current_state() != "ghost" { return; }
				}
			}
		}
		else
		{
			revive_time += DELTA;
			x = exponential_in(revive_xstart, instance_exists(last_checkpoint) ?
				last_checkpoint.x : xstart, revive_time, 3);
			y = exponential_in(revive_ystart, instance_exists(last_checkpoint) ?
				last_checkpoint.y : ystart, revive_time, 3);
			if !instance_exists(obj_client) && revive_time >= 1 { state.change("walk"); return; }
		}
			
		image_alpha = 0.5;
		mask_index = spr_bat_mask;
		sprite_index = spr_bat_ghost;
	},
	leave: function()
	{
		image_alpha = 1;
		lowest_y = min(lowest_y, y);
		hp = 100;
	}
});