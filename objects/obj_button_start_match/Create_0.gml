if !instance_exists(obj_server) { instance_destroy(); exit; }

func = function()
{
	if !visible { return; }
	
	instance_create_depth(x, y, depth, obj_lava);
	instance_destroy();
}