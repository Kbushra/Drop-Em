elements =
[
	new tab("BACK", function()
	{
		close = true;
		instance_create_depth(x, y, depth, obj_list_main);
		instance_destroy(obj_connection);
		instance_destroy(obj_client);
	}),
	new element(obj_lobby_board, 8)
];

event_inherited();