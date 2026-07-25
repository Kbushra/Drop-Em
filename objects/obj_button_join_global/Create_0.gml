func = function()
{
	instance_create_depth(x, y, depth, obj_connection);
	if !instance_exists(obj_connection) { return; } //Can't make sockets
	
	instance_destroy(obj_button);
	instance_create_depth(x, 64, depth, obj_button_join_global_back);
	instance_create_depth(x, 64 + 80, depth, obj_type_box_join);
}