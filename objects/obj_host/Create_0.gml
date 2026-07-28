if !instance_exists(obj_server) { instance_destroy(); exit; }
player = instance_create_depth(x, y, depth, obj_bat);