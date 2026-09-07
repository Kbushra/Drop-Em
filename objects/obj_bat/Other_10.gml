///@desc Methods
event_inherited();

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