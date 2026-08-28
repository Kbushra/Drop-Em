if !instance_exists(obj_host) { instance_destroy(); exit; }

image_xscale = 2;
image_yscale = 2;
event_inherited();

instance_create_depth(x + sprite_width/2, y + sprite_height/2, depth - 1, obj_text_container,
{
	xalign: fa_center,
	yalign: fa_center,
	halign: fa_center,
	valign: fa_center,
	text: $"(CLICK TO COPY)\nJOIN CODE: {obj_host.join_code}",
	func: function()
	{
		clipboard_set_text(obj_host.join_code);
		instance_create_depth(320, 48, depth, obj_button_start_match);
		instance_destroy(obj_panel_hosting);
		instance_destroy(obj_text_container);
	}
});