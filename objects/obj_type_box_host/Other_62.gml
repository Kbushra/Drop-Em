if async_load[? "id"] != ip_request || async_load[? "status"] != 0 { exit; }

instance_create_depth(x, y, depth, obj_server, { public_ip: async_load[? "result"], name: typed_string });
if !instance_exists(obj_server) { exit; } //Port not available
	
room_goto(rm_level_1);