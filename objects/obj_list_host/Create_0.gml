photo_list = instance_create_depth(x, y + 64, depth,
	obj_list_horizontal, { elements: variable_clone(CURR_MAP.level_photos) });

elements =
[
	new tab("BACK", function()
	{
		close = true;
		photo_list.close = true;
		instance_create_depth(x, y, depth, obj_list_main);
	}),
	new empty_space(96),
	new type_box(NONE, "LOBBY NAME", all_special_chars(), function(inst)
	{
		if string_length(inst.typed_string) == 0 ||
		get_focused_photo_index(photo_list) < 0 { exit; }
		
		with obj_logs { array_push(logs, "Joining as a host..."); }
		instance_create_depth(x, y, depth, obj_connection,
		{
			create_object: obj_host,
			create_vars:
			{
				server_name: inst.typed_string,
				level_index: get_focused_photo_index(photo_list)
			}
		});
	})
];

event_inherited();

var ind = add_element(new element(obj_logs), 320, 0);
spawn_element(noone, elements[ind], ind);