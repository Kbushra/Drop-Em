event_inherited();

special_allowed_chars = [ord("'"), vk_space];

func = function()
{
	if string_length(typed_string) == 0 { exit; }
	
	obj_main_menu.active_ui = false;
	instance_create_depth(x, y, depth, obj_client,
		{ create_object: obj_host, create_vars: { name: typed_string } });
}