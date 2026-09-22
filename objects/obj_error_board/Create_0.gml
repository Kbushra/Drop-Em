scrollbar = instance_create_depth(bbox_left + 2, bbox_top + 2, depth - 1, obj_scrollbar,
	{ content_height: 0, container_height: bbox_top - bbox_bottom,
	scrollbar_container_height: bbox_top - bbox_bottom - 4 });