if close
{
	array_foreach(elements, function(el, ind)
	{
		if close_timer == 0
			el.target(irandom_range(-el.height() - 16, -el.height() - 48));
		el.disable();
		if close_timer >= 1 { instance_destroy(el.inst); }
	});
	
	close_timer += DELTA;
	if close_timer >= 1 { instance_destroy(); }
}
else
{
	array_foreach(elements, function(el, ind)
	{
		el.target(y + yoffsets[ind]);
	});
}