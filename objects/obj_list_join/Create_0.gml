elements =
[
	new tab("BACK", function()
	{
		close = true;
		instance_create_depth(x, y, depth, obj_list_main);
	}),
	new element(obj_lobby_board, 8)
];

event_inherited();

var ind = add_element(new element(obj_logs), 320, 0);
spawn_element(noone, elements[ind], ind);