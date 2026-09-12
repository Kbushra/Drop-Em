close_timer = 0;

yoffsets = [0];
prev_el = noone;

array_foreach(elements, function(el, ind)
{
	if ind > 0 { yoffsets[ind] += max(prev_el.gap, el.gap); }
	
	el.targ_y = y + yoffsets[ind];
	if instant_spawn { el.create(x, el.targ_y); }
	else { el.create(x, 0); el.inst.y = -el.inst.sprite_height - 16; }
	
	yoffsets[ind + 1] = yoffsets[ind] + el.inst.sprite_height;
	prev_el = el;
});