if !instance_exists(obj_host) { instance_destroy(); exit; }

var code_text = $"(CLICK TO COPY)\nJOIN CODE: {obj_host.join_code}";
instance_create_depth(room_width - 5, 5, depth - 1, obj_text_container,
{
	xalign: fa_right,
	halign: fa_right,
	text: code_text,
	func: function()
	{
		clipboard_set_text(obj_host.join_code);
	}
});

instance_create_depth(room_width - 5, 5 + string_height(code_text), depth - 1, obj_text_container,
{
	xalign: fa_right,
	halign: fa_right,
	text: "START MATCH",
	func: function()
	{
		instance_create_depth(x, y, depth, obj_lava);
		instance_destroy(obj_text_container);
	}
});

instance_destroy();