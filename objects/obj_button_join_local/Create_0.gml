func = function()
{
	instance_create_depth(x, y, depth, obj_connection);
	if !instance_exists(obj_connection) { return; } //Port not available
	
	instance_create_depth(room_width/2, room_height/2, depth, obj_panel_lan);
	instance_destroy(obj_button);
}