if !instance_exists(obj_server) { instance_destroy(); }

open = false;
sprite_xscale = 1;

///@func blocked()
blocked = function()
{
	var prev_xscale = image_xscale;
	image_xscale = 1;
	
	var is_blocked = place_meeting(x, y, obj_player);
	
	image_xscale = prev_xscale;
	return is_blocked;
}