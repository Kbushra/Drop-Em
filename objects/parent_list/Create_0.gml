event_user(0);

close_timer = 0;

xoffsets = [0];
yoffsets = [0];
width = 0;
height = 0;
prev_el = noone;

array_foreach(elements, function(el, ind)
{
	calculate_offsets(el, ind, prev_el);
	
	var targ_x = x + xoffsets[ind];
	el.targ_y = y + yoffsets[ind];
	if instant_spawn { el.create(targ_x, el.targ_y); }
	else { el.create(targ_x, 0); el.inst.y = -el.inst.sprite_height - 16; }
	
	prev_el = el;
});

calculate_dimensions();