var is_player = object_name == object_get_name(obj_player) ||
	object_get_parent(asset_get_index(object_name)) == obj_player;

if is_player && client_id == obj_connection.client_id
{
	obj_connection.markers[$ _id] =
		instance_create_depth(x, y, depth, obj_marker_client, get_object_data({ _id, client_id }));
	
	instance_destroy();
	exit;
}