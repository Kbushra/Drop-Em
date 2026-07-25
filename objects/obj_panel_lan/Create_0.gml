image_xscale = 3;
image_yscale = 4;
obj_connection.alarm[0] = 1;

prev_server_names = [];
server_text = [];

instance_create_depth(bbox_left + 20, bbox_top + 20, depth - 1, obj_text_container,
{
	image_xscale: sprite_width - 40,
	text: "BACK",
	func: function()
	{
		obj_main_menu.create_buttons();
		instance_destroy(obj_connection);
		instance_destroy(obj_panel_lan);
		instance_destroy(obj_text_container);
	}
})