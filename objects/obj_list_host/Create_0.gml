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

elements =
[
	new tab("BACK", function() { close = true; instance_create_depth(x, y, depth, obj_list_main); }),
	new type_box(NONE, "LOBBY NAME", special_chars, function(inst)
	{
		if string_length(inst.typed_string) == 0 { exit; }
	
		instance_create_depth(x, y, depth, obj_connection,
			{ create_object: obj_host, create_vars: { name: inst.typed_string } });
	})
];

event_inherited();