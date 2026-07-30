draw_self();

var server_names = struct_get_names(obj_connection.servers);
array_sort(server_names, function(curr, next)
{
	return obj_connection.servers[$ curr].creation_time -
		obj_connection.servers[$ next].creation_time;
});

if !array_equals(prev_server_names, server_names)
{
	prev_server_names = variable_clone(server_names);
	
	var top = bbox_top + 20 + string_height("BACK");
	for (var i = 0; i < array_length(server_text); i++) { instance_destroy(server_text[i]); }
	for (var i = 0; i < array_length(server_names); i++)
	{
		instance_create_depth(bbox_left + 20, top, depth - 1, obj_text_container,
		{
			image_xscale: sprite_width - 40,
			text: server_names[i],
			func: function()
			{
				if obj_connection.server_ip != "" { return; }
				
				obj_connection.server_ip = obj_connection.servers[$ text].ip;
				network_connect_async(obj_connection.tcp, obj_connection.server_ip, PORT);
			}
		});
		top += string_height(server_names[i]);
	}
}