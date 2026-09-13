elements =
[
	new tab("HOST", function() { close = true; instance_create_depth(x, y, depth, obj_list_host); }),
	new tab("JOIN", function()
	{
		close = true;
		instance_create_depth(x, y, depth, obj_list_join);
		instance_create_depth(x, y, depth, obj_connection, { create_object: obj_client });
	}),
	new tab("TEST", function() { room_goto(rm_cave_tutorial); })
];

event_inherited();