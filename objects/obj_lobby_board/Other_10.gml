///@desc Methods

///@func update_text()
update_text = function()
{
	var top = bbox_top + 2 + code_element.height();
	for (var i = 0; i < array_length(text); i++) { instance_destroy(text[i]); }
	for (var i = 0; i < array_length(obj_client.hosts); i++)
	{
		var host_photo = get_data_level(obj_client.hosts[i]);
		if host_photo == noone { continue; }
		
		var xpos = bbox_left + sprite_get_width(host_photo.vars.sprite) + 2;
		text[i] = instance_create_depth(xpos,
		top, depth - 1, obj_text_container,
		{
			image_xscale: bbox_right - xpos - 1,
			text: obj_client.hosts[i].server_name,
			func: method({ join_code: obj_client.hosts[i].join_code }, function()
			{
				with obj_logs { array_push(logs, "Using a public lobby..."); }
				network_send_struct(obj_client.wss, NETWORK_TYPES.JOIN,
				{
					join_code,
					player_name: global.save.player_name
				});
			})
		});
	
		top += string_height(obj_client.hosts[i].server_name);
	}
}