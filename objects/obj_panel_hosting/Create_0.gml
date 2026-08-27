if !instance_exists(obj_host) { instance_destroy(); exit; }
image_xscale = 1;
image_yscale = 2;

instance_create_depth(x, y, depth - 1, obj_text_container,
{
	xalign: fa_center,
	halign: fa_center,
	text: $"(CLICK TO COPY)\nGLOBAL JOIN CODE: {obj_host.join_code}",
	func: function()
	{
		clipboard_set_text(obj_host.join_code);
		instance_destroy(obj_panel_hosting);
		instance_destroy(obj_text_container);
	}
});