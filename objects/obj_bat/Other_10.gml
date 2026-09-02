///@desc Methods
event_inherited();

server_data = function()
{
	return
	{
		client_id,
		hp,
		_score,
		state,
		
		slide_dir,
		glide_dir,
		current_wall_force,
		wall_dir,
		knockback_delay,
		current_knockback_h_force,
		current_knockback_v_force,

		attacking,
		attack_cooldown,
		inv_frames
	};
}

setup_coyotes = function()
{
	if input_pressed[KEY.UP] { coyote_press_up = 0.2; }
	if input_pressed[KEY.DOWN] { coyote_press_down = 0.2; }
}

control_score = function()
{
	if instance_exists(obj_lava) && y < lowest_y
	{
		if state != BAT_STATES.GHOST { _score += (lowest_y - y)/5; }
		lowest_y = y;
	}
}

reduce_timers = function()
{
	attack_cooldown -= delta;
	coyote_press_up -= delta;
	coyote_press_down -= delta;
	coyote_fall -= delta;
	
	if state != BAT_STATES.KNOCKBACK { inv_frames -= delta; }
}