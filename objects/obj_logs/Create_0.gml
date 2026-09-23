image_xscale = 1.5;
image_yscale = 1.5;

scrollbar = instance_create_depth(bbox_left + 2, bbox_top + 2, depth - 1, obj_scrollbar,
	{ content_height: 0, container_height: bbox_bottom - bbox_top,
	scrollbar_container_height: bbox_bottom - bbox_top - 4 });

logs = ["LOGS----------------------------"];

///@func log_data(draw)
log_data = function(draw)
{
	var top = bbox_top + 2 - scrollbar.content_scroll;
	var height = 0;
	
	for (var i = 0; i < array_length(logs); i++)
	{
		if draw
		{
			if string_length(logs[i]) >= 6 && string_copy(logs[i], 1, 6) == "ERROR:"
				{ draw_set_colour(c_red); }
			draw_text_ext(bbox_left + 8, top + height, logs[i], 20, bbox_right - bbox_left - 12);
			draw_set_colour(c_white);
		}
		
		height += string_height_ext(logs[i], 20, bbox_right - bbox_left - 12);
		if i != array_length(logs) - 1 { height += 4; }
	}
	
	return height;
}