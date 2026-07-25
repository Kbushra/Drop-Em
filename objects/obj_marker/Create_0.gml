if object_name == object_get_name(obj_player)
{
	instance_create_depth(x, y, depth, obj_marker_player, get_object_data({ client_id }));
	instance_destroy();
	exit;
}