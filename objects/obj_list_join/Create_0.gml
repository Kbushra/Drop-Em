elements =
[
	new button("BACK", function()
	{
		close = true;
		instance_create_depth(x, y, depth, obj_list_main);
		instance_destroy(obj_connection);
		instance_destroy(obj_client);
	}),
	new type_box(6, "JOIN CODE", [], function(inst)
	{
		if string_length(inst.typed_string) != 6 || !instance_exists(obj_client) { exit; }
		network_send_struct(obj_client.wss, NETWORK_TYPES.JOIN, { join_code: inst.typed_string });
	}),
	new element(obj_lobby_board, 8)
];

event_inherited();