if !instance_exists(obj_server) { instance_destroy(); exit; }
image_xscale = 3;
image_yscale = 4;

instance_create_depth(x, bbox_top + 20, depth - 1, obj_text_container,
{
	xalign: fa_center,
	halign: fa_center,
	text: $"(CLICK TO COPY)\nGLOBAL JOIN CODE: {obj_server.join_code}",
	func: function()
	{
		clipboard_set_text(obj_server.join_code);
		instance_destroy(obj_panel_hosting);
		instance_destroy(obj_text_container);
	}
});