func = function()
{
	instance_create_depth(x, y, depth, obj_connection);
	if !instance_exists(obj_connection) { return; } //Can't make sockets
	
	instance_create_depth(x, 64, depth, obj_type_box_join);
	instance_destroy(obj_button);
}