var special_chars =
[
	ord(","), ord("<"),
	ord("."), ord(">"),
	ord("/"), ord("?"),
	ord(";"), ord(":"),
	ord("'"), ord("@"),
	ord("#"), ord("~"),
	ord("["), ord("{"),
	ord("]"), ord("}"),
	ord("\\"), ord("|"),
	ord("-"), ord("_"),
	ord("="), ord("+"),
	ord("`"), /*ord("¬"), ord("¦"),*/
	ord("!"), ord("\\"), /*ord("£"),*/ ord("$"), ord("%"),
	ord("^"), ord("&"), ord("*"), ord("("), ord(")"),
	
	vk_space
];

photo_list = instance_create_depth(x, y + 64, depth,
	obj_list_horizontal, { elements: global.curr_map.level_photos });

elements =
[
	new tab("BACK", function()
	{
		close = true;
		photo_list.close = true;
		instance_create_depth(x, y, depth, obj_list_main);
	}),
	new empty_space(48),
	new type_box(NONE, "LOBBY NAME", special_chars, function(inst)
	{
		if string_length(inst.typed_string) == 0 { exit; }
	
		instance_create_depth(x, y, depth, obj_connection,
			{ create_object: obj_host, create_vars: { name: inst.typed_string } });
	})
];

event_inherited();