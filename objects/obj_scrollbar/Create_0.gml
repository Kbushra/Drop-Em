content_scroll = 0;
height = 0;

prev_mouse_y = mouse_y;
held = false;

sticky = true;

///@func register_scroll_wheel(spd)
register_scroll_wheel = function(spd)
{
	var wheel = mouse_wheel_down() - mouse_wheel_up();
	if content_height - container_height < 0 || wheel == 0 { return; }
	
	content_scroll += wheel * spd;
	content_scroll = clamp(content_scroll, 0, content_height - container_height);
	sticky = false;
}