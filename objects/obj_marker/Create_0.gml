///@func switch_marker(object, extra)
switch_marker = function(obj, extra)
{
	obj_connection.markers[$ _id] =
		instance_create_depth(x, y, depth, obj, get_object_data(extra));
	
	instance_destroy();
}