draw_self();

if !instance_exists(obj_client) { exit; }

var join_codes = array_map(obj_client.hosts, function(el) { return el.join_code; });
if array_equals(prev_join_codes, join_codes) { exit; }

prev_join_codes = join_codes;

var top = bbox_top + 20;
for (var i = 0; i < array_length(text); i++) { instance_destroy(text[i]); }
for (var i = 0; i < array_length(obj_client.hosts); i++)
{
	text[i] = instance_create_depth(bbox_left + 20, top, depth - 1, obj_text_container,
	{
		image_xscale: sprite_width - 40,
		text: obj_client.hosts[i].name,
		func: method({ join_code: obj_client.hosts[i].join_code }, function()
		{
			obj_main_menu.active_ui = false;
			network_send_struct(obj_client.wss, NETWORK_TYPES.JOIN, { join_code });
		})
	});
	
	top += string_height(name);
}