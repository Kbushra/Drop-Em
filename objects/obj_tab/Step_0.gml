depth = -100;
array_push(obj_mouse.mouseables, id);

var enabled = !got_signal("disable");
stop_signal("disable");

if !enabled
{
	stop_signal("pressed");
	stop_signal("hovered");
}

if got_signal("pressed")
{
	stop_signal("pressed");
	func();
}
else if got_signal("hovered")
{
	stop_signal("hovered");
	x = lerp_delta(x, xstart + 20, 0.995);
}
else
{
	x = lerp_delta(x, xstart, 0.995);
}