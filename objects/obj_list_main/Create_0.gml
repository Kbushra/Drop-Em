elements =
[
	new button("HOST", function() { close = true; instance_create_depth(x, y, depth, obj_list_host); }),
	new button("JOIN", function()
	{
		close = true;
		instance_create_depth(x, y, depth, obj_list_join);
		instance_create_depth(x, y, depth, obj_connection, { create_object: obj_client });
	}),
	new button("TEST", function() { room_goto(rm_playground); })
];

event_inherited();