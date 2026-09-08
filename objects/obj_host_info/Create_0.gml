if !instance_exists(obj_host) { instance_destroy(); exit; }

var code_text = $"(CLICK TO COPY)\nJOIN CODE: {obj_host.join_code}";
text[0] = instance_create_depth(room_width - 5, 5, depth - 1, obj_text_container,
{
	xalign: fa_right,
	halign: fa_right,
	text: code_text,
	func: function()
	{
		clipboard_set_text(obj_host.join_code);
	}
});

text[1] = instance_create_depth(room_width - 5, 5 + string_height(code_text), depth - 1, obj_text_container,
{
	xalign: fa_right,
	halign: fa_right,
	text: "START MATCH",
	func: method({ text }, function()
	{
		instance_create_layer(0, 0, "Global", obj_lava);
		instance_destroy(text[0]);
		instance_destroy(text[1]);
	})
});

instance_destroy();