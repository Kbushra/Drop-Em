array_push(obj_mouse.mouseables, id);

height = get_scrollbar_height(SCROLL_PARAMS);
image_yscale = height / sprite_get_height(spr_scrollbar);

if got_signal("pressed")
{
	stop_signal("pressed");
	prev_mouse_y = mouse_y;
	held = true;
}

if mouse_check_button_released(mb_left) { held = false; }

if held
{
	var scroll = get_scrollbar_scroll(SCROLL_PARAMS, content_scroll) + mouse_y - prev_mouse_y;
	scroll = clamp(scroll, 0, scrollbar_container_height - height);
	content_scroll = get_content_scroll(SCROLL_PARAMS, scroll);
	
	prev_mouse_y = mouse_y;
	sticky = false;
}

if sticky && content_height - container_height > 0
	{ content_scroll = content_height - container_height; }

if content_scroll == max(content_height - container_height, 0) { sticky = true; }

x = xstart;
y = ystart + get_scrollbar_scroll(SCROLL_PARAMS, content_scroll);