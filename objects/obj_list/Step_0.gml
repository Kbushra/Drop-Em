if close
{
	close_timer += DELTA;
	
	array_foreach(elements, function(el, ind)
	{
		el.targ_y = irandom_range(-max_height * 1.5, -max_height * 1.5 - 32);
		el.approach().disable();
		if close_timer >= 1 { instance_destroy(el.inst); }
	});
	
	if close_timer >= 1 { instance_destroy(); }
}
else
{
	array_foreach(elements, function(el, ind)
	{
		el.targ_y = y_positions[ind];
		el.approach();
	});
}