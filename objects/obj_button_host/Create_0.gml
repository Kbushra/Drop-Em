func = function()
{
	instance_destroy(obj_button);
	instance_create_depth(x, 64, depth, obj_button_back, { pop: false });
	instance_create_depth(x, 64 + 80, depth, obj_type_box_host);
}