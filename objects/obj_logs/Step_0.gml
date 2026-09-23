array_push(obj_mouse.mouseables, id);

scrollbar.xstart = bbox_left + 2;
scrollbar.ystart = bbox_top + 2;

draw_set_font(fnt_small);
scrollbar.content_height = log_data(false);
draw_set_font(fnt_default);

if got_signal("hovered")
{
	stop_signal("hovered");
	scrollbar.register_scroll_wheel(20);
}