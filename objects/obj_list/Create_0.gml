close_timer = 0;

y_positions = [start_y];
prev_el = noone;
max_height = 0;

array_foreach(elements, function(el, ind)
{
	if ind > 0 { y_positions[ind] = prev_el.targ_y + prev_el.inst.sprite_height + max(prev_el.gap, el.gap); }
	el.targ_y = y_positions[ind];
	
	if instant_spawn { el.create(el.targ_y); }
	else { el.create(irandom_range(-96, -64)); }
	
	max_height = max(max_height, el.inst.sprite_height);
	prev_el = el;
});