elements =
[
	new tab("HOST", function() { close = true; instance_create_depth(x, y, depth, obj_list_host); }),
	new tab("JOIN", function()
	{
		close = true;
		instance_create_depth(x, y, depth, obj_list_join);
	}),
	new empty_space(32),
	new tab("TUTORIAL", function() { transition(CURR_MAP.tutorial_room); }),
	new tab("MAPS", function()
	{
		close = true;
		instance_create_depth(x, y, depth, obj_list_maps);
	}),
	new empty_space(32),
	new tab("QUIT", function() { transition(rm_quit); }),
];

event_inherited();