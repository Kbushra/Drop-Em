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
		if state.get_current_state() != "ghost" { _score += (lowest_y - y)/5; }
		lowest_y = y;
	}
}

reduce_timers = function()
{
	attack_cooldown -= delta;
	coyote_press_up -= delta;
	coyote_press_down -= delta;
	coyote_fall -= delta;
	
	if state.get_current_state() != "knockback" { inv_frames -= delta; }
}

inherited_step = do_step;
do_step = function()
{
	inherited_step();
	
	var checkpoint = instance_place(x, y, obj_checkpoint);
	if instance_exists(checkpoint) { last_checkpoint = checkpoint; }
	
	if instance_exists(obj_client) { return; }
	
	if instance_exists(obj_lava)
	{
		var yoffset = client_id == -1 ? 0 : LATENCY * obj_lava.spd;
		var hitting_lava = obj_lava.colliding(yoffset) && state.get_current_state() != "ghost";
	
		if hitting_lava
		{
			hp = 0;
			_score -= 100;
			if _score < 0 { _score = 0; }
		}
	}
	
	if hp <= 0 && state.get_current_state() != "ghost" { state.change("ghost"); }
}