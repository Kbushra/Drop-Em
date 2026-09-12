if close
{
	array_foreach(elements, function(el, ind)
	{
		if close_timer == 0
			el.targ_y = irandom_range(-el.inst.sprite_height - 16, -el.inst.sprite_height - 48);
		el.approach().disable();
		if close_timer >= 1 { instance_destroy(el.inst); }
	});
	
	close_timer += DELTA;
	if close_timer >= 1 { instance_destroy(); }
}
else
{
	array_foreach(elements, function(el, ind)
	{
		el.targ_y = y + yoffsets[ind];
		el.approach();
	});
}