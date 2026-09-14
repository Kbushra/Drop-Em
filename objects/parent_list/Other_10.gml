///@desc Methods

///@func calculate_offsets(prev_el, el, ind)
calculate_offsets = function(prev_el, el, ind)
{
	if index_defined(xoffsets, ind) && index_defined(yoffsets, ind) { return; }
	
	xoffsets[ind] = 0;
	yoffsets[ind] = 0;
	if ind == 0 { return; }
	
	if dir == HORIZONTAL || dir == GRID
		xoffsets[ind] = xoffsets[ind - 1] + prev_el.width() + max(prev_el.gap, el.gap);
	if dir == VERTICAL || dir == GRID
		yoffsets[ind] = yoffsets[ind - 1] + prev_el.height() + max(prev_el.gap, el.gap);
}

///@func calculate_dimensions()
calculate_dimensions = function()
{
	width = array_last(xoffsets) + array_last(elements).width();
	height = array_last(yoffsets) + array_last(elements).height();
}

///@func add_element(el, xoffset, yoffset)
add_element = function(el, xoffset, yoffset)
{
	array_push(elements, el);
	array_push(xoffsets, xoffset);
	array_push(yoffsets, yoffset);
	return array_length(elements) - 1; //index
}

///@func spawn_element(prev_el, el, ind)
spawn_element = function(prev_el, el, ind)
{
	calculate_offsets(prev_el, el, ind);
	
	var targ_x = x + xoffsets[ind];
	el.target(y + yoffsets[ind]);
	if instant_spawn { el.create(targ_x, el.targ_y); }
	else
	{
		el.create(targ_x, 0);
		if instance_exists(el.inst) { el.inst.y = -el.height() - 16; }
	}
	
	return el;
}