event_inherited();

special_allowed_chars = [ord("'"), vk_space];

func = function()
{
	if string_length(typed_string) == 0 { exit; }
	
	instance_create_depth(x, y, depth, obj_connection,
		{ create_object: obj_host, create_vars: { name: typed_string } });
}