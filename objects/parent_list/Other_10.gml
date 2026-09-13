///@desc Methods

///@func calculate_offsets(el, ind, prev_el)
calculate_offsets = function(el, ind, prev_el)
{
	if ind == 0 { return; }
	
	xoffsets[ind] = 0;
	yoffsets[ind] = 0;
	if dir == HORIZONTAL || dir == GRID
		xoffsets[ind] = xoffsets[ind - 1] + prev_el.inst.sprite_width + max(prev_el.gap, el.gap);
	if dir == VERTICAL || dir == GRID
		yoffsets[ind] = yoffsets[ind - 1] + prev_el.inst.sprite_height + max(prev_el.gap, el.gap);
}

///@func calculate_dimensions()
calculate_dimensions = function()
{
	width = array_last(xoffsets) + prev_el.inst.sprite_width;
	height = array_last(yoffsets) + prev_el.inst.sprite_height;
}