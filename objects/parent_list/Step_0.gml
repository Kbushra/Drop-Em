if close
{
	started_close = !done_action("close");
	close_timer += DELTA;
	
	array_foreach(elements, function(el, ind)
	{
		if started_close
			el.target(irandom_range(-el.height() - 16, -el.height() - 48));
		el.disable();
		if close_timer >= 1 { instance_destroy(el.inst); }
	});
	
	if close_timer >= 1 { instance_destroy(); }
}
else
{
	array_foreach(elements, function(el, ind)
	{
		el.target(y + yoffsets[ind]);
	});
}