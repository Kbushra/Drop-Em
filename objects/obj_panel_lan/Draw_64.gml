draw_self();

server_ips = array_map(obj_connection.servers, function(el) { return el.ip; });
if array_equals(prev_server_ips, server_ips) { exit; }

prev_server_ips = variable_clone(server_ips);
	
var top = bbox_top + 20 + string_height("BACK");
for (var i = 0; i < array_length(server_text); i++) { instance_destroy(server_text[i]); }
for (var i = 0; i < array_length(obj_connection.servers); i++)
{
	instance_create_depth(bbox_left + 20, top, depth - 1, obj_text_container,
	{
		image_xscale: sprite_width - 40,
		text: obj_connection.servers[i].name,
		func: method({ i }, function()
		{
			if obj_connection.server_ip != "" { return; }
				
			obj_connection.server_ip = obj_connection.servers[i].ip;
			network_connect_async(obj_connection.tcp, obj_connection.server_ip, PORT);
		})
	});
	top += string_height(server_names[i]);
}