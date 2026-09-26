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
	new tab("QUIT", function() { transition(noone, game_end); }),
];

event_inherited();

var name_box_ind = add_element(new type_box(-1, "PLAYER NAME", all_special_chars(), empty), 320, 0);
name_box = elements[name_box_ind];
spawn_element(noone, name_box, name_box_ind);
name_box.inst.typed_string = global.save.player_name;