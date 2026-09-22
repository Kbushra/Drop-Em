///@desc Methods

///@func server_data()
server_data = function()
{
	return
	{
		client_id,
		hp,
		_score,
		state_name: state.get_current_state(),
		
		knockback_delay,
		current_knockback_h_force,
		current_knockback_v_force,
		
		attacking,
		attack_cooldown,
		inv_frames
	};
}

///@func move_free(axis, sign_only)
move_free = function(axis, sign_only)
{
	var _hsp = sign_only ? sign(hsp) : hsp;
	var _vsp = sign_only ? sign(vsp) : vsp;
	var change_x = axis == VERTICAL ? 0 : _hsp;
	var change_y = axis == HORIZONTAL ? 0 : _vsp;
	
	if change_x == 0 && change_y == 0 { return true; } //Prevent getting stuck just incase
	return place_free(x + change_x, y + change_y);
}

///@func update_hsp()
update_hsp = function()
{
	var _spd = agile ? spd : slow_spd;
	hsp = (input_held[KEY.RIGHT] - input_held[KEY.LEFT]) * _spd * delta;
	if hsp != 0 { image_xscale = sign(hsp); }
}

///@func update_vsp()
update_vsp = function()
{
	if vsp < 0 { vsp += up_grv * delta; } else { vsp += down_grv * delta; }
	vsp = clamp(vsp, -99, 15);
}

///@func collide()
collide = function()
{
	if !move_free(HORIZONTAL, false)
	{
		while move_free(HORIZONTAL, true) { x += sign(hsp); }
		hsp = 0;
	}
	
	if !move_free(VERTICAL, false)
	{
		while move_free(VERTICAL, true) { y += sign(vsp); }
		vsp = 0;
	}
}

///@func apply_spd()
apply_spd = function()
{
	x += hsp;
	y += vsp;
	if hsp != 0 { image_xscale = sign(hsp); }
}

///@func setup_coyotes()
setup_coyotes = function() {}

///@func control_score()
control_score = function() { if _score < 0 { _score = 0; } }

///@func reduce_timers()
reduce_timers = function() {}

///@func inv_blend()
inv_blend = function()
{
	if inv_frames <= 0 || state == knockback_state { image_blend = c_white; }
	else { image_blend = true_mod(inv_frames, 0.2) > 0.1 ? c_red : c_white; }
}

///@func record_pos()
record_pos = function()
{
	positions[$ current_time/1000] = new coordinate(x, y);
	
	var times = struct_get_names(positions);
	for (var i = 0; i < array_length(times); i++)
	{
		//Remove all from a second ago to avoid too much memory use
		if real(times[i]) < current_time/1000 - 1 { struct_remove(positions, times[i]); }
	}
}

///@func fetch_late_pos(time_ago)
fetch_late_pos = function(time_ago)
{
	var times = struct_get_names(positions);
	return positions[$ closest_num(times, current_time/1000 - time_ago)];
}

///@func do_step()
do_step = function()
{
	setup_coyotes();

	state.step();

	control_score();
	reduce_timers();

	if attacking { attack_logic(); }

	inv_blend();
	record_pos();
}