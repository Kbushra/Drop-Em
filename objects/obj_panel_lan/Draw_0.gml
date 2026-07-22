draw_self();

draw_text(bbox_left + 20, bbox_top + 20, "BACK");

var server_names = struct_get_names(obj_connection.servers);
array_sort(server_names, function(curr, next)
{
	return obj_connection.servers[$ curr].creation_time -
		obj_connection.servers[$ next].creation_time;
});

for (var i = 0; i < array_length(server_names); i++)
{
	draw_text(bbox_left + 20, bbox_top + 50 + 30 * i, server_names[i]);
}