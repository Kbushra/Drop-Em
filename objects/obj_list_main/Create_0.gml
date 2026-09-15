elements =
[
	new tab("HOST", function() { close = true; instance_create_depth(x, y, depth, obj_list_host); }),
	new tab("JOIN", function()
	{
		close = true;
		instance_create_depth(x, y, depth, obj_list_join);
		instance_create_depth(x, y, depth, obj_connection, { create_object: obj_client });
	}),
	new empty_space(48),
	new tab("TUTORIAL", function() { room_goto(global.curr_map.tutorial_room); })
];

event_inherited();