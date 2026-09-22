var height = get_scrollbar_height(content_height, container_height, scrollbar_container_height);
image_yscale = height / sprite_get_height(spr_scrollbar);

if got_signal("pressed")
{
	stop_signal("pressed");
	prev_mouse_y = mouse_y;
}

if got_signal("held")
{
	stop_signal("held");
	scroll = mouse_y - prev_mouse_y;
	scroll = clamp(scroll, 0, scrollbar_container_height - height);
	prev_mouse_y = mouse_y;
}

x = xstart;
y = ystart + scroll;
content_scroll = get_content_scroll(content_height, container_height,
	scrollbar_container_height, scroll);