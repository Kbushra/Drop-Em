///@desc Methods

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
	hsp = (input_held[KEY.RIGHT] - input_held[KEY.LEFT]) * _spd * DELTA;
}

///@func update_vsp()
update_vsp = function()
{
	if vsp < 0 { vsp += up_grv * DELTA; } else { vsp += down_grv * DELTA; }
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